//
//  TripItemCell.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import UIKit

class TripItemCell: UITableViewCell {
    
    // MARK: Instance Properties
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .surface
        view.layer.borderColor = UIColor.divider.cgColor
        view.layer.borderWidth = 4
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let leadingContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let trailingContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tripNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let participantsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Prepare For Reuse
    override func prepareForReuse() {
        participantsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: Interface
    func configure(trip: Trip) {
        contentView.backgroundColor = .background
        registerTraitChanges()
        set(trip: trip)
        layoutViews()
        setConstraints()
    }
    
    // MARK: Set Data
    private func set(trip: Trip) {
        set(tripName: trip.name)
        if let startDate = trip.startDate, let endDate = trip.endDate {
            set(startDate: startDate, endDate: endDate)
        }
        set(participants: trip.participants)
    }
    
    private func set(tripName: String) {
        tripNameLabel.text = tripName
        tripNameLabel.font = .systemFont(ofSize: 32)
        tripNameLabel.textColor = .primaryText
    }
    
    private func set(startDate: Date, endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        var dateLabelText = ""
        
        let startDateString = dateFormatter.string(from: startDate)
        dateLabelText += startDateString
        
        if !Calendar.current.isDate(startDate, inSameDayAs: endDate) {
            let endDateString = dateFormatter.string(from: endDate)
            dateLabelText += " - \(endDateString)"
        }
        
        dateLabelView.text = dateLabelText
        dateLabelView.font = .systemFont(ofSize: 18)
        dateLabelView.textColor = .secondaryText
    }
    
    private func set(participants: [User]) {
        for _ in participants {
            let participantView = UIView()
            participantView.translatesAutoresizingMaskIntoConstraints = false
            participantView.backgroundColor = .surface
            participantView.layer.borderWidth = 1
            participantView.layer.borderColor = UIColor.divider.cgColor
            participantView.layer.cornerRadius = 10
            participantView.layer.masksToBounds = true
            
            participantView.widthAnchor.constraint(equalToConstant: 20).isActive = true
            participantView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            participantsStackView.addArrangedSubview(participantView)
        }
    }
    
    // MARK: Layout Subviews
    private func layoutViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(leadingContainerView)
        containerView.addSubview(trailingContainerView)
        leadingContainerView.addSubview(tripNameLabel)
        leadingContainerView.addSubview(dateLabelView)
        trailingContainerView.addSubview(participantsStackView)
    }
    
    // MARK: View Constraints
    private func setConstraints() {
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        leadingContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        leadingContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        leadingContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        leadingContainerView.trailingAnchor.constraint(equalTo: trailingContainerView.leadingAnchor , constant: -5).isActive = true
        
        trailingContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        trailingContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        trailingContainerView.leadingAnchor.constraint(equalTo: leadingContainerView.trailingAnchor, constant: 5).isActive = true
        trailingContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        
        tripNameLabel.leadingAnchor.constraint(equalTo: leadingContainerView.leadingAnchor).isActive = true
        tripNameLabel.trailingAnchor.constraint(equalTo: leadingContainerView.trailingAnchor).isActive = true
        tripNameLabel.topAnchor.constraint(equalTo: leadingContainerView.topAnchor).isActive = true
        tripNameLabel.bottomAnchor.constraint(equalTo: dateLabelView.topAnchor).isActive = true
        
        dateLabelView.leadingAnchor.constraint(equalTo: leadingContainerView.leadingAnchor).isActive = true
        dateLabelView.trailingAnchor.constraint(equalTo: leadingContainerView.trailingAnchor).isActive = true
        dateLabelView.topAnchor.constraint(equalTo: tripNameLabel.bottomAnchor).isActive = true
        dateLabelView.bottomAnchor.constraint(equalTo: leadingContainerView.bottomAnchor).isActive = true
        
        participantsStackView.leadingAnchor.constraint(equalTo: trailingContainerView.leadingAnchor).isActive = true
        participantsStackView.trailingAnchor.constraint(equalTo: trailingContainerView.trailingAnchor).isActive = true
        participantsStackView.bottomAnchor.constraint(equalTo: trailingContainerView.bottomAnchor).isActive = true
    }
    
    // MARK: Register Trait Change
    /// Ensures all CGColors automatically adapt to dark and light mode.
    func registerTraitChanges() {
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self]
            (traitChangeEnv: Self, previousTraitCollection: UITraitCollection) in
            guard let strongSelf = self else { return }
            strongSelf.containerView.layer.borderColor = UIColor.divider.cgColor
            for partipantView in strongSelf.participantsStackView.arrangedSubviews {
                partipantView.layer.borderColor = UIColor.divider.cgColor
            }
        }
    }
}
