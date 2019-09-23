//
//  ViewController.swift
//  Calculator
//
//  Created by Aljandali, Abdullah on 8/30/19.
//  Copyright © 2019 Aljandali, Abdullah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var result: UILabel!
    let myCalculatorEngine = CalculatorEngine()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        result.numberOfLines = 1
        result.adjustsFontSizeToFitWidth = true
        result.minimumScaleFactor = 8/result.font.pointSize

    }

    // Actions:
    
    
   @IBAction func buttonPressed(_ sender: Any) {
    let buttonTitle = (sender as! UIButton).titleLabel?.text
    if result.text == "ERROR" {
        result.text = "0";
    }
    else{
        let newResult = myCalculatorEngine.buttonPressed(buttonTitle: buttonTitle ?? "1", currentDisplay: result.text!)
        result.text! =  ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.result.text! =  newResult
        }
    }
    }
}
