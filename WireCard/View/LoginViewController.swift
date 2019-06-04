//
//  LoginViewController.swift
//  WireCard
//
//  Created by Claro on 02/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    private let loginViewModel = LoginViewModel()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.frame.height, height: 32))
        textField.keyboardType = .emailAddress
        textField.textColor = .white
        textField.useUnderline()
        textField.tintColor = .gray
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.frame.height, height: 32))
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.textColor = .white
        textField.useUnderline()
        textField.tintColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .white)
        loadingView.hidesWhenStopped = true
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.sizeToFit()
        button.tintColor = .white
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.init(red: 83/255, green: 72/255, blue: 186/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.sizeToFit()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
        setupView()
        loginViewModel.completion = { [weak self] state in
            switch state {
            case .failure(let error):
                print(error)
                self?.endLoading()
            case .success:
                self?.endLoading()
                Router.home()
            }
        }
    }
    
    private func endLoading() {
        loadingView.stopAnimating()
        signButton.setTitle("Login", for: .normal)
        signButton.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.init(red: 14/255, green: 19/255, blue: 23/255, alpha: 1)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        emailTextField.text = "moip-test-developer@moip.com.br"
        passwordTextField.text = "testemoip123"
    }
    
    @objc func loginButtonPressed() {
        signButton.isUserInteractionEnabled = false
        loadingView.startAnimating()
        signButton.setTitle("", for: .normal)
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginViewModel.login(email: email, password: password)
    }
    
    @objc func registerButtonPressed() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    func setupView() {
        view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
                                     emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
                                     emailTextField.heightAnchor.constraint(equalToConstant: 32)
            ])
        
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
                                     passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     passwordTextField.heightAnchor.constraint(equalToConstant: 32),
                                     passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        view.addSubview(signButton)
        
        NSLayoutConstraint.activate([signButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
                                     signButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     signButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     signButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([registerButton.topAnchor.constraint(equalTo: signButton.bottomAnchor, constant: 20),
                                     registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     registerButton.widthAnchor.constraint(equalTo: view.widthAnchor)])
        
        signButton.addSubview(loadingView)
        
        NSLayoutConstraint.activate([loadingView.centerXAnchor.constraint(equalTo: signButton.centerXAnchor),
                                     loadingView.centerYAnchor.constraint(equalTo: signButton.centerYAnchor)])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


extension UITextField {
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func errorFeedBack(state: Bool) {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        if state {
            border.borderColor = UIColor.gray.cgColor
        } else {
            border.borderColor = UIColor.red.cgColor
        }
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func passwordLevelFeedback(level: Int) {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        var width = self.frame.size.width
        let borderFeedback = CALayer()
        
        switch level {
        case 0:
            borderFeedback.borderColor = UIColor.red.cgColor
            width = self.frame.size.width*0.25
        case 1:
            borderFeedback.borderColor = UIColor.yellow.cgColor
            width = self.frame.size.width*0.5
        case 2:
            borderFeedback.borderColor = UIColor.green.cgColor
            width = self.frame.size.width*0.75
        default:
            return
        }
        
        borderFeedback.borderWidth = borderWidth
        borderFeedback.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: width, height: self.frame.size.height))
        
        self.layer.masksToBounds = true
        self.layer.addSublayer(border)
        self.layer.addSublayer(borderFeedback)
 }
}
