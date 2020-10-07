//
//  ViewController.swift
//  Login Screen - Programmatic
//
//  Created by Ozgur Hayat on 06/10/2020.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private var loginCustomButton: CustomButton!
    @IBOutlet weak var mainViewContainerCenterY: NSLayoutConstraint!
    
    var loginButton = CustomButton()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    let backgroundImageView = UIImageView()
    var stackView = UIStackView()
    
    
    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackGround()
        setupLoginButtonConstraints()
        addActionToLoginButton(CustomButton())
        mailText()
        passwordText()
        configureStackView()
        hideKeyboard()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupKeyboardObservers()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
        {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
            return true
        }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        view.frame.origin.y = -80
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y =  0
        
        guard let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: keyboardDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setBackGround() {
        
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "wawe")
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis         = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing      = 20
        
        setStackViewConstraints()
        addStackView()
    }
    
    func addStackView() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints                                                         = false
        stackView.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 20).isActive                    = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive  = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive                   = true
        stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30).isActive    = true
    }
    
    func mailText() {
        emailTextField.placeholder = "Enter Your Email Adress"
        emailTextField.font = UIFont.systemFont(ofSize: 15)
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.keyboardType = UIKeyboardType.default
        emailTextField.returnKeyType = UIReturnKeyType.done
        emailTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        emailTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center

        self.view.addSubview(emailTextField)
    
    }
    
    func passwordText() {
        passwordTextField.placeholder = "Enter Your Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center

        self.view.addSubview(passwordTextField)
    }
    
    @objc func loginButtonTapped(_ sender: CustomButton) {
        loginButton.shake()
        let performSegue = SecondViewController()
        
        do {
            try login()
            // Transition to next screen
            navigationController?.pushViewController(performSegue, animated: true)
            view.endEditing(true)
            
        } catch LoginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out both email and password fields", vc: self)
        } catch LoginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "Please make sure you format your email correctly", vc: self)
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 8 characters", vc: self)
        } catch {
            Alert.showBasic(title: "Unable To Login", message: "There was an error when attempting to login", vc: self)
        }
    }
    
    func addActionToLoginButton(_ sender: CustomButton) {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        

    }
    
    func login() throws {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty || password.isEmpty {
            throw LoginError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        if password.count < 8 {
            throw LoginError.incorrectPasswordLength
        }
        

    }
    
    
    func setupLoginButtonConstraints() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
        loginButton.setTitle("Login", for: .normal)
    }


}

