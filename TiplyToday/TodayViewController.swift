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
    
  func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.

    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData

    completionHandler(NCUpdateResult.NewData)
  }
    
}
