//
//  ViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainphoto: UIImageView!
    var listingController: Listing?

    @IBAction func prev(sender: UIButton) {
        guard let animal = self.listingController?.prev() as? Animal else {
            return
        }
        self.mainphoto.image = animal.getFirstImage()
    }

    @IBAction func next(sender: UIButton) {
        guard let animal = self.listingController?.next() as? Animal else {
            return
        }
        self.mainphoto.image = animal.getFirstImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.listingController = Listing(listingType: Animal.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
