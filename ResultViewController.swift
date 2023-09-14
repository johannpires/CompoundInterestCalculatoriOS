//
//  ResultViewController.swift
//  Compound Interest Calculator
//
//  Created by Maria Cottinelli  on 03/04/2023.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var compoundInterestLabel: UILabel!
    
    var resultString: String?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Check if resultString is not nil
            guard let resultString = resultString else {
                return
                
            }
            // Split the resultString by " and " to separate the parts
            let parts = resultString.components(separatedBy: " and ")
            // Check if there are exactly two parts
            guard parts.count == 2 else {
                return
                
            }
            // Extract the values for Total Value and Compound Interest
            let totalValueString = parts[0].replacingOccurrences(of: "Once your investment compounds, you'll have the amount of:\n", with: "").replacingOccurrences(of: "\n as your Total Value,", with: "")
            let compoundInterestString = parts[1].replacingOccurrences(of: "your earnings from Compound Interest will be\n", with: "")
            
            // Set the labels with the extracted values
            totalValueLabel.text = totalValueString
            compoundInterestLabel.text = compoundInterestString
            
            //Setting the resultLabel with its original result string
            
            resultLabel.text = resultString
        }
        
    }
