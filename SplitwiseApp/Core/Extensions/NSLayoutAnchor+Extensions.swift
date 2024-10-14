//
//  NSLayoutAnchor+Extensions.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/14/24.
//

import UIKit

extension NSLayoutAnchor {
    @objc func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
}
