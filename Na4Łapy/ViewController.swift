//
//  ViewController.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var animals : [Animal]?
    var index = 0

    @IBOutlet weak var mainphoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Request.getAnimal(page: 1, size: 10,
            success: { [weak self] (animals) in
                guard let strongSelf = self else { return }
                print(animals.count)
                strongSelf.animals = animals
            },
            failure: { (error) in
                log.error(error.description)
            }
        )
    }
    
    @IBAction func prev(sender: UIButton) {
        if self.index-1 < 0 {
            return
        }
        self.index -= 1
        self.showMainPhoto()
    
    }
    @IBAction func next(sender: UIButton) {
        if index+1 >= self.animals?.count {
            return
        }
        self.index += 1
        self.showMainPhoto()
    }

    private func showMainPhoto() {
        guard let image = self.animals?[self.index].getFirstImage() else {
            log.error("Brak głównego zdjęcia")
            return
        }
        self.mainphoto.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

