//
//  UserDetailViewController.swift
//  kumparan test
//
//  Created by Maurice Tin on 16/02/22.
//

import UIKit

class UserDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, AlbumListDelegate {
    
    @IBOutlet weak var albumsTableView: UITableView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    
    
    @IBOutlet weak var userName: UILabel!
    var user: User?
    var albumListViewModel: AlbumListViewModel = AlbumListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsTableView.register(AlbumTableViewCell.nib(), forCellReuseIdentifier: AlbumTableViewCell.identifier)
        
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
        albumListViewModel.delegate = self
        prepareUserProfile()
        if let user = user {
            albumListViewModel.fetchUserAlbums(with: user)
        }
    }
    
    func prepareUserProfile(){
        guard let user = user else {
            return
        }
        userName.text = user.username
        emailLabel.text = user.email
        let addressText = user.address.street + ", " + user.address.suite + ", " + user.address.city
        
        addressLabel.text = addressText
        companyLabel.text = user.company.name
    }
    
    func didFinishFetching() {
        self.albumsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumListViewModel.albumsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier) as! AlbumTableViewCell
        
        cell.configure(with: albumListViewModel.albumsVM[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
