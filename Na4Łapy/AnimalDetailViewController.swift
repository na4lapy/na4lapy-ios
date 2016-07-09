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
    private var animalPhoto:UIImage!
    
    @IBOutlet weak var animalCenterCircularPhoto: UIImageView!
    @IBOutlet weak var animalBackgroundPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        updateUI()
    }
    
    func updateUI(){
        self.navigationItem.title = animal.getDescription()
        animalPhoto = animal.getFirstImage()!
        animalCenterCircularPhoto.image = animalPhoto.circle
//        animalCenterCircularPhoto.layer.cornerRadius = animalCenterCircularPhoto.bounds.size.width/2
        animalCenterCircularPhoto.clipsToBounds = true
        animalBackgroundPhoto.image = animalPhoto
        
        
    }
    

}
