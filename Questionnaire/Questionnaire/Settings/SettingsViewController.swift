//
//  SettingsViewController.swift
//  Questionnaire
//
//  Created by Игорь Пенкин on 27.02.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var randomizingSwitcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRandomizingSwitcher()
        // Do any additional setup after loading the view.
    }
    
    private func setupRandomizingSwitcher() {
        guard let questionOrder = UserDefaults.standard.object(forKey: Game.shared.orderKey) as? QuestionOrder.RawValue else {
            randomizingSwitcher.isOn = false
            return
        }
        switch questionOrder {
        case QuestionOrder.serial.rawValue:
            randomizingSwitcher.isOn = false
        case QuestionOrder.random.rawValue:
            randomizingSwitcher.isOn = true
        default:
            print("\nINFO: Error while setting switcher")
        }
    }
    
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func randomizingSwitcherTurned(_ sender: Any) {
        switch randomizingSwitcher.isOn {
        case true:
            let order = QuestionOrder.random.rawValue
            UserDefaults.standard.setValue(order, forKey: Game.shared.orderKey)
        case false:
            let order = QuestionOrder.serial.rawValue
            UserDefaults.standard.setValue(order, forKey: Game.shared.orderKey)
        }
        print("\nINFO: Switcher for Random was pressed: \(UserDefaults.standard.object(forKey: Game.shared.orderKey))")
        print(randomizingSwitcher.isOn)
    }
    
}
