//
//  AnyObjectToThumbnailDictionaryTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToThumbnailDictionaryTransformerSpec: QuickSpec {

    override func spec() {
        
        describe("ThumbnailDictionary Transformer") {
            
            let transformer = AnyObjectToThumbnailDictionaryTransformer()
            
            it("must parse PlayListItem Array data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidThumbnailDictionaryFixture") else { fail("null fixture data"); return }

                guard let parsedThumbnails = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedThumbnails).toNot(beNil())

                expect(parsedThumbnails.values.count) == 5
                
                let defaultThumb = parsedThumbnails["default"]
                expect(defaultThumb?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/default.jpg"
                expect(defaultThumb?.width) == 120
                expect(defaultThumb?.height) == 90
                
                let mediumThumb = parsedThumbnails["medium"]
                expect(mediumThumb?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/mqdefault.jpg"
                expect(mediumThumb?.width) == 320
                expect(mediumThumb?.height) == 180
                
                let highThumb = parsedThumbnails["high"]
                expect(highThumb?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/hqdefault.jpg"
                expect(highThumb?.width) == 480
                expect(highThumb?.height) == 360
                
                let standardThumb = parsedThumbnails["standard"]
                expect(standardThumb?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/sddefault.jpg"
                expect(standardThumb?.width) == 640
                expect(standardThumb?.height) == 480
                
                let maxresThumb = parsedThumbnails["maxres"]
                expect(maxresThumb?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/maxresdefault.jpg"
                expect(maxresThumb?.width) == 1280
                expect(maxresThumb?.height) == 720
            }
            
            it("must parse PlaylistItems having empty data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidEmptyThumbnailDictionaryFixture") else { fail("null fixture data"); return }
                
                guard let parsedThumbnails = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                
                expect(parsedThumbnails.count) == 0
            }
            
            it("must return nil when uncapable o parse") {
                let nilParsedThumbnailDictionary = transformer.transform(nil)
                expect(nilParsedThumbnailDictionary).to(beNil())
            }
        }
    }
    
}
