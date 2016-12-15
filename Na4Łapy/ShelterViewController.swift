//
//  ShelterViewController.swift
//  Na4Łapy
//
//  Created by Wojciech Bilicki on 18/09/2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit

class ShelterViewController: UIViewController {
    @IBOutlet private weak var adres: UILabel!
    @IBOutlet private weak var adresSecondLine: UILabel!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var phoneNumber: UILabel!
    @IBOutlet private weak var website: UILabel!
    @IBOutlet private weak var accountNumber: UILabel!
    @IBOutlet private weak var adoptionRules: UILabel!
    @IBOutlet weak var containerView: UIView!
    var shelter: Shelter?

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        Shelter.get(1, size: 1, preferences: nil, success: { [weak self] json, size in
            if let shelter = json[0] as? Shelter {

                DispatchQueue.main.async(execute: {
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
            adres.text = shelter.getAdress()
            adresSecondLine.text = shelter.getAdressSecondLine()
            email.text = shelter.email
            website.text = shelter.website
            accountNumber.text = shelter.accountNumber
            adoptionRules.text = shelter.adoptionRules
            phoneNumber.text = shelter.phoneNumber
        }
        log.debug(self.scrollView.contentSize.height.description)
        log.debug(self.containerView.bounds.height.description)
    }
}
