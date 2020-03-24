//
//  UserProfileVC.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-02-27.
//  Copyright © 2020 surinder. All rights reserved.
//

import UIKit
import Firebase
private let reuseIdentifier = "Cell"


private let headerIdentifier = "UserProfileHeader"

class UserProfileVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView!.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        // Do any additional setup after loading the view.
        // background color
        self.collectionView?.backgroundColor = .white
        fetchCurrentUserData()
          navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = "sidhu"
    }
 // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // declare header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! UserProfileHeader
           let currentUid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(currentUid!).observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
                let uid = snapshot.key
                let user = User(uid: uid, dictionary: dictionary)
              
                self.navigationItem.title = user.username
                self.collectionView?.reloadData()
                header.user = user 
            }
        
        return header
    }
    
    //MARK:
    func fetchCurrentUserData() {
      
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(currentUid).child("username").observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            let uid = snapshot.key
           // let user = User(uid: uid, dictionary: dictionary)
           // self.user = user
            //self.navigationItem.title = user.username
            print(snapshot.value)
           
            //self.collectionView?.reloadData()
        }
    }
}
