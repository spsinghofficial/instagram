//
//  FeedVC.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-02-27.
//  Copyright © 2020 surinder. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, FeedCellDelegate {

    
    var posts = [Post]()
    var viewSinglePost = false
    var post: Post?
    var currentKey: String?
    var userProfileController: UserProfileVC?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
          collectionView?.backgroundColor = .white
          configureNavigationBar()
            // fetch posts
            if !viewSinglePost {
                fetchPosts()
            }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
          if viewSinglePost {
                  return 1
              } else {
                  return posts.count
              }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
    
        // Configure the cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
          cell.delegate = self
        if viewSinglePost {
                 if let post = self.post {
                     cell.post = post
                 }
             } else {
                 cell.post = posts[indexPath.item]
             }
     
      
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    func configureNavigationBar() {
      if !viewSinglePost {
          self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
          self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "send2"), style: .plain, target: self, action: #selector(handleShowMessages))
      }
      
      self.navigationItem.title = "Feed"
    }
    
    @objc func handleShowMessages() {
        //let messagesController = MessagesController()
        // self.messageNotificationView.isHidden = true
         //navigationController?.pushViewController(messagesController, animated: true)
     }
    
    @objc func handleLogout() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                
                // UPDATE: - iOS 13 presentation fix
                navController.modalPresentationStyle = .fullScreen
                
                self.present(navController, animated: true, completion: nil)
            } catch {
                print("Failed to sign out")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func fetchPosts(){
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
//        if currentKey == nil {
//            USER_FEED_REF.child(currentUid).queryLimited(toLast: 5).observeSingleEvent(of: .value, with: { (snapshot) in
//                self.collectionView?.refreshControl?.endRefreshing()
//
//                guard let first = snapshot.children.allObjects.first as? DataSnapshot else { return }
//                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
//
//                allObjects.forEach({ (snapshot) in
//                    let postId = snapshot.key
//                    self.fetchPost(withPostId: postId)
//                })
//                self.currentKey = first.key
//            })
//        } else {
//            USER_FEED_REF.child(currentUid).queryOrderedByKey().queryEnding(atValue: self.currentKey).queryLimited(toLast: 6).observeSingleEvent(of: .value, with: { (snapshot) in
//
//                guard let first = snapshot.children.allObjects.first as? DataSnapshot else { return }
//                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
//
//                allObjects.forEach({ (snapshot) in
//                    let postId = snapshot.key
//                    if postId != self.currentKey {
//                        self.fetchPost(withPostId: postId)
//                    }
//                })
//                self.currentKey = first.key
//            })
//        }
        USER_FEED_REF.child(currentUid).observe(.childAdded) { (snapshot) in
               let postid = snapshot.key
               Database.fetchPost(with: postid) { (post) in
                   self.posts.append(post)
                   self.posts.sort { (post1, post2) -> Bool in
                       return post1.creationDate > post2.creationDate
                   }
                   self.collectionView.reloadData()
               }
           }
    }
    func fetchPost(withPostId postId: String) {
        Database.fetchPost(with: postId) { (post) in
            self.posts.append(post)
            
            self.posts.sort(by: { (post1, post2) -> Bool in
                return post1.creationDate > post2.creationDate
            })
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: HANDLERS
    func handleUsernameTapped(for cell: FeedCell) {
        print("username tapped")
         guard let user = cell.post?.user else { return }
        let userProfileController = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        userProfileController.user = user
        self.navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    func handleOptionsTapped(for cell: FeedCell) {
           print("option tapped")
    }
    
    func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool) {
           print("like tapped")
    }
    
    func handleCommentTapped(for cell: FeedCell) {
           print("comment tapped")
    }
    
    func handleConfigureLikeButton(for cell: FeedCell) {
           print("configure like tapped")
    }
    
    func handleShowLikes(for cell: FeedCell) {
           print("showlikes tapped")
    }
    
    func configureCommentIndicatorView(for cell: FeedCell) {
           print("comment indicator tapped")
    }
}
