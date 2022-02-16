//
//  CommentViewModel.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import Foundation

class CommentViewModel{
    let authorName: String
    let body: String
    
    let comment: Comment
    
    init(with model: Comment) {
        self.authorName = model.name
        self.body = model.body
        self.comment = model
    }
}
