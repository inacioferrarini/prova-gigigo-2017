//
//  AppContext.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 17/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit

class AppContext {
    
    let apiClient: YouTubeApiClient
    
    var viewControllerShouldSyncData = [String : Bool]()
    
    var playList: Playlist? = nil
    var selectedPlaylistId: String?
    var playlistItems = [String : Playlist]()
    
    var userId: String = "UCE_M8A5yxnLfW0KghEeajjw"
    var googleApiKey: String = "AIzaSyBSfmKD0lbX_QqdTCqu_wbzgBiTWdjgsxU"
    
    
    // MARK: - Initialization
    
    public init(apiClient: YouTubeApiClient) {
        self.apiClient = apiClient
    }
    
}
