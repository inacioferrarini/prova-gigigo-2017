//
//  AnyObjectToThumbnailTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToThumbnailTransformer: Transformer {

    func transform(_ input: AnyObject?) -> Thumbnail? {
        guard let dict = input as? [String : AnyObject] else { return nil }
        
        let url = dict["url"] as? String
        let width = dict["width"] as? Int
        let height = dict["height"] as? Int
        
        return Thumbnail(url: url,
                         width: width,
                         height: height)
    }
    
}
