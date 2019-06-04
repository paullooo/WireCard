//
//  RegisterViewController.swift
//  WireCard
//
//  Created by Claro on 02/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.frame.height, height: 32))
        textField.keyboardType = .emailAddress
        textField.textColor = .white
        textField.delegate = self
        textField.addTarget(self, action: #selector(emailDidChange(_:)), for: .editingChanged)
        textField.useUnderline()
        textField.tintColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.frame.height, height: 32))
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.textColor = .white
        textField.delegate = self
        textField.alpha = 0
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.useUnderline()
        textField.tintColor = .white
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.frame.height, height: 32))
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.textColor = .white
        textField.delegate = self
        textField.alpha = 0
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.useUnderline()
        textField.tintColor = .white
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTopConstraint = passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0)
    lazy var confirmTopConstraint = confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0)
    lazy var passwordConstraint = passwordTextField.heightAnchor.constraint(equalToConstant: 0)
    lazy var confirmConstraint = confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 0)
    
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.sizeToFit()
        button.tintColor = .white
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.backgroundColor = UIColor.init(red: 83/255, green: 72/255, blue: 186/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
        setupViews()
    }
    
    func setupViews() {
        
        view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     emailTextField.heightAnchor.constraint(equalToConstant: 32)
            ])
        
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([passwordTopConstraint,
                                     passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     passwordConstraint
            ])
        
        view.addSubview(confirmPasswordTextField)
        
        NSLayoutConstraint.activate([confirmTopConstraint,
                                     confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     confirmConstraint
            ])
        
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
                                     registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     registerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     registerButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    @objc func registerButtonPressed() {
        registerButton.isUserInteractionEnabled = false
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        print(email)
        print(password)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let isEqual = passwordTextField.text == confirmPasswordTextField.text && !(passwordTextField.text?.isEmpty)!
        textField.passwordLevelFeedback(level: passwordLevel(testStr: textField.text ?? ""))
        registerButton.isEnabled = isEqual
    }
    
    @objc func emailDidChange(_ textField: UITextField) {
        let verify = isValidEmail(testStr: textField.text ?? "")
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseIn],
                       animations: {
                        self.passwordTopConstraint.constant = verify ? 20 : 0
                        self.passwordConstraint.constant = verify ? 32 : 0
                        self.confirmTopConstraint.constant = verify ? 20 : 0
                        self.confirmConstraint.constant =  verify ? 32 : 0
                        self.view.layoutIfNeeded()
        }, completion: { finished in
            self.passwordTextField.alpha = CGFloat(verify.intValue)
            self.confirmPasswordTextField.alpha = CGFloat(verify.intValue)
        })
        textField.errorFeedBack(state: verify)
    }
    
    func passwordLevel(testStr:String) -> Int {
        let mediumPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let strongPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let mediumPasswordTest = NSPredicate(format:"SELF MATCHES %@", mediumPassword)
        let strongPasswordTest = NSPredicate(format:"SELF MATCHES %@", strongPassword)
        
        if mediumPasswordTest.evaluate(with: testStr) {
            return 1
        }
        if strongPasswordTest.evaluate(with: testStr) {
            return 2
        } else {
            return 0
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

