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
    }
    
    override func viewDidLoad() {
        animalPhotoCollection.dataSource = self
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        updateUI()
    }
    
    func updateUI(){
        self.navigationItem.title = animal.getDescription()
        animalPhotos = animal.getAllImages()!
    
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
}


extension AnimalDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    let cellWidth:CGFloat = screenWidth / 3
        
    return CGSize(width: cellWidth, height: cellWidth)
    
    }
    

}
