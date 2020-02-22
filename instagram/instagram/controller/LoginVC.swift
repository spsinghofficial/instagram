//
//  LoginVC.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-02-21.
//  Copyright © 2020 surinder. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
       configureViewComponents()
    }
    
    func configureViewComponents() {
          
          let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
          
          stackView.axis = .vertical
          stackView.spacing = 10
          stackView.distribution = .fillEqually
          
          view.addSubview(stackView)
          stackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
      }

}
