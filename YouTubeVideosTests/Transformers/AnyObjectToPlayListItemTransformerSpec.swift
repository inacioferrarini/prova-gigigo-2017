//
//  AnyObjectToPlayListItemTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToPlayListItemTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("PlayListItem Transformer") {
            
            let transformer = AnyObjectToPlayListItemTransformer()
            
            it("must parse PlayListItem data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidPlayListItemFixture") else { fail("null fixture data"); return }

                guard let parsedPlayListItem = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedPlayListItem).toNot(beNil())

                expect(parsedPlayListItem.kind) == "youtube#playlist"
                expect(parsedPlayListItem.etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/7EfVrfKwiK7Kzdh3HIuC0l1-5v4\""
                expect(parsedPlayListItem.id) == "PLHFlHpPjgk70W5LbPJOfpec8WJo2fEoB7"
                
                expect(parsedPlayListItem.snippet).to(beNil())
            }
            
            it("must parse Playlist having empty data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidEmptyPlayListItemFixture") else { fail("null fixture data"); return }
                
                guard let parsedPlayListItem = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                
                expect(parsedPlayListItem.kind).to(beNil())
                expect(parsedPlayListItem.etag).to(beNil())
                expect(parsedPlayListItem.id).to(beNil())
                
                expect(parsedPlayListItem.snippet).to(beNil())
            }
            
            it("must return nil when uncapable o parse") {
                let nilParsedPlayListItemArray = transformer.transform(nil)
                expect(nilParsedPlayListItemArray).to(beNil())
            }
        }
    }
}
