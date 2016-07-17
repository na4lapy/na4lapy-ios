//
//  UIInsetLabel.swift
//  Na4Łapy
//
//  Created by mac on 02/07/16.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

@IBDesignable class UIInsetLabel: UILabel {
        
        @IBInspectable var topInset: CGFloat = 5.0
        @IBInspectable var bottomInset: CGFloat = 5.0
        @IBInspectable var leftInset: CGFloat = 7.0
        @IBInspectable var rightInset: CGFloat = 7.0
        
        override func drawTextInRect(rect: CGRect) {
            let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
        }
        
        override func intrinsicContentSize() -> CGSize {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize()
            intrinsicSuperViewContentSize.height += topInset + bottomInset
            intrinsicSuperViewContentSize.width += leftInset + rightInset
            return intrinsicSuperViewContentSize
        }
    

}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}