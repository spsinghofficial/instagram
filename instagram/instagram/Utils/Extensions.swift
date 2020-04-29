//
//  Extensions.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-02-21.
//  Copyright © 2020 surinder. All rights reserved.
//

import UIKit
import Firebase
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }


}

extension Database {

static func fetchUser(with uid: String, completion: @escaping(User) -> ()) {
    
    USER_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
        guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
        let user = User(uid: uid, dictionary: dictionary)
        completion(user)
    }
}
    static func fetchPost(with postId: String, completion: @escaping(Post) -> ()) {
        
        POSTS_REF.child(postId).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else { return }
            guard let ownerUid = dictionary["ownerUid"] as? String else { return }
            
            Database.fetchUser(with: ownerUid, completion: { (user) in
                let post = Post(postId: postId, user: user, dictionary: dictionary)
                completion(post)
            })
        }
    }
}
extension UIButton {
    
    func configure(didFollow: Bool) {
        
        if didFollow {
            
            // handle follow user
            self.setTitle("Following", for: .normal)
            self.setTitleColor(.black, for: .normal)
            self.layer.borderWidth = 0.5
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.backgroundColor = .white
            
        } else {
            
            // handle unfollow user
            self.setTitle("Follow", for: .normal)
            self.setTitleColor(.white, for: .normal)
            self.layer.borderWidth = 0
            self.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        }
    }
}
