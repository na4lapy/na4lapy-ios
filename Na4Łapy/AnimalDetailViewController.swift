//
//  AnimalDetailViewController.swift
//  Na4Łapy
//
//  Created by mac on 09/07/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {

    var animal: Animal!
    private var animalPhotos: [Photo]!

    @IBOutlet weak var animalCenterCircularPhoto: UIImageView!
    @IBOutlet weak var animalBackgroundPhoto: UIImageView!

    @IBOutlet weak var animalPhotoCollection: UICollectionView!

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var animalFullDescriptionLabel: UILabel!

    @IBAction func toggleMoreDescription(sender: AnyObject) {
        animalFullDescriptionLabel.numberOfLines = animalFullDescriptionLabel.numberOfLines == 0 ? 3 : 0
    }

    private struct Storyboard {
        static let CellIdentifier = "AnimalPhotoCell"
        static let FooterIdentifier = "AnimalDetailsCollectionFooter"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.animalFullDescriptionLabel.text = animal.description
        self.navigationItem.title = animal.getAgeName()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        animalPhotos = animal.getAllImages()
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        self.collectionViewHeightConstraint.constant = self.animalPhotoCollection.contentSize.height
    }

    func updateUI() {
        self.animalPhotoCollection.reloadData()

        dispatch_async(dispatch_get_main_queue()) {
            self.animalCenterCircularPhoto.image = self.animalPhotos.first?.image?.circle
            self.animalCenterCircularPhoto.clipsToBounds = true
            self.animalBackgroundPhoto.image = self.animalPhotos.first?.image
        }
    }
}


extension AnimalDetailViewController: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalPhotos.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as? AnimalPhotoCell  else {
            return UICollectionViewCell()
        }

        dispatch_async(dispatch_get_main_queue()) {
            cell.animalImage.image = self.animalPhotos[indexPath.item].image
        }

        return cell
    }
}


extension AnimalDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let cellWidth: CGFloat = screenWidth / 3 - 10

        return CGSize(width: ceil(cellWidth), height: ceil(cellWidth))
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
}
