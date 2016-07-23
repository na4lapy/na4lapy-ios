//
//  ViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class AnimalCardsViewController: UIViewController {

    @IBOutlet weak var cardCollection: UICollectionView!

    //MARK: UICollectionDataSource
    private let presenter: AnimalCardsPresenter = AnimalCardsPresenter(listing: Listing(listingType: Animal.self))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        presenter.attachView(self)
        presenter.getAnimals()
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard
            let identifier = segue.identifier,
                animal = (sender as? AnimalCollectionCell)?.animal,
                vc = segue.destinationViewController as? AnimalDetailViewController
            where identifier == AnimalCardsPresenter.Storyboard.AnimalDetailSegueIdentifier
        else {
            return
        }

        vc.animal = animal

    }
}


extension AnimalCardsViewController: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getAnimalAmount()

    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        return presenter.cellForAnimalOnCollectionView(collectionView, withIndexPath: indexPath)

    }

}


extension AnimalCardsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width:self.cardCollection.bounds.width, height:self.cardCollection.bounds.height)
    }
}
