//
//  AnyObjectToSnippetTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToSnippetTransformerSpec: QuickSpec {

    override func spec() {
        
        describe("Snippet Transformer") {
            
            let transformer = AnyObjectToSnippetTransformer()
            
            it("must parse Snippet data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidSnippetFixture") else { fail("null fixture data"); return }

                guard let parsedSnippet = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedSnippet).toNot(beNil())
                
                let formatter = DateFormatter()
                formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let publishedAt = formatter.date(from: "2017-05-18T02:22:32.000Z")
                
                expect(parsedSnippet.publishedAt) == publishedAt
                expect(parsedSnippet.channelId) == "UCE_M8A5yxnLfW0KghEeajjw"
                expect(parsedSnippet.title) == "iPhone — Why Switch"
                expect(parsedSnippet.description) == ""
                expect(parsedSnippet.channelTitle) == "Apple"
                expect(parsedSnippet.playListId) == "PLHFlHpPjgk72N_yWeNI_HEwFi-LdOk61h"
                expect(parsedSnippet.position) == 0
                expect(parsedSnippet.resourceId?.kind) == "youtube#video"
                expect(parsedSnippet.resourceId?.videoId) == "FC0pT9xg1oI"
            }
            
            it("must parse Snippet having empty data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidEmptySnippetFixture") else { fail("null fixture data"); return }
                
                guard let parsedSnippet = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                
                expect(parsedSnippet.publishedAt).to(beNil())
                expect(parsedSnippet.channelId).to(beNil())
                expect(parsedSnippet.title).to(beNil())
                expect(parsedSnippet.description).to(beNil())
                expect(parsedSnippet.channelTitle).to(beNil())
                expect(parsedSnippet.playListId).to(beNil())
                expect(parsedSnippet.position).to(beNil())
                expect(parsedSnippet.resourceId).to(beNil())
            }
            
            it("must return nil when uncapable o parse") {
                let nilSnippet = transformer.transform(nil)
                expect(nilSnippet).to(beNil())
            }
        }
    }
    
}
