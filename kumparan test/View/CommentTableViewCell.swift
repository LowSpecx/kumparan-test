//
//  CommentTableViewCell.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var body: UILabel!
    
    static let identifier = "commentCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with viewModel: CommentViewModel){
        self.authorName.text = viewModel.authorName
        self.body.text = viewModel.body
    }

}
