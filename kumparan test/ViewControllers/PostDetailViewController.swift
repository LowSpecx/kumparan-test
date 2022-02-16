//
//  PostDetailViewController.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var postTitle: UILabel!
    
    @IBOutlet weak var userName: UIButton!
    
    @IBOutlet weak var postBody: UILabel!
    
    @IBOutlet weak var postDetailTableView: UITableView!
    
    var postViewModel: PostViewModel!
    var commentsVM = [CommentViewModel]()
    var header: PostDetailTableHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        postTitle.text = postViewModel.postTitle
//        userName.titleLabel?.text = postViewModel.username
//        postBody.text = postViewModel.postBody
        postDetailTableView.register(PostDetailTableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        
        prepareHeader()
        postDetailTableView.delegate = self
        postDetailTableView.dataSource = self
        fetchComments()
    }
    
    func prepareHeader(){
        header = postDetailTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? PostDetailTableHeader
        
        header?.delegate = self
        header?.configure(with: postViewModel)
    }
    
    func fetchComments(){
        guard let url = Constants.getCommentsURL(with: postViewModel.post.id) else{return}
        
        NetworkManager().fetchData(url: url, expecting: [Comment].self) {
            [weak self] (result) in
            switch result{
            case .success(let comments):
                for comment in comments{
                    self?.commentsVM.append(CommentViewModel(with: comment))
                }
                DispatchQueue.main.async {
                    self?.postDetailTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? UserDetailViewController{
            destVC.user = self.postViewModel.user
        }
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsVM.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = commentsVM[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as! CommentTableViewCell
        
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let header = header{
            return header.calculateHeight()
        }
        return 0
    }
}

extension PostDetailViewController: UsernameSelectionDelegate{
    func nameDidTapped() {
        //perform segue....
        performSegue(withIdentifier: "userDetails", sender: self)
    }
}
