//
//  AlbumViewModel.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import Foundation
import UIKit

class AlbumViewModel{
    var photos: [Photo] = [Photo]()
    var album: Album?
    var title: String = ""
    var thumbnails: [UIImage] = [UIImage]()
    
    init(for album: Album) {
        self.album = album
        title = album.title
    }
    
    public func getAlbumID()->Int?{
        return album?.id
    }
}
