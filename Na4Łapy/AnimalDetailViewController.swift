//
//  AnimalDetailViewController.swift
//  Na4Łapy
//
//  Created by mac on 09/07/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit
import ImageViewer

class AnimalDetailViewController: UIViewController {

    var animal: Animal!
    private var animalPhotos: [Photo]!
    private var animalImageProvider: AnimalImageProvider!

    @IBOutlet weak var animalCenterCircularPhoto: UIImageView!
    @IBOutlet weak var animalBackgroundPhoto: UIImageView!

    @IBOutlet weak var animalFeaturesTable: UITableView!

    @IBOutlet weak var animalPhotoCollection: UICollectionView!

    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var animalFullDescriptionLabel: UILabel!
    @IBOutlet weak var toggleDescriptionButton: UIButton!

    @IBOutlet weak var animalGenderImage: UIImageView!

    @IBOutlet weak var animalSizeImage: UIImageView!

    @IBOutlet weak var animalActivityLevelImage: UIImageView!


    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!


    @IBAction func toggleMoreDescription(sender: AnyObject) {
        animalFullDescriptionLabel.numberOfLines = animalFullDescriptionLabel.numberOfLines == 0 ? 3 : 0
        toggleDescriptionButton.titleLabel?.text = "Pokaż mniej"
    }

    private struct Storyboard {
        static let CellIdentifier = "AnimalPhotoCell"
        static let TableCellIdentifier = "AnimalDetailTableCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.animalFullDescriptionLabel.text = animal.description
        self.navigationItem.title = animal.getAgeName()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        animalPhotos = animal.getAllImages()
        self.animalImageProvider = AnimalImageProvider(animalPhotos: animalPhotos)

        updateUI()


    }

    override func viewDidLayoutSubviews() {
        self.collectionViewHeightConstraint.constant = self.animalPhotoCollection.contentSize.height

         self.tableViewHeightConstraint.constant = self.animalFeaturesTable.contentSize.height
    }

    func updateUI() {
        self.animalPhotoCollection.reloadData()
        self.animalFeaturesTable.dataSource = self
        dispatch_async(dispatch_get_main_queue()) {
            self.animalCenterCircularPhoto.image = self.animalPhotos.first?.image?.circle
            self.animalCenterCircularPhoto.clipsToBounds = true
            self.animalBackgroundPhoto.image = self.animalPhotos.first?.image


            //Update the icons
            if let animalSize = self.animal?.size?.pl() {
                self.animalSizeImage.image = UIImage(named: animalSize)
            }

            if let animalGender = self.animal?.gender?.pl() {
                self.animalGenderImage.image = UIImage(named: animalGender)
            }

            if let animalActivityLevel = self.animal?.activity?.pl() {
                self.animalActivityLevelImage.image = UIImage(named: animalActivityLevel)
            }
        }
    }
}


extension AnimalDetailViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let frame = CGRect(x: 0, y: 0, width: 200, height: 24)
        let headerView = CounterView(frame: frame, currentIndex: indexPath.item, count: animalPhotos.count)
        let footerView = CounterView(frame: frame, currentIndex: indexPath.item, count: animalPhotos.count)

        if let displacedView =  collectionView.cellForItemAtIndexPath(indexPath) as UIView? {

        let galleryViewController = GalleryViewController(imageProvider: self.animalImageProvider, displacedView: displacedView, imageCount: animalPhotos.count, startIndex: indexPath.item)

            galleryViewController.headerView = headerView
            galleryViewController.footerView = footerView

            galleryViewController.landedPageAtIndexCompletion = {index in
                headerView.currentIndex = index
                footerView.currentIndex = index
            }

         self.presentImageGallery(galleryViewController)
        }

        log.debug("Clicked " + indexPath.item.description)
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

extension AnimalDetailViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal.getFeatures().count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.TableCellIdentifier, forIndexPath: indexPath) as? AnimalFeatureTableCell else {
            assert(false, "Table cell should be of type AnimalFeatureTableCell")
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor.clearColor()
        let key = animal.getFeatureKeys()[indexPath.item]
        cell.featureKeyLabel.text = key + ":"
        cell.featureValueLabel.text = animal.getFeatures()[key]

        return cell
    }

}
