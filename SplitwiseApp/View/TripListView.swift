//
//  TripListView.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import UIKit

class TripListView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

// MARK: UITableViewDataSource
extension TripListView {
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0
    }


    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
       
       // Configure the cell’s contents.
       cell.textLabel!.text = "Cell text"
           
       return cell
    }
}

// MARK: UITableViewDelegate
extension TripListView {
    
}
