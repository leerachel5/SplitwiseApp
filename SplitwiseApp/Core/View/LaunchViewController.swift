//
//  LaunchViewController.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 9/15/24.
//

import UIKit

class LaunchViewController: UIViewController {
    // MARK: Subview Initialization
    private lazy var safeAreaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Splitwise"
        label.font = .boldSystemFont(ofSize: 50)
        label.textColor = .primary
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bottomContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var authButtonsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 10
        return view
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.primaryText, for: .normal)
        button.setTitleColor(.secondaryText, for: .highlighted)
        button.tintColor = .surface
        
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.divider.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        button.configuration = UIButton.Configuration.borderedProminent()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
        
        return button
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.primaryText, for: .normal)
        button.setTitleColor(.secondaryText, for: .highlighted)
        button.tintColor = .surface
        
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.divider.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        button.configuration = UIButton.Configuration.borderedProminent()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
        
        return button
    }()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        registerTraitChanges()
        configureViews()
    }
    
    // MARK: Subview Layout and Constraints
    private func configureViews() {
        layoutSubviews()
        setViewConstraints()
        linkGestures()
    }
    
    private func layoutSubviews() {
        view.addSubview(safeAreaView)
        
        safeAreaView.addSubview(titleLabel)
        safeAreaView.addSubview(bottomContainer)
        
        bottomContainer.addSubview(authButtonsStack)
        
        authButtonsStack.addArrangedSubview(loginButton)
        authButtonsStack.addArrangedSubview(signUpButton)
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            safeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            safeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            titleLabel.heightAnchor.constraint(equalTo: bottomContainer.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            bottomContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            authButtonsStack.topAnchor.constraint(equalTo: bottomContainer.topAnchor),
            authButtonsStack.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor),
            authButtonsStack.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor),
            
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: Gestures
    private func linkGestures() {
        loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        
        signUpButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func onLoginButtonTapped() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc private func onSignUpButtonTapped() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    // MARK: Register Trait Change
    /// Ensures all CGColors automatically adapt to dark and light mode.
    private func registerTraitChanges() {
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self]
            (traitChangeEnv: Self, previousTraitCollection: UITraitCollection) in
            guard let strongSelf = self else { return }
            strongSelf.loginButton.layer.borderColor = UIColor.divider.cgColor
            strongSelf.signUpButton.layer.borderColor = UIColor.divider.cgColor
        }
    }
}
