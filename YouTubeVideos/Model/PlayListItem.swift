//
//  PlayListItem.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit

struct PlayListItem {

    let kind: String?
    let etag: String?
    let id: String?
    let snippet: Snippet?
    
}

// MARK: - Equatable

extension PlayListItem: Equatable {}

func == (lhs: PlayListItem, rhs: PlayListItem) -> Bool {
    return lhs.etag == rhs.etag
}
