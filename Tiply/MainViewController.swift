//
//  ViewController.swift
//  Tiply
//
//  Created by Vik Denic on 4/30/16.
//  Copyright © 2016 vikzilla. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet var gratStackView: UIStackView!
  @IBOutlet var billTextField: UITextField!
  @IBOutlet var tipLabel: UILabel!
  @IBOutlet var totalLabel: UILabel!
  @IBOutlet var splitLabel: UILabel!
  @IBOutlet var tipButtonTwo: RoundButton!

  var tipAmount = 0.0
  var total = 0.0
  var billAmount = 0.0 {
    didSet {
      calculateTip()
    }
  }
  var tipPercent = 0.15 {
    didSet {
      calculateTip()
    }
  }
  var splitCount = 1 {
    didSet {
      calculateTip()
      splitLabel.text = "\(splitCount)"
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tipButtonTwo.selected = true
  }

  @IBAction func onArrowTapped(sender: UIButton) {
    if splitCount == 1 {
      if sender.tag == 1 {
        splitCount++
      }
      return
    }
    sender.tag == 0 ? splitCount-- : splitCount++
  }

  @IBAction func onTipButtonTapped(sender: RoundButton) {
    selectButton(sender)
    switch sender.tag {
    case 0:
      tipPercent = 0.10
    case 2:
      tipPercent = 0.20
    case 3:
      tipPercent = 0.25
    default:
      tipPercent = 0.15
    }
  }

  func selectButton(button : RoundButton) {
    for view in gratStackView.arrangedSubviews {
      (view as! RoundButton).selected = false
    }
    button.selected = true
  }

  func calculateTip() {
    tipAmount = (billAmount * tipPercent) / Double(splitCount)
    print(tipAmount)
    tipLabel.text = "$\(String(format:"%.2f", tipAmount))"
  }


}

extension MainViewController: UITextFieldDelegate {

  @IBAction func onBillTextFieldEdited(textField: UITextField) {
    //update values
    if let someAmount = Double(String(textField.text!.characters.dropFirst())) {
      billAmount = someAmount
    }

    //append $ prefix
    let range = (textField.text! as NSString).rangeOfString("$", options: .CaseInsensitiveSearch)
    if range.location != NSNotFound {
      return
    }
    textField.text = "$" + textField.text!
  }

  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

    let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
    let separatedStrings = newString.componentsSeparatedByString(".")

    if separatedStrings.count > 2 { //prevent mulitple decimals
      return false
    }

    if separatedStrings.count >= 2 { //limit to two decimal places
      let sepStr = separatedStrings[1]
      return !(sepStr.characters.count > 2)
    }

    return true
  }

  
}
