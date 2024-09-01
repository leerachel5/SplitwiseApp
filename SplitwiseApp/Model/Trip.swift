//
//  Trip.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import Foundation

struct Trip: Identifiable, Equatable {
    let id: String
    let name: String
    let participants: [User]
    let startDate: Date?
    let endDate: Date?
}
