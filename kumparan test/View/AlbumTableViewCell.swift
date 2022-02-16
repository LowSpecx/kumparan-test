//
//  AlbumTableViewCell.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
   
    static let identifier = "AlbumTableViewCell"
    
    @IBOutlet var collectionView: UICollectionView!
    var albumViewModel: AlbumViewModel?
    
    static func nib()->UINib{
        return UINib(nibName: "AlbumTableViewCell", bundle: nil )
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: AlbumViewModel){
        self.albumViewModel = viewModel
        collectionView.reloadData() 
    }
    
    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let albumViewModel = albumViewModel {
            return albumViewModel.thumbnails.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.configure(with: albumViewModel!.thumbnails[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
}
