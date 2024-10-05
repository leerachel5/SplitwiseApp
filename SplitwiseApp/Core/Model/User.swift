//
//  User.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 8/31/24.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
