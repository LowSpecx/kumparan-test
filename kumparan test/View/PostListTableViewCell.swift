//
//  PostListTableViewCell.swift
//  kumparan test
//
//  Created by Maurice Tin on 13/02/22.
//

import UIKit

class PostListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    
    static let identifier: String = "postListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(from viewModel: PostViewModel){
        postTitle.text = viewModel.postTitle
        usernameLabel.text = "By: " + viewModel.username
        companyName.text = "@" + viewModel.userCompanyName
        body.text = viewModel.postBody
    }

}
