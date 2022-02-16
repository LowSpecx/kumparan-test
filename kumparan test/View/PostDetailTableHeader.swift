//
//  PostDetailTableHeader.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import UIKit

protocol UsernameSelectionDelegate{
    func nameDidTapped()->Void
}

class PostDetailTableHeader: UITableViewHeaderFooterView{
    static let identifier = "PostDetailTableHeader"
    
    public var delegate: UsernameSelectionDelegate?
    
    public let title: UILabel = {
        let title = UILabel()
        title.text = "test QIOWJDOQJWDJQJDQIJDQOIWJDQOIJDOQIJD"
        title.font = .systemFont(ofSize: 22, weight: .semibold)
        title.textColor = .white
        title.numberOfLines = 0
        return title
    }()
    
    public let author: UIButton = {
        let author = UIButton()
        author.titleLabel?.font = .systemFont(ofSize: 14, weight: .heavy)
        author.contentMode = .left
        author.setTitleColor(.orange, for: .normal)
        author.addTarget(self, action: #selector(userTapped(_:)), for: .touchUpInside)
        
        return author
    }()
    
    public let body: UILabel = {
       let body = UILabel()
        body.text = "qwidjqowdq"
        body.font = .systemFont(ofSize: 18, weight: .medium)
        body.textColor = .white
        body.numberOfLines = 0
        body.lineBreakMode = .byCharWrapping
        return body
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(author)
        contentView.addSubview(title)
        contentView.addSubview(body)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title.sizeToFit()
        title.frame = CGRect(x: 20,
                             y: 0,
                             width: contentView.frame.size.width , height: title.frame.size.height)
        
        
        author.sizeToFit()
        author.frame = CGRect(x: 20, y: title.frame.size.height + 6, width: contentView.frame.size.width, height: author.frame.size.height)
        
        body.sizeToFit()
        body.frame = CGRect(x: 20, y: author.frame.origin.y + author.frame.height + 6, width: contentView.frame.size.width, height: body.frame.size.height)
    }
    
    public func configure(with post: PostViewModel){
        self.title.text = post.postTitle
        let authorTitle = "By: " + post.username
        self.author.setTitle(authorTitle, for: .normal)
        self.body.text = post.postBody
    }
    
    public func calculateHeight()->CGFloat{
        var total: CGFloat = 0.0
        total += title.frame.size.height
        total += author.frame.size.height + 6
        total += body.frame.size.height + 6
        total += 6
        return total
    }
    
    @IBAction func userTapped(_ sender: UIButton){
        self.delegate?.nameDidTapped()
    }
}
