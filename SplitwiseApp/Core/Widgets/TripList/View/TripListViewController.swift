//
//  TripListViewController.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import UIKit
import FirebaseAuth

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
        let tripFormSheetViewController = TripFormSheetViewController()
        tripFormSheetViewController.modalPresentationStyle = .formSheet
        tripFormSheetViewController.delegate = self
        present(tripFormSheetViewController, animated: true)
    }
    
    // MARK: Sign Out
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            navigationController?.setViewControllers([LaunchViewController()], animated: true)
        } catch {
            print("Failed to sign out")
        }
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

// MARK: TripFormSheetDelegate
extension TripListViewController: TripFormSheetDelegate {
    func createButtonTapped(tripName: String, startDate: Date, endDate: Date) {
        let newTrip = Trip(
            name: tripName,
            participants: [tripsViewModel.user],
            startDate: startDate,
            endDate: endDate
        )
        Task { [weak self] in
            guard let strongSelf = self else { return }
            await strongSelf.tripsViewModel.addTrip(trip: newTrip)
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
}
