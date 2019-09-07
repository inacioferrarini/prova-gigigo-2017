//
//  AnyObjectToPlayListItemArrayTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToPlayListItemArrayTransformerSpec: QuickSpec {

    override func spec() {
        
        describe("PlayListItemArray Transformer") {
            
            let transformer = AnyObjectToPlayListItemArrayTransformer()
            
            it("must parse PlayListItem Array data") {
                guard let fixtureData = FixtureHelper().arrayFixture(using: "ValidPlayListItemsFixture") else { fail("null fixture data"); return }

                guard let parsedPlayListItems = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedPlayListItems).toNot(beNil())
                
                expect(parsedPlayListItems.count) == 5
            }
            
            it("must parse PlaylistItems having empty data") {
                guard let fixtureData = FixtureHelper().arrayFixture(using: "ValidEmptyPlayListItemsFixture") else { fail("null fixture data"); return }
                
                guard let parsedPlayListItems = transformer.transform(fixtureData) else { fail("returned nil object"); return }

                expect(parsedPlayListItems.count) == 0
            }
            
            it("must return nil when uncapable o parse") {
                let nilParsedPlayListItemArray = transformer.transform(nil)
                expect(nilParsedPlayListItemArray).to(beNil())
            }
        }
    }
    
}
