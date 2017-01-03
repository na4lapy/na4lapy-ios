//
//  AnimalDetailViewController.swift
//  Na4Łapy
//
//  Created by mac on 09/07/2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class AnimalDetailViewController: UIViewController {

    var animal: Animal!
    fileprivate var animalPhotos: [Photo]?
    fileprivate var animalImageProvider: AnimalImageProvider!

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

    @IBAction func toggleMoreDescription(_ sender: AnyObject) {
        animalFullDescriptionLabel.numberOfLines = animalFullDescriptionLabel.numberOfLines == 0 ? 3 : 0
        toggleDescriptionButton.titleLabel?.text = "Pokaż mniej"
    }

    fileprivate struct Storyboard {
        static let CellIdentifier = "AnimalPhotoCell"
        static let TableCellIdentifier = "AnimalDetailTableCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.animalFullDescriptionLabel.text = animal.description
        self.navigationItem.title = animal.getAgeName()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadAnimalPhoto(_:)), name: NSNotification.Name(rawValue: "ReloadDetailView"), object: nil)

        self.animalFeaturesTable.separatorStyle = UITableViewCellSeparatorStyle.none
        self.animalFeaturesTable.rowHeight = 24.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let animalPhotos = animal.getAllImages() {
            self.animalImageProvider = AnimalImageProvider(animalPhotos: animalPhotos)
        }

        updateUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLayoutSubviews() {
        self.collectionViewHeightConstraint.constant = self.animalPhotoCollection.contentSize.height

         self.tableViewHeightConstraint.constant = self.animalFeaturesTable.contentSize.height
        }

    @objc func reloadAnimalPhoto(_ notification: Notification) {
        DispatchQueue.main.async {
            self.animalPhotoCollection.reloadData()
        }
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.animalPhotoCollection.reloadData()
            self.animalFeaturesTable.dataSource = self
            self.animalCenterCircularPhoto.image = self.animalPhotos?.first?.image?.circle
            self.animalCenterCircularPhoto.clipsToBounds = true
            self.animalBackgroundPhoto.image = self.animalPhotos?.first?.image

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

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden : Bool {
        return false
    }
}

extension AnimalDetailViewController: SKPhotoBrowserDelegate {
    func didShowPhotoAtIndex(_ index: Int) {
        DispatchQueue.main.async {
            self.animalPhotoCollection.visibleCells.forEach({$0.isHidden = false})
            self.animalPhotoCollection.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
        }
    }

    func willDismissAtPageIndex(_ index: Int) {
        DispatchQueue.main.async {
            self.animalPhotoCollection.visibleCells.forEach({$0.isHidden = false})
            self.animalPhotoCollection.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
        }
    }

    func didDismissAtPageIndex(_ index: Int) {
        DispatchQueue.main.async {
            self.animalPhotoCollection.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
        }
    }

    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        return animalPhotoCollection.cellForItem(at: IndexPath(item: index, section: 0))
    }

    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: (() -> Void)) {
        reload()
    }

}

extension AnimalDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimalPhotoCell else {
            return
        }

        let browser = SKPhotoBrowser(originImage: cell.animalImage.image!, photos: self.animalImageProvider.animalPhotos, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
//        browser.statusBarStyle = .LightContent
//        browser.bounceAnimation = true
        browser.delegate = self
        present(browser, animated: true, completion: {})

        log.debug("Clicked " + (indexPath as NSIndexPath).item.description)
    }
}

extension AnimalDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalPhotos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as? AnimalPhotoCell  else {
            return UICollectionViewCell()
        }

        cell.animalImage.image = self.animalPhotos?[(indexPath as NSIndexPath).item].image

        return cell
    }
}


extension AnimalDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenWidth = UIScreen.main.bounds.size.width
        let cellWidth: CGFloat = screenWidth / 3 - 10

        return CGSize(width: ceil(cellWidth), height: ceil(cellWidth))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension AnimalDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal.getFeatures().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TableCellIdentifier, for: indexPath) as? AnimalFeatureTableCell else {
            assert(false, "Table cell should be of type AnimalFeatureTableCell")
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor.clear
        let key = animal.getFeatureKeys()[(indexPath as NSIndexPath).item]
        cell.featureKeyLabel.text = key + ":"
        cell.featureValueLabel.text = animal.getFeatures()[key]

        return cell
    }
}
