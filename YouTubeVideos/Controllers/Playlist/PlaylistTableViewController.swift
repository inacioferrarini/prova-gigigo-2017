//
//  PlaylistTableViewController.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 17/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit
import York
import SDWebImage

class PlaylistTableViewController: AppTableViewController {

    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
        self.refreshPlaylist()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.title = "\(self.appContext.playList?.items?.count ?? 0) Playlists"
        }
    }
    
    func refreshPlaylist() {
        guard let dataSource = self.dataSource as? TableViewArrayDataSource<ItemListTableViewCell, PlayListItem> else { return }
        dataSource.objects = self.appContext.playList?.items ?? [PlayListItem]()
        DispatchQueue.main.async {
            dataSource.refreshData()
        }
    }
    
    
    // MARK: - Data Syncrhonization
    
    override func shouldSyncData() -> Bool {
        return self.appContext.playList == nil
    }
    
    override func syncData() {
        self.fetchAllPlaylists()
    }
    
    func fetchAllPlaylists() {
        let syncDataSemaphore = DispatchSemaphore(value: 0)
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let downloadGroup = DispatchGroup()
            downloadGroup.enter()
            
            self.appContext.apiClient.playlist.all(byUser: self.appContext.userId,
                                                   usingKey: self.appContext.googleApiKey,
                                                   completionBlock:
                { (playlist) in
                    self.appContext.playList = playlist
                    self.updateUI()
                    self.refreshPlaylist()
                    downloadGroup.leave()
                }, errorHandlerBlock:
                { (error) in
                    downloadGroup.leave()
            })
            
            downloadGroup.wait()
            downloadGroup.notify(queue: DispatchQueue.global(qos: .default), execute: {
                syncDataSemaphore.signal()
            })
            syncDataSemaphore.wait()
        }
        
    }
    
    
    // MARK: - BaseTableViewController override
    
    override func createRefreshControl() -> UIRefreshControl? {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor(colorLiteralRed: 203/255, green: 203/255, blue: 203/255, alpha: 1)
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        return refreshControl
    }
    
    override func setupTableView() {
        super.setupTableView()
        
        let reuseCellId = "ItemListTableViewCell"
        self.tableView?.register(UINib(nibName: reuseCellId, bundle: nil),
                                 forCellReuseIdentifier: reuseCellId)
    }
    
    override public func createDataSource() -> UITableViewDataSource? {
        guard let tableView = self.tableView else { return nil }
        let cellReuseIdBlock: ((_ indexPath: IndexPath) -> String) = { (indexPath: IndexPath) -> String in
            return "ItemListTableViewCell"
        }
        
        let presenter = TableViewCellPresenter<ItemListTableViewCell, PlayListItem> (
            configureCellBlock: { (cell: ItemListTableViewCell, structure: PlayListItem) in

                cell.titleLabel.text = structure.snippet?.title ?? "<Sem Título>"
                cell.descriptionLabel.text = structure.snippet?.description ?? "<Sem Descrição>"

                if let imageUrl = structure.snippet?.thumbnails?["standard"]?.url {
                    DispatchQueue.main.async {
                        cell.itemImage.sd_setImage(with: URL(string: imageUrl))
                    }
                }
        }, cellReuseIdentifierBlock: cellReuseIdBlock)
        
        let objects = self.appContext.playList?.items ?? [PlayListItem]()
        let dataSource = TableViewArrayDataSource<ItemListTableViewCell, PlayListItem> (
            targetingTableView: tableView,
            presenter: presenter,
            objects: objects)
        
        return dataSource
    }
    
    override public func createDelegate() -> UITableViewDelegate? {
        guard let tableView = self.tableView else { return nil }
        let delegate = TableViewBlockDelegate(tableView: tableView)
        delegate.itemSelectionBlock = { (indexPath: IndexPath) -> Void in
            guard let dataSource = self.dataSource as? TableViewArrayDataSource<ItemListTableViewCell, PlayListItem> else { return }
            guard let selectedItem = dataSource.objectAtIndexPath(indexPath) else { return }
            self.appContext.selectedPlaylistId = selectedItem.id
            self.performSegue(withIdentifier: "PlaylistItemsTableViewController", sender: self)
        }
        return delegate
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AppTableViewController {
            destination.appContext = self.appContext
        }
    }
    
}
