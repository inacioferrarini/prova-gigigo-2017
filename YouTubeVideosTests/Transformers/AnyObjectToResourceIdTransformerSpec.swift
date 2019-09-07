//
//  AnyObjectToResourceIdTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 17/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToResourceIdTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("ResourceId Transformer") {
            
            let transformer = AnyObjectToResourceIdTransformer()
            
            it("must parse ResourceId data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidResourceIdFixture") else { fail("null fixture data"); return }
                
                guard let parsedResourceId = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedResourceId).toNot(beNil())
                
                expect(parsedResourceId.kind) == "youtube#video"
                expect(parsedResourceId.videoId) == "FC0pT9xg1oI"
            }
            
            it("must parse ResourceId having empty data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidEmptyResourceIdFixture") else { fail("null fixture data"); return }
                
                guard let parsedResourceId = transformer.transform(fixtureData) else { fail("returned nil object"); return }

                expect(parsedResourceId.kind).to(beNil())
                expect(parsedResourceId.videoId).to(beNil())
            }
            
            it("must return nil when uncapable o parse") {
                let nilParsedResourceId = transformer.transform(nil)
                expect(nilParsedResourceId).to(beNil())
            }
        }
    }
    
}
