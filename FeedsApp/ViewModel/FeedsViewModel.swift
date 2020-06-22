//
//  FeedsViewModel.swift
//  FeedsApp
//
//  Created by Vishal on 22/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

struct FeedsInfoViewModel {
    let id : String
    let createdAt : String
    let content : String
    let comments : Int32
    let likes : Int32
    let avatar: String
    let image: String
    let articleUrl: String
    let name: String
    let designation: String
    let lastName: String
    
    init(id: String, created: String, content: String,
         comments: Int32, likes: Int32, avatar: String,
         image: String, articleUrl: String, name: String, designation: String, lastName: String) {
        self.id = id
        self.createdAt = created
        self.content = content
        self.comments = comments
        self.likes = likes
        self.avatar = avatar
        self.image = image
        self.articleUrl = articleUrl
        self.name = name
        self.lastName = lastName
        self.designation = designation
    }
}
