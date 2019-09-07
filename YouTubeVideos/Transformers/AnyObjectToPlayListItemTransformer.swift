//
//  AnyObjectToPlayListItemTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToPlayListItemTransformer: Transformer {

    func transform(_ input: AnyObject?) -> PlayListItem? {
        guard let dict = input as? [String : AnyObject] else { return nil }
        
        let kind = dict["kind"] as? String
        let etag = dict["etag"] as? String
        let id = dict["id"] as? String
        
        let snippet = AnyObjectToSnippetTransformer().transform(dict["snippet"])

        return PlayListItem(kind: kind,
                            etag: etag,
                            id: id,
                            snippet: snippet)
    }
    
}
