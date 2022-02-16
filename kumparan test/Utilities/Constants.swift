//
//  Constants.swift
//  kumparan test
//
//  Created by Maurice Tin on 13/02/22.
//

import Foundation

struct Constants{
    static let postListURL = "https://jsonplaceholder.typicode.com/posts"
    static let usersURL = "https://jsonplaceholder.typicode.com/users"
    
    static let gotoPostDetailSegue = "gotoPostDetail"
    
    private static let baseURL = "https://jsonplaceholder.typicode.com"
    
    static func getCommentsURL(with parameter: Int)->URL?{
        let result = baseURL + "/comments?postId=" + String(parameter)
        let resultURL = URL(string: result)
        return resultURL
    }
    
    static func getUserAlbumsURL(with parameter: Int)->URL?{
        let result = baseURL + "/albums" + "?user=" + String(parameter)
        let resultURL = URL(string: result)
        return resultURL
    }
    
    static func getUserPhotosURL(with albumID: Int)->URL?{
        let result = baseURL + "/photos" + "?album=" + String(albumID)
        let resultURL = URL(string: result)
        return resultURL
    }
}
