//
//  Timeline.swift
//  TWTRStars
//
//  Created by Nick McCrory on 2/27/17.
//  Copyright © 2017 binslashnick. All rights reserved.
//

import Foundation

class Timeline {
    var screenName: String?
    var name: String?
    var profileImage: String?
    var createdAt: String?
    var tweet: String?
    var favoriteCount: Int?
    var retweetCount: Int?
    
    init(){}
    
    init(screenName: String, name: String, profileImage: String, tweet: String, favoriteCount: Int, retweetCount: Int,  createdAt: String) {
        self.screenName = screenName
        self.name = name
        self.profileImage = profileImage
        self.tweet = tweet
        self.favoriteCount = favoriteCount
        self.retweetCount = retweetCount
        self.createdAt = createdAt
    }
}
