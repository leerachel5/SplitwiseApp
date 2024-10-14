//
//  SignUpViewController.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/6/24.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    // MARK: View Initialization
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
    
    private lazy var errorLabel: UIPaddedLabel = {
        let label = UIPaddedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .error
        
        label.backgroundColor = .error.withAlphaComponent(0.1)
        label.layer.borderColor = UIColor.error.cgColor
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 1
        label.insets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
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
        textField.delegate = self
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
        textField.delegate = self
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
        textField.delegate = self
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
    
    // MARK: Instance Properties
    private let signUpViewModel = SignUpViewModel()
    
    // MARK: View Lifecycle
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
            errorLabel.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalToConstant: 300),
            
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
        Task { [weak self] in
            guard let strongSelf = self else { return }
            do {
                guard let email = strongSelf.emailTextField.text else { throw EmailValidationError.empty }
                guard let password = strongSelf.passwordTextField.text else { throw PasswordValidationError.empty }
                guard let confirmationPassword = strongSelf.confirmPasswordTextField.text else { throw PasswordValidationError.empty }
                
                let user = try await strongSelf.signUpViewModel.signUp(email: email, password: password, confirmationPassword: confirmationPassword)
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

// MARK: UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
}
