//
//  ViewController.swift
//  kumparan test
//
//  Created by Maurice Tin on 12/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var postLists = [PostViewModel]()
    private var selectedPostViewModel: PostViewModel?
    
    @IBOutlet weak var postListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postListTableView.delegate = self
        postListTableView.dataSource = self
        fetchPostList()
        // Do any additional setup after loading the view.
    }
    
    func fetchPostList(){
        let group = DispatchGroup()
        let networkManager = NetworkManager()
        
        //post block operation
        let postBlockOperation = BlockOperation()
        postBlockOperation.addExecutionBlock {
            //enter dispatch group
            group.enter()
            let url = URL(string: Constants.postListURL)
            networkManager.fetchData(url: url, expecting: [Post].self) { [weak self]
                (result) in
                print("fetch postlist")
                switch result{
                    case .success(let posts):
                        for post in posts{
                            self?.postLists.append(PostViewModel(for: post))
                        }
                    
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            group.wait()
        }
        
        // user block operation
        let userBlockOperation = BlockOperation()
        userBlockOperation.addExecutionBlock {
            
            for (index,postList) in self.postLists.enumerated() {
                let urlString = Constants.usersURL + "/" + String(postList.post.userId)
                let url = URL(string: urlString)
                
                networkManager.fetchData(url: url, expecting: User.self) {
                     [weak self] (result) in
                    switch result{
                        case .success(let userFetched):
                        postList.user = userFetched
                        DispatchQueue.main.async {
                            var indexpaths = [IndexPath]()
                            indexpaths.append(IndexPath(row: index, section: 0))
                            self?.postListTableView.reloadData()
                        }
                        case .failure(let error):
                            print(error)
                    }
                }
            }
        }
        
        userBlockOperation.addDependency(postBlockOperation)
        //adding operations to the operation queue
        let operationsQueue = OperationQueue()
        operationsQueue.addOperation(postBlockOperation)
        operationsQueue.addOperation(userBlockOperation)
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.identifier, for: indexPath) as! PostListTableViewCell
        
        let viewModel = postLists[indexPath.row]
        cell.configure(from: viewModel)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPostViewModel = postLists[indexPath.row]
        performSegue(withIdentifier: Constants.gotoPostDetailSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? PostDetailViewController else{
            return
        }
        
        if let selectedPost = selectedPostViewModel{
            destVC.postViewModel = selectedPost
        }
    }
}

