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
    let comments : String
    let likes : String
    let avatar: String
    let image: String
    let articleUrl: String
    let name: String
    let designation: String
    let lastName: String
    
    init(id: String, created: String, content: String,
         comments: String, likes: String, avatar: String,
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

protocol DataReceivedDelegate: class {
    func didGetDataFromAPI(rowViewModel: [FeedsInfoViewModel]?, error: String?)
}

protocol MapFeedDataModel {
    func mapToViewModelFromAPI(feeds: [Feeds]) -> [FeedsInfoViewModel]
}

class FeedDataInfoVM: MapFeedDataModel {
    
    weak var dataReceivedDelegate: DataReceivedDelegate?
    
    var arrViewModel = [FeedsInfoViewModel]()
    
    func fetchDataFromApi(page: Int, limit: Int){
        let networkManager = NetworkManager()
        networkManager.getNewFeeds(page: page, limit: limit) { (feedss, error) in
            if let error = error{
                self.dataReceivedDelegate?.didGetDataFromAPI(rowViewModel: nil, error: error)
                return
            }
            
            if let feed = feedss{
                if feed.count > 0{
                    let arr = self.mapToViewModelFromAPI(feeds: feed)
                    self.dataReceivedDelegate?.didGetDataFromAPI(rowViewModel: arr, error: nil)
                }
            }
        }
    }
    
    func mapToViewModelFromAPI(feeds: [Feeds]) -> [FeedsInfoViewModel] {
        
        for i in 0..<feeds.count{
            let obj = feeds[i]
            let dt = Util.convertStringToDate(stringDate: obj.createdAt ?? "", givenFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            var created: String = ""
            if let dt = dt{
                created = Util.getElapsedInterval(fromDate: dt)
            }
            let likes = obj.likes?.shortNumbersFormat()
            let comment = obj.comments?.shortNumbersFormat()
            if let user = obj.user, let media = obj.media{
                if user.count > 0 && media.count > 0{
                    let objUser = user[0]
                    let objMedia = media[0]
                    
                    let objView = FeedsInfoViewModel(id: obj.id ?? "NoId", created: created ,
                                                     content: obj.content ?? "NoContent", comments: comment ?? "",
                                                     likes: likes ?? "", avatar: objUser.avatar ?? "NoAvatar",
                                                     image: objMedia.image ?? "NoImage", articleUrl: objMedia.url ?? "NoUrl",
                                                     name: objUser.name ?? "", designation: objUser.designation ?? "",
                                                     lastName: objUser.lastname ?? "")
                    arrViewModel.append(objView)
                }
                else if user.count > 0{
                    let objUser = user[0]
                    let objView = FeedsInfoViewModel(id: obj.id ?? "NoId", created: created,
                                                     content: obj.content ?? "NoContent", comments: comment ?? "",
                                                     likes: likes ?? "", avatar: objUser.avatar ?? "NoAvatar",
                                                     image: "" , articleUrl: "" ,
                                                     name: objUser.name ?? "", designation: objUser.designation ?? "",
                                                     lastName: objUser.lastname ?? "")
                    arrViewModel.append(objView)
                }
            }
        }
        return arrViewModel
    }
}
