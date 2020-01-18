//
//  SignUpController.swift
//  MaticNetwork
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import UIKit

struct Credentials {
    var username: String
    var password: String
}



class SignUpController: UIViewController {
    
    static let server = "www.example.com"
    
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
    
    lazy var createAccountButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Create account", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Colors.darkGreen
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        
    }
    
    
    private func setupViews() {
        view.addSubview(createAccountButton)
        createAccountButton.centerInSuperview(size: .init(width: 250, height: 50))
        
        let stack = UIStackView(arrangedSubviews: [userNameTF, passwordTF])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        view.addSubview(stack)
        
        stack.anchor(top: nil, leading: view.leadingAnchor, bottom: createAccountButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 56, right: 40), size: .init(width: 0, height: 100))
        
        
    }
    
    @objc private func createNewAccount() {
        print("trying to create new account")
        
        if let userName = userNameTF.text, let password = passwordTF.text {
            if !userName.isEmpty && !password.isEmpty {
                let credentials = Credentials(username: userName, password: password)
                
                // Retrive credentials
                if let keyUsername = KeyChain.load(key: credentials.username) {
                    
                    let username = keyUsername.to(type: String.self)
                    print(username)
                    
                    showValidationAlert(message: "User is already register, Please try another", presentVc: self) {
                        return
                    }
                    
                } else {
                    // Save credentials to KeyChain
                    let status = KeyChain.save(key: credentials.username, data: Data(from: credentials.password))
                    switch status {
                    case errSecSuccess:
                        let homeVC = HomeController()
                        navigationController?.pushViewController(homeVC, animated: true)
                    case errSecAuthFailed:
                        showValidationAlert(message: "Something went wrong please try again", presentVc: self) {
                            return
                        }
                    default:
                        print("Some default")
                    }
                }
            } else {
                showValidationAlert(message: "Please enter the username and password", presentVc: self) {
                    return
                }
            }
            
        } else {
            showValidationAlert(message: "User is already register, Please try another", presentVc: self) {
                
                return
            }
        }
        
    }
    
}

