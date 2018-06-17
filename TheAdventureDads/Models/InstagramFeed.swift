//
//  Feed.swift
//  TheAdventureDads
//
//  Created by joseph nelson on 2018-06-10.
//  Copyright © 2018 joseph nelson. All rights reserved.
//

import Foundation

final class InstagramFeed {
    
    var feedImageUrl: String!
    var feedText: String!

    init (feedImageUrl: String, feedText: String){
        self.feedImageUrl = feedImageUrl
        self.feedText = feedText
    }
}
