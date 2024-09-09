//
//  TripListViewModel.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 9/8/24.
//

import Foundation

class TripListViewModel {
    var user: User
    var trips: [Trip]
    
    init(user: User, trips: [Trip] = []) {
        self.user = user
        self.trips = trips
    }
    
    func addTrip(trip: Trip) async {
        do {
            try await FirestoreService.shared.setData(from: trip, collectionPath: "users/\(user.id.uuidString)/trips", document: trip.id.uuidString)
            trips.append(trip)
        } catch {
            print("[TripListViewModel]: Error adding trip.")
        }
    }
    
    func fetchTrips() async {
        do {
            trips = try await FirestoreService.shared.getDocumentsAndDecode(to: Trip.self, collectionPath: "users/\(user.id.uuidString)/trips")
        } catch {
            print("[TripListViewModel]: Error fetching trips.")
        }
    }
}
