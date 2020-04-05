//
//  FollowLikeVC.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-03-27.
//  Copyright © 2020 surinder. All rights reserved.
//

import UIKit
import Firebase
private let reuseIdentifer = "FollowCell"
class FollowLikeVC: UITableViewController, FollowCellDelegate {

    
    var uid: String?
    var users = [User]()
    var isFollowing = false
    var isFollower = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("follow vc called")
        // register cell class
        tableView.register(FollowLikeCell.self, forCellReuseIdentifier: reuseIdentifer)
        
        // configure nav titles
       // configureNavigationTitle()
        
        // fetch users
        fetchUsers()
        
        // clear separator lines
        tableView.separatorColor = .clear

    }
     // MARK: - UITableView
     
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
     }
     

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! FollowLikeCell
        cell.delegate = self
        cell.user = users[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        
        userProfileVC.user = user
        
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    // MARK: - FollowCellDelegate Protocol
    
    func handleFollowTapped(for cell: FollowLikeCell) {
        
        guard let user = cell.user else { return }
        
        if user.isFollowed {
            
            user.unfollow()
            
            // configure follow button for non followed user
            cell.followButton.setTitle("Follow", for: .normal)
            cell.followButton.setTitleColor(.white, for: .normal)
            cell.followButton.layer.borderWidth = 0
            cell.followButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
            
        } else {
            
            user.follow()
            
            // configure follow button for followed user
            cell.followButton.setTitle("Following", for: .normal)
            cell.followButton.setTitleColor(.black, for: .normal)
            cell.followButton.layer.borderWidth = 0.5
            cell.followButton.layer.borderColor = UIColor.lightGray.cgColor
            cell.followButton.backgroundColor = .white
        }
    }
    // MARK: - Handlers
    
//    func configureNavigationTitle() {
//       // guard let viewingMode = self.viewingMode else { return }
//
//        switch viewingMode {
//        case .Followers: navigationItem.title = "Followers"
//        case .Following: navigationItem.title = "Following"
//        case .Likes: navigationItem.title = "Likes"
//        }
//    }
    func  fetchUsers(){
      
        var ref: DatabaseReference!
        guard let uid = self.uid else {return}
        print("user id 1 \(uid)")
        print("follower tab\(isFollower)")
          print("following tab\(isFollowing)")
        if isFollower{
            ref = USER_FOLLOWER_REF
        }
        else{
            ref = USER_FOLLOWING_REF
        }
       ref.child(uid).observe(.childAdded) { (snapshot) in
        let userID = snapshot.key
       
        USER_REF.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else { return }
                                      let user = User(uid: userID, dictionary: dictionary)
                                      self.users.append(user)
                                      self.tableView.reloadData()
        })
        
        
        }
                  print("LIST OF USERS ")
                        print(users)
    }
      
}

