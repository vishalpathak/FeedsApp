//
//  Constants.swift
//  FeedsApp
//
//  Created by Vishal on 22/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

//MARK:- Cell identifiers
struct CellIdentifier {
    static let feedsCell = "cell"
}

//MARK:- Per page limit items count
var pageLimit = 10

let navigationTitle = "User Feeds"

//MARK:- UserDefaults Key
let getLastPageData = "getLastPageData"

//MARK:- Keys for DB Entities
struct FeedsDBKeys {
    static let id = "id"
    static let createdAt = "createdAt"
    static let content = "content"
    static let comments = "comments"
    static let likes = "likes"
    static let articleUrl = "articleUrl"
    static let image = "image"
    static let avatar = "avatar"
    static let name = "name"
    static let lastName = "lastName"
    static let designation = "designation"
}
