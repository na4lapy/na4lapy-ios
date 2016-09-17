//
//  BoolToggleExtension.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 17/09/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

extension Bool {
    mutating func toggle() {
        self = !self
    }
}
