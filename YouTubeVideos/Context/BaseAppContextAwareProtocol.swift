//
//  BaseAppContextAwareProtocol.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 17/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit
import York

protocol BaseAppContextAwareProtocol : AppContextAwareProtocol {
    
    var appContext: AppContext! { get set }
    
}
