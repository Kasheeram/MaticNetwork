//
//  SignInController.swift
//  MaticNetwork
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    lazy var userNameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.clearButtonMode = UITextField.ViewMode.always
        tf.setBottomBorder()
        return tf
    }()
    
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.clearButtonMode = UITextField.ViewMode.always
        tf.setBottomBorder()
        return tf
    }()
    
    lazy var signInButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Colors.darkGreen
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(signInButton)
        signInButton.centerInSuperview(size: .init(width: 250, height: 50))
        
        let stack = UIStackView(arrangedSubviews: [userNameTF, passwordTF])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        
        stack.anchor(top: nil, leading: view.leadingAnchor, bottom: signInButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 56, right: 40), size: .init(width: 0, height: 100))
        
    }
    
    @objc private func handleSignIn() {
        
        if let userName = userNameTF.text, let password = passwordTF.text {
            if !userName.isEmpty && !password.isEmpty {
                
                // Retrive credentials
                if let keyUsername = KeyChain.load(key: userName) {
                    let getPassword = keyUsername.to(type: String.self)
                    if password == getPassword {
                        let homeVC = HomeController()
                        navigationController?.pushViewController(homeVC, animated: true)
                    } else {
                        showValidationAlert(message: "Incorrect password", presentVc: self) {
                            return
                        }
                    }
                } else {
                    showValidationAlert(message: "User is not register", presentVc: self) {
                        return
                    }
                }
            }
            
        } else {
            showValidationAlert(message: "User is already register, Please try another", presentVc: self) {
                return
            }
        }
        
        
    }
    
}
