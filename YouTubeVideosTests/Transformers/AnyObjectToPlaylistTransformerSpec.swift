//
//  AnyObjectToPlaylistTransformerSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import YouTubeVideos

class AnyObjectToPlaylistTransformerSpec: QuickSpec {
        
    override func spec() {
    
        describe("Playlist Transformer") {

            let transformer = AnyObjectToPlaylistTransformer()
            
            it("must parse Playlist data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidPlaylistFixture") else { fail("null fixture data"); return }
                
                guard let parsedPlaylist = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                expect(parsedPlaylist).toNot(beNil())
                
                expect(parsedPlaylist.kind) == "youtube#playlistListResponse"
                expect(parsedPlaylist.etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/eRcKdDlKMRsKdej2D7lXRK94fc4\""
                expect(parsedPlaylist.nextPageToken) == "CAUQAA"

                expect(parsedPlaylist.pageInfo).to(beNil())
                expect(parsedPlaylist.items?.count) == 0
            }
            
            it("must parse Playlist having empty data") {
                guard let fixtureData = FixtureHelper().objectFixture(using: "ValidEmptyPlaylistFixture") else { fail("null fixture data"); return }
                
                guard let parsedPlaylist = transformer.transform(fixtureData) else { fail("returned nil object"); return }
                
                expect(parsedPlaylist.kind).to(beNil())
                expect(parsedPlaylist.etag).to(beNil())
                expect(parsedPlaylist.nextPageToken).to(beNil())
                
                expect(parsedPlaylist.pageInfo).to(beNil())
                expect(parsedPlaylist.items?.count) == 0
            }
            
            it("must return nil when uncapable o parse") {
                let nilParsedPlaylist = transformer.transform(nil)
                expect(nilParsedPlaylist).to(beNil())
            }
        }
    }
    
}
