//
//  TripListView.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import UIKit

class TripListView: UITableViewController {
    
    let trips = [
        Trip(id: "0", name: "Japan", participants: [User(id: "0", name: "user0"), User(id: "1", name: "user1"), User(id: "2", name: "user2")], startDate: Date.now, endDate: Date.now),
        Trip(id: "1", name: "Europe", participants: [User(id: "0", name: "user0"), User(id: "3", name: "user3"), User(id: "4", name: "user4"), User(id: "5", name: "user5")], startDate: Date.now, endDate: Date.now)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(TripItemCell.self, forCellReuseIdentifier: "TripItemCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

}

// MARK: UITableViewDataSource
extension TripListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TripItemCell", for: indexPath) as? TripItemCell {
            cell.configure(trip: trips[indexPath.row])
            return cell
        } else {
            fatalError("[TripListView] Type mismatch: Dequeued cell is not of type TripItemCell.")
        }
    }
}
