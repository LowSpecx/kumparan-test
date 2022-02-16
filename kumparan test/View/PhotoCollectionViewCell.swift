//
//  PhotoCollectionViewCell.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var myImageView: UIImageView!
    
    static let identifier = "PhotoCollectionViewCell"
    
    static func nib()->UINib{
        return UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage){
        self.myImageView.image = image
    }

}
