//
//  Snippet.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit

struct Snippet {

    let publishedAt: Date?
    let channelId: String?
    let title: String?
    let description: String?
    let thumbnails: [String : Thumbnail]?
    let channelTitle: String?
    let localized: Localized?
    let playListId: String?
    let position: Int?
    let resourceId: ResourceId?
    let tags: [String]?
    let categoryId: String?
    let liveBroadcastContent: String?
    let defaultAudioLanguage: String?
    
}
