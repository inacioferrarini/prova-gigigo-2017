//
//  AnyObjectToPageInfoTransformer.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import York

class AnyObjectToPageInfoTransformer: Transformer {

    func transform(_ input: AnyObject?) -> PageInfo? {
        
        guard let dict = input as? [String : AnyObject] else { return nil }
        
        let totalResults = dict["totalResults"] as? Int
        let resultsPerPage = dict["resultsPerPage"] as? Int

        return PageInfo(totalResults: totalResults,
                        resultsPerPage: resultsPerPage)
    }
    
}
