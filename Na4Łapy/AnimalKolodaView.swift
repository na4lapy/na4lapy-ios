//
//  AnimalCardView.swift
//  Na4Łapy
//
//  Created by mac on 20/06/16.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit
import Koloda

class AnimalKolodaView: KolodaView {
    override func frameForCardAtIndex(index: UInt) -> CGRect {
        if index == 0 {
            let topOffset: CGFloat = defaultTopOffset
            let xOffset: CGFloat = defaultHorizontalOffset
            let width = CGRectGetWidth(self.frame) - 2 * xOffset
            let height = width * defaultHeightRatio
            let yOffset:CGFloat = topOffset
            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
            return frame
        } else if index == 1 {
            let horizontalMargin = -self.bounds.width * backgroundCardScalePercent
            let width = CGRectGetWidth(self.bounds) * backgroundCardScalePercent
            let height = width * defaultHeightRatio
            let frame = CGRect(x: horizontalMargin, y:0 , width: width, height: height)
            return frame
        }
        return CGRectZero
    }
}
