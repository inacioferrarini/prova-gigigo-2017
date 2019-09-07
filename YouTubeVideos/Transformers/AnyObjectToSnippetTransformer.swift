//
//  AnyObjectToSnippetTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToSnippetTransformer: Transformer {

    func transform(_ input: AnyObject?) -> Snippet? {
        guard let dict = input as? [String : AnyObject] else { return nil }

        var publishedAt: Date?
        if let publishedAtStr = dict["publishedAt"] as? String {
            let formatter = DateFormatter()
            formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            publishedAt = formatter.date(from: publishedAtStr)
        }
        let channelId = dict["channelId"] as? String
        let title = dict["title"] as? String
        let description = dict["description"] as? String
        let thumbnails = AnyObjectToThumbnailDictionaryTransformer().transform(dict["thumbnails"])
        let channelTitle = dict["channelTitle"] as? String
        let localized = AnyObjectToLocalizedTransformer().transform(dict["localized"])
        let playListId = dict["playlistId"] as? String
        let position = dict["position"] as? Int
        let resourceId = AnyObjectToResourceIdTransformer().transform(dict["resourceId"])
        let tags = dict["tags"] as? [String]
        let categoryId = dict["categoryId"] as? String
        let liveBroadcastContent = dict["liveBroadcastContent"] as? String
        let defaultAudioLanguage = dict["defaultAudioLanguage"] as? String
        
        return Snippet(publishedAt: publishedAt,
                       channelId: channelId,
                       title: title,
                       description: description,
                       thumbnails: thumbnails,
                       channelTitle: channelTitle,
                       localized: localized,
                       playListId: playListId,
                       position: position,
                       resourceId: resourceId,
                       tags: tags,
                       categoryId: categoryId,
                       liveBroadcastContent: liveBroadcastContent,
                       defaultAudioLanguage: defaultAudioLanguage)
    }
    
}
