//
//  PreferencesViewController.swift
//  Na4Łapy
//
//  Created by mac on 11/09/2016.
//  Copyright © 2016 Stowarzyszenie Na4Łapy. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {


    @IBOutlet var preferenceButtons: [UIButton]!


    @IBOutlet weak var ageMinSlider: UISlider!
    @IBOutlet weak var ageMaxSlider: UISlider!

    @IBOutlet weak var ageMinLabel: UILabel!
    @IBOutlet weak var ageMaxLabel: UILabel!

    var userPreferences: UserPreferences?

    override func viewDidLoad() {
        super.viewDidLoad()

        userPreferences = UserPreferences.init()
        setUIBasedOnSavedPreferences()

        for button in preferenceButtons {
            button.addTarget(self, action: #selector(onPreferenceButtonTouched), for: .touchUpInside)
        }
    }

    @IBAction func ageMinSliderValueChanged(_ sender: UISlider) {
        let sliderIntValue =  Int (round(sender.value))
        ageMinLabel.text = sliderIntValue.description

        if let savedPreferences = userPreferences {
            savedPreferences.setMinAge(newValue: sliderIntValue)
        }
    }


    @IBAction func ageMaxSliderValueChanged(_ sender: UISlider) {
        let sliderIntValue =  Int (round(sender.value))
        ageMaxLabel.text = sliderIntValue.description
        if let savedPreferences = userPreferences {
            savedPreferences.setMaxAge(newValue: sliderIntValue)
        }
    }

    @IBAction func onSavePreferencesTouched(_ sender: UIButton) {
        if let savedPreferences = userPreferences {
            savedPreferences.savePreferencesToUserDefault()
        }
    }


    func onPreferenceButtonTouched(sender: UIButton!) {
        sender.isSelected = !sender.isSelected
        if let savedPreferences = userPreferences {
            savedPreferences.togglePreferenceAtIndex(preferenceIndex: sender.tag)
        }
    }

    private func setUIBasedOnSavedPreferences() {

        guard let savedPreferences = userPreferences else {
            log.error("Can't initiate userPreferences!!!!!!!!")
            return
        }

        for (_, preferenceValue) in savedPreferences.dictionaryRepresentation().enumerated() {

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

            guard let preferenceIndex = PREFERENCES.index(of: preferenceKey) else {
                continue
            }

            for button in preferenceButtons {
                if(button.tag == preferenceIndex) {
                    button.isSelected = preferenceValue == 1
                }
            }

        }


    }

    @IBAction func toggleAnimalPreference(sender: UIButton) {
        if let savedPreferences = userPreferences {
             savedPreferences.togglePreferenceAtIndex(preferenceIndex: sender.tag)
        }

    }
}
