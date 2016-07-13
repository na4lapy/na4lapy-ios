//
//  ViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class AnimalCardsViewController: UIViewController{
    
    @IBOutlet weak var cardCollection: UICollectionView!
    
    //MARK: UICollectionDataSource
    private var listing: Listing?
    
    private struct Storyboard {
        static let CellIndentifier = "Animal Cell"
        static let AnimalDetailSegueIdentifier = "AnimalDetail"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.listing = Listing(listingType: Animal.self)
        self.automaticallyAdjustsScrollViewInsets = false
 
        self.listing?.prefetch(0,
            success: { [weak self] in
                guard let strongSelf = self else { return }
                dispatch_async(dispatch_get_main_queue()) {
                    strongSelf.cardCollection.reloadData()
                }
            },
            failure: { _ in
                //TODO: Wyświetl informację o błędzie
            }
        )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard
            let identifier = segue.identifier,
            let animal = (sender as? AnimalCollectionCell)?.animal,
            let vc = segue.destinationViewController as? AnimalDetailViewController
            where identifier == Storyboard.AnimalDetailSegueIdentifier
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
      return  Int((listing?.getCount())!)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIndentifier, forIndexPath: indexPath) as! AnimalCollectionCell
        
        cell.animal = listing?.get(UInt(indexPath.item)) as? Animal
        
        return cell
    }
    
}


extension AnimalCardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.cardCollection.bounds.width, self.cardCollection.bounds.height)
    }
}

