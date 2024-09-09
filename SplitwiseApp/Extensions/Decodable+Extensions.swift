//
//  Decodable+Extensions.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 9/8/24.
//

import Foundation

extension Decodable {
    static func from(dictionary: [String: Any]) -> Self? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let decodedObject = try JSONDecoder().decode(Self.self, from: data)
            return decodedObject
        } catch {
            print("Error decoding object from dictionary: \(error)")
            return nil
        }
    }
}

