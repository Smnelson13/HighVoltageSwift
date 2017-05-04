//
//  EquasionsCell.swift
//  HighVoltageSwift
//
//  Created by Shane Nelson on 5/1/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit


class EquasionsCell: UITableViewCell
  

{
  @IBOutlet weak var calculationTextField: UITextField!

  @IBOutlet weak var calculationLabel: UILabel!
  
  override func awakeFromNib()
  {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool)
  {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
