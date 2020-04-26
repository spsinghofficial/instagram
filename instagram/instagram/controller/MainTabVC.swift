//
//  MainTabVC.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-02-27.
//  Copyright © 2020 surinder. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate
            self.delegate = self
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
            
            // configure view controllers
            configureViewControllers()
        // user validation
        checkIfUserIsLoggedIn()
        navigationController?.navigationBar.isHidden = true

    }
    // MARK: - Handlers
    
    func configureViewControllers() {
        
        // home feed controller
        let feedVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // search feed controller
        let searchVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchVC())
        
        // select image controller
        let selectImageVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
        
        // notification controller
        let notificationVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationVC())
        
        // profile controller
        let userProfileVC = constructNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // view controllers to be added to tab controller
        viewControllers = [feedVC, searchVC, selectImageVC, notificationVC, userProfileVC]
        
        // tab bar tint color
        tabBar.tintColor = .black
    }
//    @objc func handleLogout() {
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
//
//            do {
//                try Auth.auth().signOut()
//                let loginVC = LoginVC()
//                let navController = UINavigationController(rootViewController: loginVC)
//
//                // UPDATE: - iOS 13 presentation fix
//                navController.modalPresentationStyle = .fullScreen
//
//                self.present(navController, animated: true, completion: nil)
//            } catch {
//                print("Failed to sign out")
//            }
//        }))
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alertController, animated: true, completion: nil)
//    }
    /// construct navigation controllers
    func constructNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        // construct nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        // return nav controller
        return navController
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                
                // UPDATE: iOS 13 presentation fix
                navController.modalPresentationStyle = .fullScreen
                
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
    }
    
    // MARK: - UITabBar
     
     func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
         let index = viewControllers?.firstIndex(of: viewController)
         
         if index == 2 {
             let selectImageVC = SelectImageVC(collectionViewLayout: UICollectionViewFlowLayout())
             let navController = UINavigationController(rootViewController: selectImageVC)
             navController.navigationBar.tintColor = .black
             present(navController, animated: true, completion: nil)
             return false
             
         } else if index == 3 {
             //dot.isHidden = true
             return true
         }
         return true
     }

}
