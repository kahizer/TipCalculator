//
//  SettingsViewController.swift
//  AdvancedTippy
//
//  Created by Jose Villanuva on 9/24/16.
//  Copyright © 2016 Jose Villanuva. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultPercentField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultSettings()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    struct defaultsKeys {
        static let keyOne = "defaultPercentage"
        static let keyTwo = "username"
    }
    
    @IBAction func onSaveDefaults(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard
        var addedDefault = false
        
        if(usernameField.text != ""){
            addedDefault = true
            defaults.setValue(usernameField.text!, forKey: defaultsKeys.keyTwo)
        }
        
        
        if(defaultPercentField.text != ""){
            addedDefault = true
            let defaultPercent = Int(defaultPercentField.text!)
            defaults.set(defaultPercent, forKey: defaultsKeys.keyOne)
        }
        
        if(addedDefault){
            defaults.synchronize()
        }
    }
    
    
    func loadDefaultSettings(){
        let defaults = UserDefaults.standard
        let defaultPercentValue = defaults.integer(forKey: defaultsKeys.keyOne)
        if(defaultPercentValue > 0){
            defaultPercentField.text = String(defaultPercentValue)
        }
        
        if let stringOne = defaults.string(forKey: defaultsKeys.keyTwo) {
            usernameField.text = String(stringOne)
        }
    }

}
