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

  var splitCount = 1 {
    didSet {
      splitLabel.text = "\(splitCount)"
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func onArrowTapped(sender: UIButton) {
    if splitCount == 1 {
      if sender.tag == 1 {
        splitCount++
        return
      }
    }
    sender.tag == 0 ? splitCount-- : splitCount++
  }


}

extension MainViewController: UITextFieldDelegate {

  @IBAction func onBillTextFieldEdited(textField: UITextField) {
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

