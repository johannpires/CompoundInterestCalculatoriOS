//
//  ViewController.swift
//  Compound Interest Calculator
//
//  Created by Maria Cottinelli  on 07/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlet properties for each text field and the result label on the UI
    @IBOutlet weak var principalTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var monthlyContributionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var resultString: String?
    
    // IBAction function for the button that calculates the result
    @IBAction func calculateButtonPressed(_ sender: Any) {
        // Guard statements to safely unwrap and convert text field input to Double values
        guard let principal = Double(principalTextField.text ?? ""), principal > 0 else { return }
        guard let rate = Double(rateTextField.text ?? ""), rate > 0 else { return }
        guard let time = Double(timeTextField.text ?? ""), time > 0 else { return }
        guard let monthlyContribution = Double(monthlyContributionTextField.text ?? ""), monthlyContribution > 0 else { return }
        
        let result = compoundInterest(principal: principal, rate: rate, time: time, monthlyContribution: monthlyContribution)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.decimalSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        // Formatting the compound interest and total value using the number formatter
        let compoundInterestFormatted = numberFormatter.string(for: result.compoundInterest)!
        let totalValueFormatted = numberFormatter.string(for: result.totalValue)!
        let resultString = "Once your investment compounds, you'll have the amount of:\n \(totalValueFormatted)\n as your Total Value, and your earnings from Compound Interest will be\n\(compoundInterestFormatted)"

        // Setting resultString
        self.resultString = resultString
        
        // Let's send it now to the ResultStoryBoard
        performSegue(withIdentifier: "ResultVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultVC" {
            if let destinationVC = segue.destination as? ResultViewController {
                destinationVC.resultString = resultString
            }
        }
    }
    
    func compoundInterest(principal: Double, rate: Double, time: Double, monthlyContribution: Double) -> (compoundInterest: Double, totalValue: Double, totalContributions: Double) {
        // Initialize the amount variable to the principal value
        var amount = principal
         // Calculate the annual interest rate
         let annualRate = (1 + rate/100)
         // Calculate the monthly interest rate
         let monthlyRate = pow(annualRate, 1/12) - 1
         // Loop through each month of the investment period and update the amount
         for _ in 1...Int(time*12) {
             amount *= (1 + monthlyRate) // Calculate the monthly interest rate and add it to the amount
             amount += monthlyContribution // Add the monthly contribution to the amount
        }
        // Calculate the total value
        let totalValue = amount
        // Calculate the total contributions
        let totalContributions = monthlyContribution * time * 12
        // Calculate the compound interest
        let compoundInterest = totalValue - principal - totalContributions
        return (compoundInterest, totalValue, totalContributions)
    }
    
}
                
