//
//  VideoApi.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit

class VideoApi: AppBaseApi {

    func all(fromPlaylist playListId: String,
             usingKey googleApiKey: String,
             completionBlock: @escaping ((Playlist?) -> Void),
             errorHandlerBlock: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/youtube/v3/playlistItems?part=snippet&playlistId=:playListId&key=:key&maxResults=50"
            .replacingOccurrences(of: ":playListId", with: playListId)
            .replacingOccurrences(of: ":key", with: googleApiKey)
        let transformer = AnyObjectToPlaylistTransformer()
        super.get(targetUrl,
                  responseTransformer: transformer,
                  completionBlock: completionBlock,
                  errorHandlerBlock: errorHandlerBlock,
                  retryAttempts: 30)
    }
    
    func with(videoId: String,
              usingKey googleApiKey: String,
              completionBlock: @escaping ((Playlist?) -> Void),
              errorHandlerBlock: @escaping ((Error) -> Void)) {
        
        let targetUrl = "/youtube/v3/videos?id=:videoId&part=snippet&key=:key"
            .replacingOccurrences(of: ":videoId", with: videoId)
            .replacingOccurrences(of: ":key", with: googleApiKey)
        let transformer = AnyObjectToPlaylistTransformer()
        super.get(targetUrl,
                  responseTransformer: transformer,
                  completionBlock: completionBlock,
                  errorHandlerBlock: errorHandlerBlock,
                  retryAttempts: 30)
    }
    
}
