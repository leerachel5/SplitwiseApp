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
    
    private lazy var topContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomContainer: UIView = {
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
        return label
    }()
    
    private var launchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Launch", for: .normal)
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
        
        safeAreaView.addSubview(topContainer)
        safeAreaView.addSubview(bottomContainer)
        
        topContainer.addSubview(titleLabel)
        bottomContainer.addSubview(launchButton)
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            safeAreaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            safeAreaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            topContainer.heightAnchor.constraint(equalTo: bottomContainer.heightAnchor),
            
            topContainer.topAnchor.constraint(equalTo: safeAreaView.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            
            launchButton.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            launchButton.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor),
        ])
    }
    
    // MARK: Gestures
    private func linkGestures() {
        launchButton.addTarget(self, action: #selector(onLaunchButtonTapped), for: .touchUpInside)
    }
    
    @objc func onLaunchButtonTapped() {
        if let id = UUID(uuidString: "31AD66D2-87C5-46BB-ADD4-4A45C539746B") {
            self.navigationController?.pushViewController(
                TripListViewController(user: User(id: id, name: "test-user")), animated: true)
        } else {
            fatalError("ERROR - Invalid uuidString")
        }
    }
    
    // MARK: Register Trait Change
    /// Ensures all CGColors automatically adapt to dark and light mode.
    func registerTraitChanges() {
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self]
            (traitChangeEnv: Self, previousTraitCollection: UITraitCollection) in
            guard let strongSelf = self else { return }
            strongSelf.launchButton.layer.borderColor = UIColor.divider.cgColor
        }
    }
}
