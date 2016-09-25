//
//  ViewController.swift
//  AdvancedTippy
//
//  Created by Jose Villanuva on 9/24/16.
//  Copyright © 2016 Jose Villanuva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var finalValue = ""
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentageSegment: UISegmentedControl!
    
    let tipPercentage = [0.18, 0.20, 0.25]
    
    @IBOutlet weak var advanceSwitch: UISwitch!
   
    @IBOutlet weak var advanceView: UIView!
    
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var customePercentLabel: UILabel!
    
    
    @IBOutlet weak var splitCustomeSlider: UISlider!
    @IBOutlet weak var splitCountLabel: UILabel!
    
    @IBOutlet weak var totalSplitLabel: UILabel!
    
    struct defaultsKeys {
        static let keyOne = "defaultPercentage"
        static let keyTwo = "username"
        static let keyThree = "billamount"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view will appear")
        
        loadDefaultSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        let defaults = UserDefaults.standard
        if(billField.text != ""){
            defaults.setValue(billField.text!, forKey: defaultsKeys.keyThree)
            defaults.synchronize()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    func loadDefaultSettings(){
        let defaults = UserDefaults.standard
        let defaultPercentValue = defaults.integer(forKey: defaultsKeys.keyOne)
        if(defaultPercentValue > 0){
            if(defaultPercentValue == 18){
                percentageSegment.selectedSegmentIndex = 0
            }else if(defaultPercentValue == 20){
                percentageSegment.selectedSegmentIndex = 1
            }
            else if(defaultPercentValue == 25){
                percentageSegment.selectedSegmentIndex = 2
            }
            else{
                advanceSwitch.setOn(true, animated: true)
                //tipPercentSlider.value = Float(defaultPercentValue/100)
                
                DisplayAdvance(defaultPercentValue: Int(defaultPercentValue))
            }
            
            //nameLabel.text = String(defaultPercentValue)
        }
        
        if let stringOne = defaults.string(forKey: defaultsKeys.keyTwo) {
            nameLabel.text = "Hello " + String(stringOne)
        }
        
        if let stringThree = defaults.string(forKey: defaultsKeys.keyThree) {
            billField.text = String(stringThree)
        }
    }
    

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        if(billField.text != ""){
            let bill = Double(billField.text!) ?? 0
            let tip = bill * tipPercentage[percentageSegment.selectedSegmentIndex]
            let total = bill + tip
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
            finalValue = String(totalLabel.text!)
        }
    }
    
    @IBAction func onAdvanceSwitchChanged(_ sender: AnyObject) {
        if(advanceSwitch.isOn){
            advanceView.isHidden = false;
            percentageSegment.isHidden = true
            tipPercentSlider.value = Float(tipPercentage[percentageSegment.selectedSegmentIndex])
            customePercentLabel.text = String(format:"%.0f", tipPercentage[percentageSegment.selectedSegmentIndex] * 100) + "%"
            splitCustomeSlider.value = 0.10
            calculateAdvance()
        }
        else{
            advanceView.isHidden = true
            percentageSegment.isHidden = false
        }
    }
    
    func DisplayAdvance(defaultPercentValue : Int){
        advanceView.isHidden = false;
        percentageSegment.isHidden = true
        tipPercentSlider.value = Float(defaultPercentValue/100)
        customePercentLabel.text = String(format: "%.0f", tipPercentSlider.value * 100) + "%"
        splitCustomeSlider.value = 0.10
    }

    @IBAction func onTipPercentChanged(_ sender: AnyObject) {
        customePercentLabel.text = String(format: "%.0f", tipPercentSlider.value * 100) + "%"
        calculateAdvance()
    }
    
    
    @IBAction func onSplitCountChanged(_ sender: AnyObject) {
        splitCountLabel.text = String(format: "%.0f", splitCustomeSlider.value/10 * 100)
        calculateAdvance()
    }
    
    func calculateAdvance(){
        if(billField.text != ""){
            let bill = Double(billField.text!) ?? 0
            let tip = bill * Double(tipPercentSlider.value)
            let splitCount = Double(splitCountLabel.text!) ?? 1
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", bill + tip)
            
            let totalSplitted = (bill + tip) / Double(splitCount)
            totalSplitLabel.text = String(format: "$%.2f", totalSplitted)
            finalValue = totalSplitLabel.text!
        }
    }
    @IBAction func onSaveItem(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Alert", message: finalValue + " will be saved!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

