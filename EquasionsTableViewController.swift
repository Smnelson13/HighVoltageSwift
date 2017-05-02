//
//  EquasionsTableViewController.swift
//  HighVoltageSwift
//
//  Created by Shane Nelson on 5/1/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class EquasionsTableViewController:
  UITableViewController,
  UIPopoverPresentationControllerDelegate,
  UITextFieldDelegate
  
  
{
  var allCalculations = [String: String]()
  var remainingCalculations = [String]()
  var visibleCalcualtions = [String]()
  
  var voltsTextField: UITextField?
  var ampsTextField: UITextField?
  var wattsTextField: UITextField?
  var ohmsTextField: UITextField?
  
  var brain = CalculationsBrain()
  
  
  
  override func viewDidLoad()
  {
    tableView?.separatorStyle = .none
    
    super.viewDidLoad()
    
    remainingCalculations = ["watts", "volts", "amps", "ohms"]
    
    for value in remainingCalculations
    {
      allCalculations[value.capitalized] = value
    }

  }

  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int
  {
      // #warning Incomplete implementation, return the number of sections
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
      // #warning Incomplete implementation, return the number of rows
      return 0 
  }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "EquasionCell", for: indexPath) as! EquasionsCell
    
    var calculationName = visibleCalcualtions[indexPath.row]

    cell.calculationLabel.text = calculationName
    if calculationName == "Volts"
    {
      voltsTextField = cell.calculationTextField
    }
    else
    {
      if calculationName == "Watts"
      {
        wattsTextField = cell.calculationTextField
      }
      else
      {
        if calculationName == "Ohms"
        {
          ohmsTextField = cell.calculationTextField
        }
        else
        {
          if calculationName == "Amps"
          {
            ampsTextField = cell.calculationTextField
          }
        }
      }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
      if textField.text == ""
      {
        if textField == voltsTextField
        {
          brain.v = Int((voltsTextField?.text)!)
        }
        else
        {
          if textField == ampsTextField
          {
            brain.i = Int((voltsTextField?.text)!)
          }
          else
          {
            if textField == wattsTextField
            {
              brain.p = Int((wattsTextField?.text)!)
            }
            else
            {
              if textField == ohmsTextField
              {
                brain.r = Int((ohmsTextField?.text)!)
              }
            }
          }
        }
      }
    }
    
    brain.calculateIfPossible()
    
    
      return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == "AddCalculationPopoverSegue"
    {
      let calculationVC = segue.destination as! AddCalculationTableViewController
      calculationVC.calculations = remainingCalculations
      calculationVC.popoverPresentationController?.delegate = self
      calculationVC.delegate = self
      let contentHeight = CGFloat(44 * remainingCalculations.count)
      calculationVC.preferredContentSize = CGSize(width: 200, height: contentHeight)
    } else
    {
      print("Error")
    }
    
    
    func calculationWasChosen(chosenCalculation: String)
  {
    self.navigationController?.dismiss(animated: true	, completion: nil)
    visibleCalcualtions.append(chosenCalculation)
    remainingCalculations.remove(chosenCalculation)
    
    if remainingCalculations.count == 0
    {
      self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
  }
  
  
  
  
  
  }

  /*
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the specified item to be editable.
      return true
  }
  */

  /*
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          // Delete the row from the data source
          tableView.deleteRows(at: [indexPath], with: .fade)
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      }    
  }
  */

  /*
  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

  }
  */

  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      // Return false if you do not want the item to be re-orderable.
      return true
  }
  */

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */

}

extension Array where Element: Equatable {
  mutating func remove(_ element: Element) {
    if let index = self.index(of: element) {
      self.remove(at: index)
    }
  }
}

