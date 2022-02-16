//
//  Photo.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import Foundation

class Photo: Codable{
    var albumId: Int
    var id: Int
    var title: String
    var url: URL
    var thumbnailUrl: URL
}
