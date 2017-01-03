 //
//  ViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit

class AnimalCardsViewController: UIViewController {

    @IBOutlet weak var cardCollection: UICollectionView!

    //MARK: UICollectionDataSource
    fileprivate let presenter: AnimalCardsPresenter = AnimalCardsPresenter(listing: Listing(listingType: Animal.self))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        presenter.attachView(self)
        presenter.getAnimals()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCardCollection(_:)), name: NSNotification.Name(rawValue: "ReloadAnimalView"), object: nil)

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func reloadCardCollection(_ notificatio: Notification) {
        DispatchQueue.main.async {
            self.cardCollection.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let identifier = segue.identifier,
                let animal = (sender as? AnimalCollectionCell)?.animal,
                let vc = segue.destination as? AnimalDetailViewController
            , identifier == AnimalCardsPresenter.Storyboard.AnimalDetailSegueIdentifier
        else {
            return
        }

        vc.animal = animal
    }
}

extension AnimalCardsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getAnimalAmount()

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter.cellForAnimalOnCollectionView(collectionView, withIndexPath: indexPath)
    }

}

extension AnimalCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cardCollection.bounds.width, height: self.cardCollection.bounds.height)
    }
}
