//
//  FavouriteTableCellDelegate.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 24/11/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation

protocol FavouriteTableCellDelegate: class	 {

    func removeFromFavouritesAnimal(withId id: Int)
}
