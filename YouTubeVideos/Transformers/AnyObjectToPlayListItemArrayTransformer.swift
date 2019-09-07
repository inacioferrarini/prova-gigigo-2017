//
//  AnyObjectToPlayListItemArrayTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToPlayListItemArrayTransformer: Transformer {

    func transform(_ input: AnyObject?) -> [PlayListItem]? {
        guard let dictArray = input as? [[String : AnyObject]] else { return nil }

        var items: [PlayListItem] = []
        let transformer = AnyObjectToPlayListItemTransformer()
        
        for dict in dictArray {
            let value = dict as AnyObject
            if let item = transformer.transform(value) {
                items.append(item)
            }
        }
        
        return items
    }
    
}
