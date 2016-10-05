//
//  ShelterViewController.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 18/09/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class ShelterViewController: UIViewController {

    @IBOutlet weak var adres: UILabel!
    @IBOutlet weak var adresSecondLine: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var adoptionRules: UILabel!

    @IBOutlet weak var containerView: UIView!
    private var shelter: Shelter?

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {

        Shelter.get(1, size: 1, preferences: nil, success: { [weak self] json, size in
            if let shelter = json[0] as? Shelter {
                dispatch_async(dispatch_get_main_queue(), {
                    self?.shelter = shelter
                    self?.updateUI()
                })
            }
            }) { (error) in
                log.debug(error.localizedDescription)
        }
    }

    private func updateUI() {
        if let shelter = self.shelter {
            self.adres.text = shelter.getAdress()
            self.adresSecondLine.text = shelter.getAdressSecondLine()
            self.email.text = shelter.email
            self.website.text = shelter.website
            self.accountNumber.text = shelter.accountNumber
            self.adoptionRules.text = shelter.adoptionRules
            self.phoneNumber.text = shelter.phoneNumber
        }
        log.debug(self.scrollView.contentSize.height.description)
        log.debug(self.containerView.bounds.height.description)
    }


}
