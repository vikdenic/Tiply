//
//  ViewController.swift
//  Tiply
//
//  Created by Vik Denic on 4/30/16.
//  Copyright © 2016 vikzilla. All rights reserved.
//

import UIKit
import Chameleon

class MainViewController: UIViewController {

  @IBOutlet var gratStackView: UIStackView!
  @IBOutlet var billTextField: UITextField!
  @IBOutlet var tipLabel: UILabel!
  @IBOutlet var totalLabel: UILabel!
  @IBOutlet var splitLabel: UILabel!
  @IBOutlet var tipButtonTwo: RoundButton!

  var tipAmount = 0.0 {
    didSet {
      tipLabel.text = "$\(String(format:"%.2f", tipAmount))"
    }
  }
  var total = 0.0 {
    didSet {
      totalLabel.text = "Total: $\(String(format:"%.2f", total))"
    }
  }
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
    view.backgroundColor = GradientColor(.TopToBottom, frame: view.frame, colors: [.customGreen(), .customBlue()])
  }

  @IBAction func onArrowTapped(sender: UIButton) {
    if splitCount == 1 {
      if sender.tag == 1 {
        splitCount += 1
      }
      return
    }
    splitCount = sender.tag == 0 ? splitCount - 1 : splitCount + 1
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
    total = billAmount + (tipAmount * Double(splitCount))
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }


}

extension MainViewController: UITextFieldDelegate {

  @IBAction func onBillTextFieldEdited(textField: UITextField) {
    //update values
    if let someAmount = Double(String(textField.text!.characters.dropFirst())) {
      billAmount = someAmount
    } else {
      billAmount = 0.0
    }

    //append $ prefix
    let range = (textField.text! as NSString).rangeOfString("$", options: .CaseInsensitiveSearch)
    if range.location != NSNotFound {
      return
    }
    textField.text = "$" + textField.text!
  }

  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

    if billAmount == 0.0 && string == "0" {
      return false
    }

    let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
    let separatedStrings = newString.componentsSeparatedByString(".")

    if separatedStrings.count > 2 { //prevent multiple decimals
      return false
    }

    if separatedStrings.count >= 2 { //limit to two decimal places
      let sepStr = separatedStrings[1]
      return !(sepStr.characters.count > 2)
    }
    return true
  }

  
}


extension UIColor {
  class func customGreen() -> UIColor {
    return UIColor(red: 108/255.0, green: 167/255.0, blue: 122/255.0, alpha: 1.0)
  }

  class func customBlue() -> UIColor {
    return UIColor(red: 108/255.0, green: 136.0/255.0, blue: 147.0/255.0, alpha: 1.0)
  }


}
