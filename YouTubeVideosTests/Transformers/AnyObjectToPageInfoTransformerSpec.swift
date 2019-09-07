//
//  AnyObjectToPageInfoTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToPageInfoTransformerSpec: QuickSpec {
    
    override func spec() {
        
        describe("PageInfo Transformer") {
            
            let transformer = AnyObjectToPageInfoTransformer()
            
            it("must parse PageInfo data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidPageInfoFixture") else { fail("null fixture data"); return }
                
                guard let parsedPageInfo = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedPageInfo).toNot(beNil())
                
                expect(parsedPageInfo.totalResults) == 12
                expect(parsedPageInfo.resultsPerPage) == 5
            }
            
            it("must parse Playlist having empty data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidEmptyPageInfoFixture") else { fail("null fixture data"); return }

                guard let parsedPageInfo = transformer.transform(fixtureData) else { fail("returned nil object"); return }

                expect(parsedPageInfo.totalResults).to(beNil())
                expect(parsedPageInfo.resultsPerPage).to(beNil())
            }
            
            it("must return nil when uncapable o parse") {
                let nilParsedPageInfo = transformer.transform(nil)
                expect(nilParsedPageInfo).to(beNil())
            }
        }
    }
    
}

