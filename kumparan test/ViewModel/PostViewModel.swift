//
//  PostViewModel.swift
//  kumparan test
//
//  Created by Maurice Tin on 12/02/22.
//


class PostViewModel{
    let postTitle: String
    let postBody: String
    var username: String = ""
    var userCompanyName: String = ""
    
    var post: Post
    var user: User?{
        didSet{
            if let user = user {
                username = user.username
                userCompanyName = user.company.name
            }
        }
    }
    
    init(for post: Post) {
        self.postTitle = post.title
        self.postBody = post.body
        self.post = post
    }
}
