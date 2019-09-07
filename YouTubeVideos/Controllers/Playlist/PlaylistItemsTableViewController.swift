//
//  PlaylistItemsTableViewController.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 17/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit
import York
import SDWebImage

class PlaylistItemsTableViewController: AppTableViewController {
    
    
    // MARK: - Properties

    var selectedPlayListItem: Playlist? {
        get {
            let selectedPlaylistId = self.appContext.selectedPlaylistId ?? ""
            return self.appContext.playlistItems[selectedPlaylistId]
        }
        set(newSelectedPlayListItem) {
            let selectedPlaylistId = self.appContext.selectedPlaylistId ?? ""
            self.appContext.playlistItems[selectedPlaylistId] = newSelectedPlayListItem
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
        self.refreshPlaylistItems()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.title = "\(self.selectedPlayListItem?.items?.count ?? 0) Vídeos"
        }
    }
    
    func refreshPlaylistItems() {
        guard let dataSource = self.dataSource as? TableViewArrayDataSource<ItemListTableViewCell, PlayListItem> else { return }
        dataSource.objects = self.selectedPlayListItem?.items ?? [PlayListItem]()
        DispatchQueue.main.async {
            dataSource.refreshData()
        }
    }
    
    
    // MARK: - Data Syncrhonization
    
    override func shouldSyncData() -> Bool {
        return self.selectedPlayListItem == nil
    }
    
    override func syncData() {
        self.fetchAllVideosForSelectedPlaylist()
    }

    func fetchAllVideosForSelectedPlaylist() {
        let syncDataSemaphore = DispatchSemaphore(value: 0)
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let downloadGroup = DispatchGroup()
            downloadGroup.enter()
            
            self.appContext.apiClient.video.all(fromPlaylist: self.appContext.selectedPlaylistId ?? "",
                                                usingKey: self.appContext.googleApiKey,
                                                completionBlock:
                { (playListItem) in
                    self.selectedPlayListItem = playListItem
                    self.updateUI()
                    self.refreshPlaylistItems()
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
    
    func playlistDetailsView(for tableView: UITableView) -> UIView {
        if let view = UINib(nibName: "DetailsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView {
            return view
        }
        return UIView()
    }
    
    override public func createDelegate() -> UITableViewDelegate? {
        guard let tableView = self.tableView else { return nil }
        let delegate = TableViewBlockDelegate(tableView: tableView)
        
        let detailsView = self.playlistDetailsView(for: tableView)
        
        delegate.sectionHeaderHeightBlock = { (_ section: Int) -> CGFloat in
            return detailsView.frame.size.height
        }
        
        delegate.viewForHeaderBlock = { (_ section: Int) -> UIView? in
            guard let view = detailsView as? DetailsView else { return detailsView }
            
            let str = NSMutableAttributedString()

            str.append(NSMutableAttributedString(string: "Vídeos: ", attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]))
            str.append(NSMutableAttributedString(string: "\(self.selectedPlayListItem?.items?.count ?? 0)", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13)]))
            view.descriptionLabel.attributedText = str
            return detailsView
        }
        
        return delegate
    }
    
}
