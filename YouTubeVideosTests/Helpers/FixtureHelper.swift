//
//  FixtureHelper.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit

class FixtureHelper {
    
    func objectFixture(using fixtureFile: String) -> NSDictionary? {
        let bundle = Bundle(for: type(of: self))
        guard let resourceUrl = bundle.url(forResource: fixtureFile, withExtension: "json") else { return nil }
        guard let fileContent = try? Data(contentsOf: resourceUrl) else { return nil }
        guard let parsedData = try? JSONSerialization.jsonObject(with: fileContent, options: []) else { return nil }
        return parsedData as? NSDictionary
    }

    func arrayFixture(using fixtureFile: String) -> NSArray? {
        let bundle = Bundle(for: type(of: self))
        guard let resourceUrl = bundle.url(forResource: fixtureFile, withExtension: "json") else { return nil }
        guard let fileContent = try? Data(contentsOf: resourceUrl) else { return nil }
        guard let parsedData = try? JSONSerialization.jsonObject(with: fileContent, options: []) else { return nil }
        return parsedData as? NSArray
    }
    
}
