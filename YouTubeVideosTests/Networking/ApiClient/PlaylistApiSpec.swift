//
//  PlaylistApiSpec.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
@testable import YouTubeVideos

class PlaylistApiSpec: QuickSpec {
    
    override func spec() {
     
        describe("Play Api Request") {
            
            it("if request succeeds, must return valid object") {
                
                stub(condition: isHost("www.googleapis.com")) { request in
                    let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
                    let error = OHHTTPStubsResponse(error:notConnectedError)
                    guard let fixtureFile = OHPathForFile("PlaylistApi_all_response.json", type(of: self)) else { return error }
                    
                    return OHHTTPStubsResponse(
                        fileAtPath: fixtureFile,
                        statusCode: 200,
                        headers: ["Content-Type" : "application/json"]
                    )
                }

                
                var returnedPlaylist: Playlist? = nil
                
                let client = YouTubeApiClient()
                let api = AppBaseApi(client)
                waitUntil { done in
                    api.apiClient.playlist.all(byUser: "UCE_M8A5yxnLfW0KghEeajjw",
                                               usingKey: "AIzaSyBSfmKD0lbX_QqdTCqu_wbzgBiTWdjgsxU",
                                               completionBlock: { (playlist) in
                        returnedPlaylist = playlist
                        done()
                    }) { (error) in
                        fail("Mocked response returned error")
                        done()
                    }
                }
                
                let formatter = DateFormatter()
                formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                
                expect(returnedPlaylist).toNot(beNil())
                
                expect(returnedPlaylist?.etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/eRcKdDlKMRsKdej2D7lXRK94fc4\""
                expect(returnedPlaylist?.kind) == "youtube#playlistListResponse"
                expect(returnedPlaylist?.nextPageToken) == "CAUQAA"
                
                expect(returnedPlaylist?.pageInfo?.totalResults) == 12
                expect(returnedPlaylist?.pageInfo?.resultsPerPage) == 5
                
                expect(returnedPlaylist?.items?.count) == 2
                
                expect(returnedPlaylist?.items?[0].kind) == "youtube#playlist"
                expect(returnedPlaylist?.items?[0].etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/7EfVrfKwiK7Kzdh3HIuC0l1-5v4\""
                expect(returnedPlaylist?.items?[0].id) == "PLHFlHpPjgk70W5LbPJOfpec8WJo2fEoB7"
                
                expect(returnedPlaylist?.items?[0].snippet?.publishedAt) == formatter.date(from: "2017-05-18T02:22:32.000Z")
                expect(returnedPlaylist?.items?[0].snippet?.channelId) == "UCE_M8A5yxnLfW0KghEeajjw"
                expect(returnedPlaylist?.items?[0].snippet?.title) == "iPhone — Why Switch"
                expect(returnedPlaylist?.items?[0].snippet?.description) == ""
                
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/default.jpg"
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.width) == 120
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.height) == 90
                
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/mqdefault.jpg"
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.width) == 320
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.height) == 180
                
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/hqdefault.jpg"
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.width) == 480
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.height) == 360
                
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/sddefault.jpg"
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.width) == 640
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.height) == 480
                
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.url) == "https://i.ytimg.com/vi/AszkLviSLlg/maxresdefault.jpg"
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.width) == 1280
                expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.height) == 720
                
                expect(returnedPlaylist?.items?[0].snippet?.channelTitle) == "Apple"
                
                expect(returnedPlaylist?.items?[0].snippet?.localized?.title) == "iPhone — Why Switch"
                expect(returnedPlaylist?.items?[0].snippet?.localized?.description) == ""
                
                
                
                
                
                expect(returnedPlaylist?.items?[1].kind) == "youtube#playlist"
                expect(returnedPlaylist?.items?[1].etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/cy3x_OvkfNWvA_XdBQZeveDNIew\""
                expect(returnedPlaylist?.items?[1].id) == "PLHFlHpPjgk7307LVoFKonAqq616WCzif7"
                
                expect(returnedPlaylist?.items?[1].snippet?.publishedAt) == formatter.date(from: "2017-05-12T21:48:13.000Z")
                expect(returnedPlaylist?.items?[1].snippet?.channelId) == "UCE_M8A5yxnLfW0KghEeajjw"
                expect(returnedPlaylist?.items?[1].snippet?.title) == "Accessibility — Designed for everyone"
                expect(returnedPlaylist?.items?[1].snippet?.description) == ""
                
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["default"]?.url) == "https://i.ytimg.com/vi/EHAO_kj0qcA/default.jpg"
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["default"]?.width) == 120
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["default"]?.height) == 90
                
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["medium"]?.url) == "https://i.ytimg.com/vi/EHAO_kj0qcA/mqdefault.jpg"
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["medium"]?.width) == 320
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["medium"]?.height) == 180
                
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["high"]?.url) == "https://i.ytimg.com/vi/EHAO_kj0qcA/hqdefault.jpg"
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["high"]?.width) == 480
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["high"]?.height) == 360
                
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["standard"]?.url) == "https://i.ytimg.com/vi/EHAO_kj0qcA/sddefault.jpg"
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["standard"]?.width) == 640
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["standard"]?.height) == 480
                
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["maxres"]?.url) == "https://i.ytimg.com/vi/EHAO_kj0qcA/maxresdefault.jpg"
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["maxres"]?.width) == 1280
                expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["maxres"]?.height) == 720
                
                expect(returnedPlaylist?.items?[1].snippet?.channelTitle) == "Apple"
                
                expect(returnedPlaylist?.items?[1].snippet?.localized?.title) == "Accessibility — Designed for everyone"
                expect(returnedPlaylist?.items?[1].snippet?.localized?.description) == ""
            }
            
            it("if request fails, must execute failure block") {
                
                stub(condition: isHost("www.googleapis.com")) { request in
                    let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
                    return OHHTTPStubsResponse(error: notConnectedError)
                }
                
                var returnedPlaylist: Playlist? = nil
                
                let client = YouTubeApiClient()
                let api = AppBaseApi(client)
                waitUntil { done in
                    api.apiClient.playlist.all(byUser: "UCE_M8A5yxnLfW0KghEeajjw",
                                               usingKey: "AIzaSyBSfmKD0lbX_QqdTCqu_wbzgBiTWdjgsxU",
                                               completionBlock:{ (playlist) in
                        fail("Mocked response returned success")
                        returnedPlaylist = playlist
                        done()
                    }) { (error) in
                        done()
                    }
                }
                
                expect(returnedPlaylist).to(beNil())
            }
            
        }
        
    }
    
}
