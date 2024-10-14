//
//  TripListViewController.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import UIKit

class TripListViewController: UITableViewController {
    
    var tripsViewModel: TripListViewModel
    
    init(user: User) {
        self.tripsViewModel = TripListViewModel(user: user)
        super.init(style: .plain)
        
        Task { [weak self] in
            guard let strongSelf = self else { return }
            await strongSelf.tripsViewModel.fetchTrips()
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("[TripListView]: No implementation of init?(coder:).")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        tableView.separatorStyle = .none
        tableView.register(TripItemCell.self, forCellReuseIdentifier: "TripItemCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        self.title = "Trips"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .plain,
            target: self,
            action: #selector(signOut)
        )
        navigationItem.hidesBackButton = true
    }
    
    // MARK: Add Trips
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add new trip", message: "Enter the trip details.", preferredStyle: .alert)
        
        alertController.addTextField { tripNameTextField in
            tripNameTextField.placeholder = "New trip name"
        }
        alertController.addTextField { startDateTextField in
            startDateTextField.placeholder = "Start date"
        }
        alertController.addTextField { endDateTextField in
            endDateTextField.placeholder = "End date"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let strongSelf = self else {
                fatalError("[TripListView]: Reference to self is nil.")
            }
            if let newTripName = alertController.textFields?[0].text, !newTripName.isEmpty,
               let newTripStartDateString = alertController.textFields?[1].text, !newTripStartDateString.isEmpty,
               let newTripEndDateString = alertController.textFields?[2].text, !newTripEndDateString.isEmpty
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                let newTripStartDate = dateFormatter.date(from: newTripStartDateString)
                let newTripEndDate = dateFormatter.date(from: newTripEndDateString)
                let newTrip = Trip(
                    name: newTripName,
                    participants: [strongSelf.tripsViewModel.user],
                    startDate: newTripStartDate,
                    endDate: newTripEndDate
                )
                Task { [weak self] in
                    await self?.tripsViewModel.addTrip(trip: newTrip)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: Sign Out
    @objc func signOut() {
        navigationController?.popToRootViewController(animated: true)
    }

}

// MARK: UITableViewDataSource
extension TripListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsViewModel.trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TripItemCell", for: indexPath) as? TripItemCell {
            cell.configure(trip: tripsViewModel.trips[indexPath.row])
            return cell
        } else {
            fatalError("[TripListView] Type mismatch: Dequeued cell is not of type TripItemCell.")
        }
    }
}

// MARK: UITableViewDelegate
extension TripListViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Task {
                await self.tripsViewModel.removeTrip(trip: tripsViewModel.trips[indexPath.row])
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
}
