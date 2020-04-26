//
//  Post.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-04-21.
//  Copyright © 2020 surinder. All rights reserved.
//

import Foundation
import Firebase
    class Post{
        var caption: String!
        var likes: Int!
        var imageUrl: String!
        var ownerUid: String!
        var creationDate: Date!
        var postId: String!
       // var user: User?
        //var didLike = false

init(postId: String!, dictionary: Dictionary<String, AnyObject>) {
    
    self.postId = postId
    

    
    if let caption = dictionary["caption"] as? String {
        self.caption = caption
    }
    
    if let likes = dictionary["likes"] as? Int {
        self.likes = likes
    }
    
    if let imageUrl = dictionary["imageUrl"] as? String {
        self.imageUrl = imageUrl
    }
    
    if let ownerUid = dictionary["ownerUid"] as? String {
        self.ownerUid = ownerUid
    }
    
    if let creationDate = dictionary["creationDate"] as? Double {
        self.creationDate = Date(timeIntervalSince1970: creationDate)
    }
}
}
