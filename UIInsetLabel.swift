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
        
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: topInset,
                                      left: leftInset,
                                      bottom: bottomInset,
                                      right: rightInset)
            super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        }

        override var intrinsicContentSize : CGSize {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize
            intrinsicSuperViewContentSize.height += topInset + bottomInset
            intrinsicSuperViewContentSize.width += leftInset + rightInset
            return intrinsicSuperViewContentSize
        }

}

extension String {
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)

        let boundingBox =
            self.boundingRect(with: constraintRect,
                                      options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                      attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
}
