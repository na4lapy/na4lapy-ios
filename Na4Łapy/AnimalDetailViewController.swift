//
//  AnimalDetailViewController.swift
//  Na4Łapy
//
//  Created by mac on 09/07/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit
import ImageViewer
import SKPhotoBrowser

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

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reloadAnimalPhoto(_:)), name: "ReloadDetailView", object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        animalPhotos = animal.getAllImages()
        self.animalImageProvider = AnimalImageProvider(animalPhotos: animalPhotos)

        updateUI()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func viewDidLayoutSubviews() {
        self.collectionViewHeightConstraint.constant = self.animalPhotoCollection.contentSize.height

         self.tableViewHeightConstraint.constant = self.animalFeaturesTable.contentSize.height
        }

    @objc func reloadAnimalPhoto(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.animalPhotoCollection.reloadData()
        }
    }
    
    func updateUI() {
        dispatch_async(dispatch_get_main_queue()) {
            self.animalPhotoCollection.reloadData()
            self.animalFeaturesTable.dataSource = self
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}

extension AnimalDetailViewController: SKPhotoBrowserDelegate {
    func didShowPhotoAtIndex(index: Int) {
        dispatch_async(dispatch_get_main_queue()) {
            self.animalPhotoCollection.visibleCells().forEach({$0.hidden = false})
            self.animalPhotoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))?.hidden = true
        }
    }
    
    func willDismissAtPageIndex(index: Int) {
        dispatch_async(dispatch_get_main_queue()) {
            self.animalPhotoCollection.visibleCells().forEach({$0.hidden = false})
            self.animalPhotoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))?.hidden = true
        }
    }
    
    func didDismissAtPageIndex(index: Int) {
        dispatch_async(dispatch_get_main_queue()) {
            self.animalPhotoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))?.hidden = false
        }
    }
    
    func viewForPhoto(browser: SKPhotoBrowser, index: Int) -> UIView? {
        return animalPhotoCollection.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
    }
    
    func removePhoto(browser: SKPhotoBrowser, index: Int, reload: (() -> Void)) {
        reload()
    }
    
}

extension AnimalDetailViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AnimalPhotoCell else {
            return
        }
        
        let browser = SKPhotoBrowser(originImage: cell.animalImage.image!, photos: self.animalImageProvider.animalPhotos, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
        browser.statusBarStyle = .LightContent
        browser.bounceAnimation = true
        browser.delegate = self
        presentViewController(browser, animated: true, completion: {})

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

        cell.animalImage.image = self.animalPhotos[indexPath.item].image

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
