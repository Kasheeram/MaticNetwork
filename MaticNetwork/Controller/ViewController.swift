//
//  ViewController.swift
//  MaticNetwork
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var signinButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(Colors.darkGreen, for: .normal)
        btn.setBorder()
        btn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return btn
    }()
    
    lazy var signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Colors.darkGreen
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    func setupViews() {
        let stack = UIStackView(arrangedSubviews: [signinButton, signUpButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 24
        
        
        view.addSubview(stack)
        stack.centerInSuperview(size: .init(width: 250, height: 124))
    }
    
    @objc func handleSignUp() {
        let createAccountVC = SignUpController()
        navigationController?.pushViewController(createAccountVC, animated: true)
    }
    
    @objc func handleSignIn() {
        let signInVC = SignInController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
}

