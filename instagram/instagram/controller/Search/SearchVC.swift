//
//  SearchVC.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-02-27.
//  Copyright © 2020 surinder. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchUserCell"
class SearchVC: UITableViewController {
    // MARK: - Properties
    
    var users = [User]()
    var filteredUsers = [User]()
    var searchBar = UISearchBar()
    var inSearchMode = false
    var collectionView: UICollectionView!
    var collectionViewEnabled = true
   // var posts = [Post]()
    var currentKey: String?
    var userCurrentKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register cell classes
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // UPDATE: - remove separators
        tableView.separatorStyle = .none
        fetchUsers()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
     }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
               if inSearchMode {
           return filteredUsers.count
       } else {
           return users.count
       }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var user: User!
        
        if inSearchMode {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        // create instance of user profile vc
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        
        // passes user from searchVC to userProfileVC
        userProfileVC.user = user
        
        // push view controller
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        var user: User!
        
        if inSearchMode {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        cell.user = user
        
        return cell
    }
    
    func fetchUsers() {
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
              let uid = snapshot.key
            
            guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else { return }
            let user = User(uid: uid, dictionary: dictionary)
            self.users.append(user)
            self.tableView.reloadData()
        }
    }

}
