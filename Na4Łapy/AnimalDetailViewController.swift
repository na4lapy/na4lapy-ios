//
//  AnimalDetailViewController.swift
//  Na4Łapy
//
//  Created by mac on 09/07/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    var animal:Animal!
    private var animalPhotos:[Photo]!
    @IBOutlet weak var animalCenterCircularPhoto: UIImageView!
    @IBOutlet weak var animalBackgroundPhoto: UIImageView!
    
    @IBOutlet weak var animalPhotoCollection: UICollectionView!
    
    private struct Storyboard {
        static let CellIdentifier = "AnimalPhotoCell"
        static let FooterIdentifier = "AnimalDetailsCollectionFooter"
    }
    
    override func viewDidLoad() {
        animalPhotoCollection.dataSource = self
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        animalPhotos = animal.getAllImages()
        updateUI()
    }
    
    
    func updateUI(){
        self.navigationItem.title = animal.getAgeName()
    
        animalPhotoCollection.reloadData()
        
        animalCenterCircularPhoto.image = animalPhotos.first?.image?.circle
        animalCenterCircularPhoto.clipsToBounds = true
        animalBackgroundPhoto.image = animalPhotos.first?.image
        
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! AnimalPhotoCell
        
        cell.animalImage.image = animalPhotos[indexPath.item].image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
        if kind == UICollectionElementKindSectionFooter {
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: Storyboard.FooterIdentifier, forIndexPath: indexPath) as! AnimalDetailPhotosCollectionFooter
            headerView.animalFullDescriptionLabel.text = animal.description
            
            return headerView
        }
        assert(false, "Unexpected element kind")
    }
}


extension AnimalDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    let cellWidth:CGFloat = screenWidth / 3 - 10
        
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
