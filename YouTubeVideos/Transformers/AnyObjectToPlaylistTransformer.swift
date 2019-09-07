//
//  AnyObjectToPlaylistTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToPlaylistTransformer: Transformer {
    
    func transform(_ input: AnyObject?) -> Playlist? {

        guard let dict = input as? [String : AnyObject] else { return nil }
        
        let kind = dict["kind"] as? String
        let etag = dict["etag"] as? String
        let nextPageToken = dict["nextPageToken"] as? String
        
        let pageInfoTransformer = AnyObjectToPageInfoTransformer()
        let pageInfo: PageInfo? = pageInfoTransformer.transform(dict["pageInfo"])
        let items = AnyObjectToPlayListItemArrayTransformer().transform(dict["items"])
        
        return Playlist(kind: kind,
                        etag: etag,
                        nextPageToken: nextPageToken,
                        pageInfo: pageInfo,
                        items: items)
    }

}
