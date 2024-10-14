//
//  UIPaddedLabel.swift
//  SplitwiseApp
//
//  Created by Rachel Lee on 10/14/24.
//

import UIKit

class UIPaddedLabel: UILabel {
    var insets: UIEdgeInsets = .zero
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = size.height + insets.top + insets.bottom
        size.width = size.width + insets.left + insets.right
        return size
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetsRect = bounds.inset(by: insets)
        return super.textRect(forBounds: insetsRect, limitedToNumberOfLines: numberOfLines)
    }
    
    override func drawText(in rect: CGRect) {
        let insetsRect = rect.inset(by: insets)
        super.drawText(in: insetsRect)
    }
}
