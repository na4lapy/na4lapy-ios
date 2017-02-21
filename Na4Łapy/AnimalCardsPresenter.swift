//
//  AnimalCardsPresenter.swift
//  Na4Łapy
//
//  Created by mac on 17/07/2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import Foundation
import UIKit


class AnimalCardsPresenter {
    weak fileprivate var  animalCardsController: AnimalCardsViewController?
    fileprivate let animalsListing: Listing?

    struct Storyboard {
        static let CellIndentifier = "Animal Cell"
        static let AnimalDetailSegueIdentifier = "AnimalDetail"
    }

    required init(listing: Listing) {
        self.animalsListing = listing
    }

    func attachView(_ view: AnimalCardsViewController) {
        animalCardsController = view
    }

    func getAnimals() {
        self.animalsListing?.prefetch(0,
            success: { 
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ReloadAnimalView"), object: nil)            },
            failure: {
                log.error("Błąd podczas pobierania pierwszej strony!")
            }
        )
    }

    func getAnimalAmount() -> Int {
        guard let count = animalsListing?.getCount() else {
            return 0
        }
        return Int(count)
    }

    func cellForAnimalOnCollectionView(_ collectionView: UICollectionView, withIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIndentifier, for: indexPath) as? AnimalCollectionCell else {
            assert(false, "Cell should be of type AnimalCollectionCell")
        }
        
        cell.animal = animalsListing?.get(indexPath.row) as? Animal
        return cell
    }
}
