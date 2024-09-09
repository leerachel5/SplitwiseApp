//
//  Encodable+Extensions.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 9/8/24.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String: Any]
            return dictionary
        } catch {
            fatalError("Error decoding object to dictionary.")
        }
    }
}
