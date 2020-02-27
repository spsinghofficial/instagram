//
//  LoginVC.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-02-21.
//  Copyright © 2020 surinder. All rights reserved.


import UIKit

class LoginVC: UIViewController {
    
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor(red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
        return view
    }()
    
    let emailTextField: UITextField = {
         let tf = UITextField()
         tf.placeholder = "Email"
         tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
         tf.borderStyle = .roundedRect
         tf.font = UIFont.systemFont(ofSize: 14)
       //  tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
         return tf
     }()
    
    let passwordTextField: UITextField = {
           let tf = UITextField()
           tf.placeholder = "password"
           tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
           tf.borderStyle = .roundedRect
           tf.font = UIFont.systemFont(ofSize: 14)
         //  tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
           return tf
       }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
          let button = UIButton(type: .system)
          
          let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
          attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
          button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
          button.setAttributedTitle(attributedTitle, for: .normal)
          
          return button
      }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //HIDE NAV BAR
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logoContainerView)
           logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)

           configureViewComponents()
           
           view.addSubview(dontHaveAccountButton)
           dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
       configureViewComponents()
    }
    
    func configureViewComponents() {
          
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
               
               stackView.axis = .vertical
               stackView.spacing = 10
               stackView.distribution = .fillEqually
               
               view.addSubview(stackView)
               stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
      }
    
    // MARK: - Handlers
    
    @objc func handleShowSignUp() {
        print("signup vc called")
        let signUpVC = SignupVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    

}
