//
//  UILabel+Extensions.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/5/24.
//

import UIKit

extension UILabel {
    typealias OnTapHandler = () -> Void
    
    func addRangeGesture(
        at tappedIndexRange: NSRange,
        attributes: [NSAttributedString.Key: Any] = [:],
        onTapHandler: @escaping OnTapHandler)
    {
        self.isUserInteractionEnabled = true
        
        addAttributes(attributes, range: tappedIndexRange)
        
        let tapGesture = RangeGestureRecognizer(target: self, action: #selector(tappedOnLabel))
        tapGesture.tappedIndexRange = tappedIndexRange
        tapGesture.onTapHandler = onTapHandler
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    private func addAttributes(_ attributes: [NSAttributedString.Key: Any], range: NSRange) {
        if let text = text {
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttributes(attributes, range: range)
            self.attributedText = attributedText
        }
    }

    @objc private func tappedOnLabel(_ gesture: RangeGestureRecognizer) {
        if let tappedIndexRange = gesture.tappedIndexRange, gesture.didTapAttributedTextInLabel(label: self, inRange: tappedIndexRange) {
            guard let onTapHandler = gesture.onTapHandler else { return }
            onTapHandler()
        }
    }
}
