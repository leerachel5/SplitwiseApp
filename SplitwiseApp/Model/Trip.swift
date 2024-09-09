//
//  Trip.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import Foundation

struct Trip: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let participants: [User]
    let startDate: Date?
    let endDate: Date?
    
    init(id: UUID = UUID(), name: String, participants: [User], startDate: Date?, endDate: Date?) {
        self.id = id
        self.name = name
        self.participants = participants
        self.startDate = startDate
        self.endDate = endDate
    }
}
