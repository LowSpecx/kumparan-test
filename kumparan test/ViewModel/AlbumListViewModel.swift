//
//  AlbumViewModel.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import Foundation
import UIKit

protocol AlbumListDelegate{
    func didFinishFetching()->Void
}

class AlbumListViewModel{
    public var albumsVM: [AlbumViewModel] = [AlbumViewModel]()
    public var delegate: AlbumListDelegate?
    
    public func fetchUserAlbums(with user: User){
        let id = user.id
        guard let url = Constants.getUserAlbumsURL(with: id) else {return}
        
        let group = DispatchGroup()
        let networkManager = NetworkManager()
        
        //post block operation
        let albumsBlockOperation = BlockOperation()
        albumsBlockOperation.addExecutionBlock {
            //enter dispatch group
            group.enter()
            let url = url
            networkManager.fetchData(url: url, expecting: [Album].self) { [weak self]
                (result) in
                switch result{
                    case .success(let albums):
                        for album in albums{
                            self?.albumsVM.append(AlbumViewModel(for: album))
                        }
                    
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            group.wait()
        }
        
        // user block operation
        let photosBlockOperation = BlockOperation()
        photosBlockOperation.addExecutionBlock {
            for albumVM in self.albumsVM{
                guard let url  = Constants.getUserPhotosURL(with: albumVM.getAlbumID()!)else {return}
                
                
                networkManager.fetchData(url: url, expecting: [Photo].self) {
                    (result) in
                    switch result{
                        case .success(let photosFetched):
                        albumVM.photos = photosFetched
                        for photo in photosFetched{
                            if let data = try? Data(contentsOf: photo.thumbnailUrl){
                                if let image = UIImage(data: data){
                                    albumVM.thumbnails.append(image)
                                }
                            }
                        }
                        case .failure(let error):
                            print(error)
                    }
                }
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetching()
                }
            }
            
        }
        photosBlockOperation.addDependency(albumsBlockOperation)
        //adding operations to the operation queue
        let operationsQueue = OperationQueue()
        operationsQueue.addOperation(albumsBlockOperation)
        operationsQueue.addOperation(photosBlockOperation)
    }
}
