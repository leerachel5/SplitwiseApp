//
//  LoginViewController.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/5/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    private lazy var safeAreaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var welcomeText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome,"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .label
        return label
    }()
    
    private lazy var welcomeSubText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "glad to see you!"
        label.font = .systemFont(ofSize: 28)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var welcomeLabel: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 6
        return stack
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Invalid username or password"
        label.textColor = .error
        label.isHidden = true
        return label
    }()
    
    private lazy var loginTextFields: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email Address"
        textField.textColor = .primaryText
        textField.tintColor = .primary
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .surface
        textField.layer.borderColor = UIColor.divider.cgColor
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.textColor = .primaryText
        textField.tintColor = .primary
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .surface
        textField.layer.borderColor = UIColor.divider.cgColor
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .thin)
        button.setTitleColor(.primaryText, for: .normal)
        button.setTitleColor(.secondaryText, for: .highlighted)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
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
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Don't have an account? Sign Up Now"
        
        return label
    }()
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        registerTraitChanges()
        layoutSubviews()
        setViewConstraints()
        linkGestures()
    }
    
    private func layoutSubviews() {
        view.addSubview(safeAreaView)
        safeAreaView.addSubview(welcomeLabel)
        safeAreaView.addSubview(errorLabel)
        safeAreaView.addSubview(loginTextFields)
        safeAreaView.addSubview(forgotPasswordButton)
        safeAreaView.addSubview(loginButton)
        safeAreaView.addSubview(signUpLabel)
        welcomeLabel.addArrangedSubview(welcomeText)
        welcomeLabel.addArrangedSubview(welcomeSubText)
        loginTextFields.addArrangedSubview(emailTextField)
        loginTextFields.addArrangedSubview(passwordTextField)
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            safeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            safeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: safeAreaView.topAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            loginTextFields.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            loginTextFields.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            loginTextFields.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginTextFields.bottomAnchor, constant: 8),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 8),
            loginButton.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            
            signUpLabel.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor),
            signUpLabel.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor)
        ])
    }
    
    // MARK: Gestures
    private func linkGestures() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        forgotPasswordButton.addTarget(self, action: #selector(onForgotPasswordTapped), for: .touchUpInside)
        
        let textAttributes = [.foregroundColor: UIColor.link] as [NSAttributedString.Key: Any]
        if let signUpTextRange = (signUpLabel.text as? NSString)?.range(of: "Sign Up Now") {
            signUpLabel.addRangeGesture(
                at: signUpTextRange,
                attributes: textAttributes
            ) { [weak self] in
                self?.onSignUpTapped()
            }
        }
    }
    
    @objc private func loginTapped() {
        Task { [weak self] in
            guard let strongSelf = self else { return }
            do {
                guard let email = strongSelf.emailTextField.text else { throw EmailValidationError.empty }
                guard let password = strongSelf.passwordTextField.text else { throw PasswordValidationError.empty }
                
                let user = try await strongSelf.loginViewModel.login(email: email, password: password)
                
                strongSelf.navigationController?.pushViewController(TripListViewController(user: user), animated: true)
            } catch {
                strongSelf.displayError(error.localizedDescription)
            }
        }
    }
    
    private func displayError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    @objc private func onForgotPasswordTapped() {
        print("forgot password button tapped")
    }
    
    private func onSignUpTapped() {
        guard let navigationController = navigationController else { return }
        var viewControllers = Array(navigationController.viewControllers.dropLast())
        viewControllers.append(SignUpViewController())
        navigationController.setViewControllers(viewControllers, animated: true)
    }
    
    // MARK: Register Trait Change
    /// Ensures all CGColors automatically adapt to dark and light mode.
    private func registerTraitChanges() {
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self]
            (traitChangeEnv: Self, previousTraitCollection: UITraitCollection) in
            guard let strongSelf = self else { return }
            strongSelf.loginButton.layer.borderColor = UIColor.divider.cgColor
        }
    }
}
