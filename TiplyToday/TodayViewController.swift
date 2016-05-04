//
//  TodayViewController.swift
//  TiplyToday
//
//  Created by Vik Denic on 5/3/16.
//  Copyright © 2016 vikzilla. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

  @IBOutlet var percentButtons: [UIButton]!
  @IBOutlet var percent15Button: UIButton!

  var billAmount = 0.0
  var billString = "0.00"

  override func viewDidLoad() {
    super.viewDidLoad()
    percent15Button.selected = true
  }

  @IBAction func onPercentButtonTapped(sender: UIButton) {
    for button in percentButtons {
      button.selected = false
    }
    sender.selected = true
  }

  @IBAction func onCalculatorButtonTapped(sender: UIButton) {

    if !billString.containsString(".") {
      billString += "\(sender.tag)"
      print(billString)
    } else {
      let separatedStrings = billString.componentsSeparatedByString(".")
      if separatedStrings.count >= 2 { //limit to two decimal places
        let sepStr = separatedStrings[1]
        if (sepStr.characters.count >= 2) {
          return
        }
        billString += "\(sender.tag)"
        print(billString)
      }
    }
  }

  @IBAction func onDecimalPointTapped(sender: UIButton) {
    if !billString.containsString(".") {
      billString += "."
    }
    print(billString)
  }

  @IBAction func onClearButtonTapped(sender: UIButton) {
    billString = "0.00"
  }
    
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData

    completionHandler(NCUpdateResult.NewData)
  }

  func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsetsZero
  }

}
