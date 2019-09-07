//
//  AnyObjectToThumbnailTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToThumbnailTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Thumbnail Transformer") {
            
            let transformer = AnyObjectToThumbnailTransformer()
            
            it("must parse Thumbnail data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidThumbnailFixture") else { fail("null fixture data"); return }

                guard let parsedThumbnail = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedThumbnail).toNot(beNil())
                
                expect(parsedThumbnail.url) == "https://i.ytimg.com/vi/AszkLviSLlg/default.jpg"
                expect(parsedThumbnail.width) == 120
                expect(parsedThumbnail.height) == 90
            }
            
            it("must parse Thumbnail having empty data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidEmptyThumbnailFixture") else { fail("null fixture data"); return }
                
                guard let parsedThumbnail = transformer.transform(fixtureData) else { fail("returned nil object"); return }

                expect(parsedThumbnail.url).to(beNil())
                expect(parsedThumbnail.width).to(beNil())
                expect(parsedThumbnail.height).to(beNil())
            }
            
            it("must return nil when uncapable o parse") {
                let nilThumbnail = transformer.transform(nil)
                expect(nilThumbnail).to(beNil())
            }
        }
    }
    
}
