//
//  ViewController.swift
//  AppLogin
//
//  Created by roman Khilchenko on 14.08.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    private let login = "User"
    private let password = "Password"
    
    private lazy var loginTextField: UITextField = {
        setupTextField("User Name")
    }()
    
    
    private lazy var passwordTextfield: UITextField = {
        let passwordTF = setupTextField("Password")
        passwordTF.isSecureTextEntry = true
        return passwordTF
    }()
    
    
    private lazy var loginButton: UIButton = {
        let logButton = setupButton(title: "Log In")
        logButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return logButton
    }()
    
    private lazy var forgotNameButton: UIButton = {
        let forgotNameButton = setupButton(title: "forgot User Name?")
        forgotNameButton.addTarget(self, action: #selector(forgotUserNameAction), for: .touchUpInside)
        return forgotNameButton
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let forgotPassButton = setupButton(title: "forgot Password?")
        forgotPassButton.addTarget(self, action: #selector(forgotPassAction), for: .touchUpInside)
        return forgotPassButton
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        registerForKeyboardNotifications()
    }
    deinit {
        removeKeyboardNotifications()
    }
    
    
    //MARK: - Метод для скрытия клавиатуры по тапу на любую часть экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        view.addGestureRecognizer(press)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    //MARK: - Action для кнопки логин
    @objc private func loginAction() {
        if loginTextField.text == login && passwordTextfield.text == password {
            let greetingVC = GreetingViewController()
            greetingVC.nameLabel = loginTextField.text
            greetingVC.modalPresentationStyle = .overCurrentContext
            present(greetingVC, animated: true)
            loginTextField.text = ""
            passwordTextfield.text = ""
        } else {
            showAlert(title: "Invalid login or password", message: "Please enter correct login and password")
        }
        
    }
    
    //MARK: - Action для UIButton для напоминания имени пользователя
    @objc private func forgotUserNameAction() {
        showAlert(title: "Oops!", message: "Your name is \(login) \u{1F609}")
    }
    
    
    //MARK: - Action для UIButton для напоминания пароля
    @objc private func forgotPassAction() {
        showAlert(title: "Oops!", message: "Your password is \(password) \u{1F609}")
    }
    
    
    private func setupLayout() {
        view.backgroundColor = .cyan
        [stackView, loginButton, forgotNameButton, forgotPasswordButton] .forEach { view.addSubview($0) }
        [loginTextField, passwordTextfield] . forEach { stackView.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 80),
            
            loginButton.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgotNameButton.topAnchor.constraint(equalTo: loginButton.safeAreaLayoutGuide.bottomAnchor),
            forgotNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.safeAreaLayoutGuide.bottomAnchor),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100)
        ])
    }
    
}

//MARK: - extention UITextField чтобы не дублировать код
extension LoginViewController {
    private func setupTextField(_ playceholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = .white
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = playceholder
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        return textField
    }
}

//MARK: - extention UIButton чтобы не дублировать код
extension LoginViewController {
    private func setupButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(hexString:"#4885CC"), for: .normal)
        return button
    }
}


//MARK: - extention UIAlertController
extension LoginViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.passwordTextfield.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

