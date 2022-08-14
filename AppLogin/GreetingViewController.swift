//
//  GreetingViewController.swift
//  AppLogin
//
//  Created by roman Khilchenko on 14.08.2022.
//

import UIKit

class GreetingViewController: UIViewController {
    
    //MARK: - переменная для хранения имени пользователя
    var nameLabel: String!
    
    private let welcomeLabel: UILabel = {
        let labelWelcome = UILabel()
        labelWelcome.translatesAutoresizingMaskIntoConstraints = false
        labelWelcome.text = "Welcome,"
        labelWelcome.textColor = .white
        labelWelcome.font = .systemFont(ofSize: 30, weight: .bold)
        return labelWelcome
    }()
    
    private let userLabel: UILabel = {
        let labelUser = UILabel()
        labelUser.translatesAutoresizingMaskIntoConstraints = false
        labelUser.text = ""
        labelUser.textColor = .white
        labelUser.font = .systemFont(ofSize: 30, weight: .bold)
        return labelUser
    }()
    
    private let handLabel: UILabel = {
        let labelHand = UILabel()
        labelHand.translatesAutoresizingMaskIntoConstraints = false
        labelHand.text = "\u{1F44B}"
        labelHand.font = .systemFont(ofSize: 60)
        return labelHand
    }()
    
    private lazy var logOutButton: UIButton = {
        let buttonLogOut = UIButton()
        buttonLogOut.translatesAutoresizingMaskIntoConstraints = false
        buttonLogOut.setTitle("Log out", for: .normal)
        buttonLogOut.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        buttonLogOut.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return buttonLogOut
    }()
    
    private let stackGreetView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        userLabel.text = nameLabel
    }
    
    
    //MARK: - Action для UIButton Log out
    @objc private func backAction() {
        dismiss(animated: true)
    }
    
    
    private func setupLayout() {
        view.backgroundColor = .systemPink
        [stackGreetView, handLabel, logOutButton] .forEach { view.addSubview($0) }
        [welcomeLabel, userLabel] .forEach { stackGreetView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackGreetView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            stackGreetView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            
            handLabel.topAnchor.constraint(equalTo: stackGreetView.bottomAnchor, constant: 20),
            handLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
}
