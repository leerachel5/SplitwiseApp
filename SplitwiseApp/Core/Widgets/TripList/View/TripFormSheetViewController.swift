//
//  TripFormSheetViewController.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/14/24.
//

import UIKit

protocol TripFormSheetDelegate {
    func createButtonTapped(tripName: String, startDate: Date, endDate: Date)
}

class TripFormSheetViewController: UIViewController {
    // MARK: View Initialization
    private lazy var safeAreaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create a new trip"
        label.textColor = .primaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private lazy var tripNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Trip Name"
        textField.textColor = .primaryText
        textField.tintColor = .primary
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .surface
        textField.layer.borderColor = UIColor.divider.cgColor
        return textField
    }()
    
    private lazy var startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private lazy var endDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private lazy var createTripButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
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
    
    // MARK: Instance Properties
    var delegate: TripFormSheetDelegate?
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        layoutSubviews()
        setViewConstraints()
        linkGestures()
    }
    
    // MARK: View Hierarchy
    private func layoutSubviews() {
        view.addSubview(safeAreaView)
        safeAreaView.addSubview(containerStack)
        safeAreaView.addSubview(createTripButton)
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(tripNameTextField)
        containerStack.addArrangedSubview(startDatePicker)
        containerStack.addArrangedSubview(endDatePicker)
    }
    
    // MARK: View Constraints
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: view.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerStack.topAnchor.constraint(equalTo: safeAreaView.topAnchor, constant: 30),
            containerStack.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor, constant: 30),
            containerStack.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor, constant: -30),
            
            tripNameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            createTripButton.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            createTripButton.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor, constant: -26),
            createTripButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    // MARK: Gestures
    private func linkGestures() {
        createTripButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    @objc private func createButtonTapped() {
        if let tripName = tripNameTextField.text, !tripName.isEmpty {
            delegate?.createButtonTapped(tripName: tripName, startDate: startDatePicker.date, endDate: endDatePicker.date)
        }
        dismiss(animated: true)
    }
}
