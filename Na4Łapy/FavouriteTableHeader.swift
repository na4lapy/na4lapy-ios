//
//  FavouriteTableHeader.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 23/11/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit


class FavouriteTableHeader: UIView {

    weak var delegate: FavouriteTableHeaderDelegate?

    @IBOutlet weak var animalTypeSelector: UISegmentedControl!

    @IBAction func didChangeSelectorValue(_ sender: UISegmentedControl) {

        if let selectedAnimalType = FavAnimalType(rawValue: sender.selectedSegmentIndex) {
            
            delegate?.didSelect(favAnimalType: selectedAnimalType)
        }
    }
}
