//
//  AnimalCardsPresenter.swift
//  Na4Łapy
//
//  Created by mac on 17/07/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit


class AnimalCardsPresenter {
    weak private var  animalCardsController : AnimalCardsViewController?
    private let animalsListing: Listing?
    
    struct Storyboard {
        static let CellIndentifier = "Animal Cell"
        static let AnimalDetailSegueIdentifier = "AnimalDetail"
    }
    
    required init(listing: Listing) {
        self.animalsListing = listing
    }
    
    func attachView(view: AnimalCardsViewController) {
        animalCardsController = view
    }
    
    func getAnimals() {
        self.animalsListing?.prefetch(0,
            success: {
                NSNotificationCenter.defaultCenter().postNotificationName("ReloadCollectionView", object: nil)
            },
            failure: {
                log.error("Błąd podczas pobierania pobierania pierwszej strony!")
            }
        )
    }
    
    func getAnimalAmount() -> Int {
        return Int((animalsListing?.getCount())!)
    }
    
    func cellForAnimalOnCollectionView(collectionView: UICollectionView, withIndexPath indexPath:NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier, forIndexPath: indexPath) as! AnimalCollectionCell
        cell.animal = animalsListing?.get(UInt(indexPath.item)) as? Animal
        return cell
    }
}