//
//  SignUpViewController.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/6/24.
//

import UIKit

class SignUpViewController: UIViewController {
    private lazy var safeAreaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var createAccountText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create Account"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .label
        return label
    }()
    
    private lazy var createAccountSubText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "to get started now!"
        label.font = .systemFont(ofSize: 28)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var createAccountLabel: UIStackView = {
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
    
    private lazy var signUpTextFields: UIStackView = {
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
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Confirm Password"
        textField.textColor = .primaryText
        textField.tintColor = .primary
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .surface
        textField.layer.borderColor = UIColor.divider.cgColor
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
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
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Already have an account? Login Now"
        
        return label
    }()
    
    var signUpViewModel = SignUpViewModel()
    
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
        safeAreaView.addSubview(createAccountLabel)
        safeAreaView.addSubview(errorLabel)
        safeAreaView.addSubview(signUpTextFields)
        safeAreaView.addSubview(signUpButton)
        safeAreaView.addSubview(loginLabel)
        createAccountLabel.addArrangedSubview(createAccountText)
        createAccountLabel.addArrangedSubview(createAccountSubText)
        signUpTextFields.addArrangedSubview(emailTextField)
        signUpTextFields.addArrangedSubview(passwordTextField)
        signUpTextFields.addArrangedSubview(confirmPasswordTextField)
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            safeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            safeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            createAccountLabel.topAnchor.constraint(equalTo: safeAreaView.topAnchor),
            createAccountLabel.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            createAccountLabel.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            signUpTextFields.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            signUpTextFields.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            signUpTextFields.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 14),
            signUpButton.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            
            loginLabel.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor),
            loginLabel.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor)
        ])
    }
    
    // MARK: Gestures
    private func linkGestures() {
        signUpButton.addTarget(self, action: #selector(onSignUpTapped), for: .touchUpInside)
        
        let textAttributes = [.foregroundColor: UIColor.link] as [NSAttributedString.Key: Any]
        if let signUpTextRange = (loginLabel.text as? NSString)?.range(of: "Login Now") {
            loginLabel.addRangeGesture(
                at: signUpTextRange,
                attributes: textAttributes
            ) { [weak self] in
                self?.onLoginTapped()
            }
        }
    }
    
    @objc private func onSignUpTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Task { [weak self] in
                guard let strongSelf = self else { return }
                do {
                    let authDataResult = try await strongSelf.signUpViewModel.createUser(email: email, password: password)
                    
                    let user = User(authDataResult.user)
                    
                    strongSelf.navigationController?.pushViewController(TripListViewController(user: user), animated: true)
                } catch {
                    strongSelf.errorLabel.isHidden = false
                }
            }
        }
    }
    
    private func onLoginTapped() {
        guard let navigationController = navigationController else { return }
        var viewControllers = Array(navigationController.viewControllers.dropLast())
        viewControllers.append(LoginViewController())
        navigationController.setViewControllers(viewControllers, animated: true)
    }
    
    // MARK: Register Trait Change
    /// Ensures all CGColors automatically adapt to dark and light mode.
    private func registerTraitChanges() {
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self]
            (traitChangeEnv: Self, previousTraitCollection: UITraitCollection) in
            guard let strongSelf = self else { return }
            strongSelf.signUpButton.layer.borderColor = UIColor.divider.cgColor
        }
    }
}
