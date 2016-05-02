//
//  RoundButton.swift
//  Tiply
//
//  Created by Vik Denic on 4/30/16.
//  Copyright © 2016 vikzilla. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
  
  override func drawRect(rect: CGRect) {
    self.clipsToBounds = true
    self.layer.cornerRadius = self.bounds.size.width / 2
  }


}

