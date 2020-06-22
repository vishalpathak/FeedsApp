//
//  DataModel.swift
//  FeedsApp
//
//  Created by Vishal on 22/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

struct Feeds : Codable {
    let id : String?
    let createdAt : String?
    let content : String?
    let comments : Int?
    let likes : Int?
    let media : [Media]?
    let user : [User]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "createdAt"
        case content = "content"
        case comments = "comments"
        case likes = "likes"
        case media = "media"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        media = try values.decodeIfPresent([Media].self, forKey: .media)
        user = try values.decodeIfPresent([User].self, forKey: .user)
    }

}
struct Media : Codable {
    let id : String?
    let blogId : String?
    let createdAt : String?
    let image : String?
    let title : String?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case blogId = "blogId"
        case createdAt = "createdAt"
        case image = "image"
        case title = "title"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        blogId = try values.decodeIfPresent(String.self, forKey: .blogId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

struct User : Codable {
    let id : String?
    let blogId : String?
    let createdAt : String?
    let name : String?
    let avatar : String?
    let lastname : String?
    let city : String?
    let designation : String?
    let about : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case blogId = "blogId"
        case createdAt = "createdAt"
        case name = "name"
        case avatar = "avatar"
        case lastname = "lastname"
        case city = "city"
        case designation = "designation"
        case about = "about"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        blogId = try values.decodeIfPresent(String.self, forKey: .blogId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        about = try values.decodeIfPresent(String.self, forKey: .about)
    }
}
