//
//  YTApiClient.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit

class YouTubeApiClient: NSObject {
    
    
    // MARK: - Initialization
    
    let rootUrl: String = "https://www.googleapis.com"
    
    
    // MARK: - Properties
    
    public lazy var playlist: PlaylistApi = {
        [unowned self] in
        return PlaylistApi(self)
    }()
    
    public lazy var video: VideoApi = {
        [unowned self] in
        return VideoApi(self)
    }()
    
}
