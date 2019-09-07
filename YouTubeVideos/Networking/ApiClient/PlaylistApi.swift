//
//  PlaylistApi.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit

class PlaylistApi: AppBaseApi {
    
    func all(byUser userId: String,
             usingKey googleApiKey: String,
             completionBlock: @escaping ((Playlist?) -> Void),
             errorHandlerBlock: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/youtube/v3/playlists?part=snippet&channelId=:channelId&key=:key"
            .replacingOccurrences(of: ":channelId", with: userId)
            .replacingOccurrences(of: ":key", with: googleApiKey)
        let transformer = AnyObjectToPlaylistTransformer()
        super.get(targetUrl,
                  responseTransformer: transformer,
                  completionBlock: completionBlock,
                  errorHandlerBlock: errorHandlerBlock,
                  retryAttempts: 30)
    }
    
}
