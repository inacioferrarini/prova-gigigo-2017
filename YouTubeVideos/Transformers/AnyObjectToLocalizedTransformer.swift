//
//  AnyObjectToLocalizedTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToLocalizedTransformer: Transformer {

    func transform(_ input: AnyObject?) -> Localized? {
        
        guard let dict = input as? [String : AnyObject] else { return nil }
        
        let title = dict["title"] as? String
        let description = dict["description"] as? String

        return Localized(title: title,
                         description: description)
    }
    
}
