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

class VideoApiSpec: QuickSpec {
    
    override func spec() {
     
        describe("Video Api Request") {
            
            describe("all") {
            
                it("if request succeeds, must return valid object") {
                    
                    stub(condition: isHost("www.googleapis.com")) { request in
                        let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
                        let error = OHHTTPStubsResponse(error:notConnectedError)
                        guard let fixtureFile = OHPathForFile("VideoApi_all_response.json", type(of: self)) else { return error }
                        
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
                        api.apiClient.video.all(fromPlaylist: "UCE_M8A5yxnLfW0KghEeajjw",
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
                    
                    expect(returnedPlaylist?.etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/AW9PgoOVcvc49QjLkiKb1qTXzUc\""
                    expect(returnedPlaylist?.kind) == "youtube#playlistItemListResponse"
                    expect(returnedPlaylist?.nextPageToken) == "CAUQAA"

                    expect(returnedPlaylist?.pageInfo?.totalResults) == 34
                    expect(returnedPlaylist?.pageInfo?.resultsPerPage) == 5
                    
                    expect(returnedPlaylist?.items?.count) == 2

                    expect(returnedPlaylist?.items?[0].kind) == "youtube#playlistItem"
                    expect(returnedPlaylist?.items?[0].etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/W6pnQM1ZFh8LHPuPlX37cRUJw9o\""
                    expect(returnedPlaylist?.items?[0].id) == "UExIRmxIcFBqZ2s3Mk5feVdlTklfSEV3RmktTGRPazYxaC42MTI4Njc2QjM1RjU1MjlG"

                    expect(returnedPlaylist?.items?[0].snippet?.publishedAt) == formatter.date(from: "2017-06-05T19:32:15.000Z")
                    expect(returnedPlaylist?.items?[0].snippet?.channelId) == "UCE_M8A5yxnLfW0KghEeajjw"
                    expect(returnedPlaylist?.items?[0].snippet?.title) == "WWDC 2017 — APPOCALYPSE — Apple"
                    expect(returnedPlaylist?.items?[0].snippet?.description) == "Ever wonder what life would be like if all our apps suddenly disappeared? Enter the Appocalypse.\n\nSong: “All Right” by Christopher Cross https://itun.es/us/Xnvb_?i=1057314316"

                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/default.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.width) == 120
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.height) == 90

                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/mqdefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.width) == 320
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.height) == 180

                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/hqdefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.width) == 480
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.height) == 360

                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/sddefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.width) == 640
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.height) == 480

                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/maxresdefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.width) == 1280
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.height) == 720

                    expect(returnedPlaylist?.items?[0].snippet?.channelTitle) == "Apple"

                    expect(returnedPlaylist?.items?[0].snippet?.playListId) == "PLHFlHpPjgk72N_yWeNI_HEwFi-LdOk61h"
                    expect(returnedPlaylist?.items?[0].snippet?.position) == 0

                    expect(returnedPlaylist?.items?[0].snippet?.resourceId?.kind) == "youtube#video"
                    expect(returnedPlaylist?.items?[0].snippet?.resourceId?.videoId) == "FC0pT9xg1oI"
                    
                    
                    

                    expect(returnedPlaylist?.items?[1].etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/DnbsRmQKIDjWA2VE-AH-4yo74ds\""
                    expect(returnedPlaylist?.items?[1].id) == "UExIRmxIcFBqZ2s3Mk5feVdlTklfSEV3RmktTGRPazYxaC5CMEQ2Mjk5NTc3NDZFRUNB"

                    expect(returnedPlaylist?.items?[1].snippet?.publishedAt) == formatter.date(from: "2017-06-05T19:28:51.000Z")
                    expect(returnedPlaylist?.items?[1].snippet?.channelId) == "UCE_M8A5yxnLfW0KghEeajjw"
                    expect(returnedPlaylist?.items?[1].snippet?.title) == "Introducing HomePod — Apple"
                    expect(returnedPlaylist?.items?[1].snippet?.description) == "Immersive hi-fi audio. All the music you love. And the intelligence of Siri. Welcome HomePod — Available in December.\n \nLearn more: http://apple.co/homepod-\n\nSong: “You’re Mine” by Phantogram  http://apple.co/2rEamJe"

                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["default"]?.url) == "https://i.ytimg.com/vi/1hw9skL-IXc/default.jpg"
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["default"]?.width) == 120
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["default"]?.height) == 90

                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["medium"]?.url) == "https://i.ytimg.com/vi/1hw9skL-IXc/mqdefault.jpg"
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["medium"]?.width) == 320
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["medium"]?.height) == 180

                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["high"]?.url) == "https://i.ytimg.com/vi/1hw9skL-IXc/hqdefault.jpg"
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["high"]?.width) == 480
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["high"]?.height) == 360

                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["standard"]?.url) == "https://i.ytimg.com/vi/1hw9skL-IXc/sddefault.jpg"
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["standard"]?.width) == 640
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["standard"]?.height) == 480

                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["maxres"]?.url) == "https://i.ytimg.com/vi/1hw9skL-IXc/maxresdefault.jpg"
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["maxres"]?.width) == 1280
                    expect(returnedPlaylist?.items?[1].snippet?.thumbnails?["maxres"]?.height) == 720

                    expect(returnedPlaylist?.items?[1].snippet?.channelTitle) == "Apple"

                    expect(returnedPlaylist?.items?[1].snippet?.playListId) == "PLHFlHpPjgk72N_yWeNI_HEwFi-LdOk61h"
                    expect(returnedPlaylist?.items?[1].snippet?.position) == 1

                    expect(returnedPlaylist?.items?[1].snippet?.resourceId?.kind) == "youtube#video"
                    expect(returnedPlaylist?.items?[1].snippet?.resourceId?.videoId) == "1hw9skL-IXc"
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
                        api.apiClient.video.all(fromPlaylist: "UCE_M8A5yxnLfW0KghEeajjw",
                                                usingKey: "AIzaSyBSfmKD0lbX_QqdTCqu_wbzgBiTWdjgsxU",
                                                completionBlock: { (playlist) in
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
            
            
            
            
            
            
            describe("with id") {
                
                it("if request succeeds, must return valid object") {
                    
                    stub(condition: isHost("www.googleapis.com")) { request in
                        let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
                        let error = OHHTTPStubsResponse(error:notConnectedError)
                        guard let fixtureFile = OHPathForFile("VideoApi_withId_response.json", type(of: self)) else { return error }
                        
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
                        api.apiClient.video.with(videoId: "FC0pT9xg1oI",
                                                 usingKey: "AIzaSyBSfmKD0lbX_QqdTCqu_wbzgBiTWdjgsxU",
                                                 completionBlock: { (playlist) in
                            returnedPlaylist = playlist
                            done()
                        }, errorHandlerBlock: { (error) in
                            fail("Mocked response returned error")
                            done()
                        })
                    }
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

                    
                    expect(returnedPlaylist).toNot(beNil())

                    expect(returnedPlaylist?.etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/VBwzFEIpKUbOUDu4CH7AwyPw8QI\""
                    expect(returnedPlaylist?.kind) == "youtube#videoListResponse"
                    expect(returnedPlaylist?.nextPageToken).to(beNil())
                    
                    expect(returnedPlaylist?.pageInfo?.totalResults) == 1
                    expect(returnedPlaylist?.pageInfo?.resultsPerPage) == 1
                    
                    expect(returnedPlaylist?.items?.count) == 1

                    expect(returnedPlaylist?.items?[0].kind) == "youtube#video"
                    expect(returnedPlaylist?.items?[0].etag) == "\"m2yskBQFythfE4irbTIeOgYYfBU/NagBDMcJlNqJiyIDoqv5LJqXa8E\""
                    expect(returnedPlaylist?.items?[0].id) == "FC0pT9xg1oI"

                    expect(returnedPlaylist?.items?[0].snippet?.publishedAt) == formatter.date(from: "2017-06-05T19:32:14.000Z")
                    expect(returnedPlaylist?.items?[0].snippet?.channelId) == "UCE_M8A5yxnLfW0KghEeajjw"
                    expect(returnedPlaylist?.items?[0].snippet?.title) == "WWDC 2017 — APPOCALYPSE — Apple"
                    expect(returnedPlaylist?.items?[0].snippet?.description) == "Ever wonder what life would be like if all our apps suddenly disappeared? Enter the Appocalypse.\n\nSong: “All Right” by Christopher Cross https://itun.es/us/Xnvb_?i=1057314316"

                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/default.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.width) == 120
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["default"]?.height) == 90
                    
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/mqdefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.width) == 320
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["medium"]?.height) == 180
                    
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/hqdefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.width) == 480
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["high"]?.height) == 360
                    
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/sddefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.width) == 640
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["standard"]?.height) == 480
                    
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.url) == "https://i.ytimg.com/vi/FC0pT9xg1oI/maxresdefault.jpg"
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.width) == 1280
                    expect(returnedPlaylist?.items?[0].snippet?.thumbnails?["maxres"]?.height) == 720
                    
                    expect(returnedPlaylist?.items?[0].snippet?.channelTitle) == "Apple"
                    
                    expect(returnedPlaylist?.items?[0].snippet?.tags?.count) == 3
                    expect(returnedPlaylist?.items?[0].snippet?.tags?[0]) == "Apple"
                    expect(returnedPlaylist?.items?[0].snippet?.tags?[1]) == "WWDC"
                    expect(returnedPlaylist?.items?[0].snippet?.tags?[2]) == "Apple event"
                    
                    expect(returnedPlaylist?.items?[0].snippet?.categoryId) == "28"
                    expect(returnedPlaylist?.items?[0].snippet?.liveBroadcastContent) == "none"
                    expect(returnedPlaylist?.items?[0].snippet?.localized?.title) == "WWDC 2017 — APPOCALYPSE — Apple"
                    expect(returnedPlaylist?.items?[0].snippet?.localized?.description) == "Ever wonder what life would be like if all our apps suddenly disappeared? Enter the Appocalypse.\n\nSong: “All Right” by Christopher Cross https://itun.es/us/Xnvb_?i=1057314316"
                    expect(returnedPlaylist?.items?[0].snippet?.defaultAudioLanguage) == "en"
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
                        api.apiClient.video.with(videoId: "FC0pT9xg1oI",
                                                 usingKey: "AIzaSyBSfmKD0lbX_QqdTCqu_wbzgBiTWdjgsxU",
                                                 completionBlock: { (playlist) in
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
    
}
