//
//  AnyObjectToThumbnailDictionaryTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToThumbnailDictionaryTransformer: Transformer {
    
    func transform(_ input: AnyObject?) -> [String: Thumbnail]? {
        guard let dict = input as? [String : AnyObject] else { return nil }

        var items: [String: Thumbnail] = [ : ]
        let transformer = AnyObjectToThumbnailTransformer()
        
        for key in dict.keys {
            let value = dict[key] as AnyObject
            if let item = transformer.transform(value) {
                items[key] = item
            }
        }
        
        return items
    }

}
