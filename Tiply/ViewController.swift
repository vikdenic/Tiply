//
//  ViewController.swift
//  Tiply
//
//  Created by Vik Denic on 4/30/16.
//  Copyright © 2016 vikzilla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
      }
    } else {
      sender.tag == 0 ? splitCount-- : splitCount++
    }
  }


}

