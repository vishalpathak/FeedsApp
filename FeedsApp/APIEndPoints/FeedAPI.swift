//
//  FeedAPI.swift
//  FeedsApp
//
//  Created by Vishal on 22/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation
enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum FeedApi {
    case pageWithLimit(page:Int,limit: Int)
}

extension FeedApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/"
        case .qa: return "https://qa"
        case .staging: return "https://staging"

        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .pageWithLimit:
            return "blogs"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .pageWithLimit(let page, let limit):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["page":page,
            "limit":limit])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
