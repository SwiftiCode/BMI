//
//  ViewController.swift
//  BMI
//
//  Created by SwiftiCode on 21/6/20.
//  Copyright © 2020 SwiftiCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: Property
    @IBOutlet weak var bmiHeightTxtField: UITextField!
    @IBOutlet weak var bmiWeightTxtField: UITextField!
    @IBOutlet weak var bmiResultLabel: UILabel!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bmiHeightTxtField.delegate = self
        bmiWeightTxtField.delegate = self
    }
    
    // MARK: Function
    func bmi(height: Double, weight: Double) -> (result: Double, status: String, risk: String) {
        
        let result = (weight / ((height / 100) * (height / 100)))

        var status = String()
        switch result {
            case 0...18.4:
                status = "Underweight"
            case 18.5...24.9:
                status = "Normal"
            case 25.0...29.9:
                status = "Overweight"
            case 30.0...34.9:
                status = "Class I Obesity"
            case 35.0...39.9:
                status = "Class II Obesity"
            default:
                status = "Class III Obesity"
        }
        
        var riskStatement = String()
        switch result {
            case 18.5...22.9:
                riskStatement = "Low Risk"
            case 23...27.4:
                riskStatement = "Moderate Risk"
            case let x where x > 27.5:
                riskStatement = "High Risk"
            default:
                riskStatement = "Undefined Risk"
        }
        
        return (result, status, riskStatement)
    }
    
    func checkValidity() -> Bool {
        let gotHeight = Double(bmiHeightTxtField.text ?? "")
        //print(gotHeight)
        
        let gotWeight = Double(bmiWeightTxtField.text ?? "")
        //print(gotWeight)
        
        if gotHeight != nil && gotWeight != nil {
            return true
        } else {
            return false
        }
    }

    func displayBMI() {
        
        var calHeight: Double? = 0.0
        var calWeight: Double? = 0.0
        
        calHeight = Double(bmiHeightTxtField.text!)
        calWeight = Double(bmiWeightTxtField.text!)
        
        
        let answer = bmi(height: calHeight!, weight: calWeight!)
        let formattedAnswer = String(format: "%0.2f", answer.result)
        bmiResultLabel.text = "Your BMI is \(formattedAnswer). You are \(answer.status). Your are at \(answer.risk)."
        
    }
    
    func mainProcess() {
        let goodNumber = checkValidity()
        if goodNumber {
            displayBMI()
        } else {
            bmiResultLabel.text = "---"
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        mainProcess()
    }
    
    // MARK: IBAction
    @IBAction func hideKB(_ sender: UITapGestureRecognizer) {
        
        bmiWeightTxtField.resignFirstResponder()
        bmiHeightTxtField.resignFirstResponder()
    }
    


}

