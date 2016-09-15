//
//  PreferencesViewController.swift
//  Na4Łapy
//
//  Created by mac on 11/09/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    @IBOutlet weak var typeDogButton: UIButton!
    @IBOutlet weak var typeCatButton: UIButton!
    @IBOutlet weak var typeOtherButton: UIButton!

    @IBOutlet weak var genderFemale: UIButton!
    @IBOutlet weak var genderMale: UIButton!

    @IBOutlet weak var sizeSmallButton: UIButton!
    @IBOutlet weak var sizeMediumButton: UIButton!
    @IBOutlet weak var sizeLargeButton: UIButton!

    @IBOutlet weak var activityHigh: UIButton!
    @IBOutlet weak var activityLow: UIButton!

    @IBOutlet weak var ageMinSlider: UISlider!
    @IBOutlet weak var ageMaxSlider: UISlider!

    @IBOutlet weak var ageMinLabel: UILabel!
    @IBOutlet weak var ageMaxLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUIBasedOnSavedPreferences()
        // Do any additional setup after loading the view.
        //TODO: Set the starting state for buttons and scroll
    }

    @IBAction func ageMinSliderValueChanged(sender: UISlider) {
        let sliderIntValue =  Int (round(sender.value))
        ageMinLabel.text = sliderIntValue.description
    }


    @IBAction func ageMaxSliderValueChanged(sender: UISlider) {
        let sliderIntValue =  Int (round(sender.value))
        ageMaxLabel.text = sliderIntValue.description
    }


    private func setUIBasedOnSavedPreferences() {
        guard let savedPreferences =  UserPreferences.init()  else {
            //TODO: throw error instead

            return
        }

        var buttonTuple: (String?, UIButton?)
        for (_, preferenceValue) in savedPreferences.dictionaryRepresentation().enumerate() {

            let (preferenceKey, preferenceValue) = preferenceValue

            if preferenceKey == ageBoundaries.ageMax.rawValue {
                ageMaxSlider.value = Float(preferenceValue)
                ageMaxLabel.text = preferenceValue.description
                continue
            } else if preferenceKey == ageBoundaries.ageMin.rawValue {
                ageMinSlider.value = Float(preferenceValue)
                ageMinLabel.text = preferenceValue.description
                continue
            }



            switch preferenceKey {
            case Species.dog.rawValue:
                buttonTuple.0 = "preferencjePies"
                buttonTuple.1 = typeDogButton
            case Species.cat.rawValue:
                buttonTuple.0 = "preferencjeKot"
                buttonTuple.1 = typeCatButton
            case Species.other.rawValue:
                buttonTuple.0 = "preferencjeInny"
                buttonTuple.1 = typeOtherButton
            case Gender.female.rawValue:
                buttonTuple.0 = "preferencjeSuczka"
                buttonTuple.1 = genderFemale
            case Gender.male.rawValue:
                buttonTuple.0 = "preferencjeSamiec"
                buttonTuple.1 = genderMale
            case Size.small.rawValue:
                buttonTuple.0 = "preferencjeMaly"
                buttonTuple.1 = sizeSmallButton
            case Size.medium.rawValue:
                buttonTuple.0 = "preferencjeSredni"
                buttonTuple.1 = sizeMediumButton
            case Size.large.rawValue:
                buttonTuple.0 = "preferencjeDuzy"
                buttonTuple.1 = sizeLargeButton
            case Activity.high.rawValue:
                buttonTuple.0 = "preferencjeAktywny"
                buttonTuple.1 = activityHigh
            case Activity.low.rawValue:
                buttonTuple.0 = "preferencjeDomator"
                buttonTuple.1 = activityLow
            default:
                break
            }

            if let button = buttonTuple.1, imageName = buttonTuple.0 {
                button.selected = preferenceValue == 1
            }
        }

    }


    @IBAction func toggleAnimalPreference(sender: UIButton) {
        log.debug(sender.tag.description)
    }
}
