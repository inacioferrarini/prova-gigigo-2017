//
//  AnyObjectToResourceIdTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 17/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToResourceIdTransformer: Transformer {
    
    func transform(_ input: AnyObject?) -> ResourceId? {
        
        guard let dict = input as? [String : AnyObject] else { return nil }
        
        let kind = dict["kind"] as? String
        let videoId = dict["videoId"] as? String
        
        return ResourceId(kind: kind,
                          videoId: videoId)
    }
    
}
