//
//  EquasionsTableViewController.swift
//  HighVoltageSwift
//
//  Created by Shane Nelson on 5/1/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

protocol ValueTypesViewControllerDelegate
{
  func valueTypeWasChosen(_ chosenValueType: String)
}

protocol ElectricityConversionsDelegate
{
  func valuesWereCalculated()
}

class EquasionsTableViewController: UITableViewController, ValueTypesViewControllerDelegate, ElectricityConversionsDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate
{
  
  @IBOutlet weak var clearBarButtonItem: UIBarButtonItem!
  @IBOutlet weak var addValueTypeBarButtonItem: UIBarButtonItem!
  
  var currentTextField: UITextField?
  var resistanceTextField: UITextField?
  var voltageTextField: UITextField?
  var powerTextField: UITextField?
  
  var converter: ElectricityConversions?
  
  var tableData = [String]()
  var valueTypes: Dictionary<String, String> = ["Amps": "CurrentCell", "Ohms": "ResistanceCell", "Volts": "VoltageCell", "Watts": "PowerCell"]
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.title = "High Voltage"
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return tableData.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
  {
    if tableData.count > 0
    {
      return "Enter two values"
    }
    else
    {
      return ""
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let identifier = tableData[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    
    let textField = cell.viewWithTag(1) as! UITextField
    textField.text = ""
    textField.delegate = self
    textField.isUserInteractionEnabled = !converter!.allValuesFound
    
    switch identifier
    {
    case "CurrentCell":
      currentTextField = textField
      if converter?.ampsString != ""
      {
        textField.text = converter?.ampsString
      }
      
    case "ResistanceCell":
      resistanceTextField = textField
      if converter?.ohmsString != ""
      {
        textField.text = converter?.ohmsString
      }
      
    case "PowerCell":
      powerTextField = textField
      if converter?.wattsString != ""
      {
        textField.text = converter?.wattsString
      }
      
    case "VoltageCell":
      voltageTextField = textField
      if converter?.voltsString != ""
      {
        textField.text = converter?.voltsString
      }
      
    default:
      print("")
    }
    
    let keys = (valueTypes as NSDictionary).allKeys(for: identifier) as! [String]
    let keyToRemove = keys[0]
    valueTypes.removeValue(forKey: keyToRemove)
    
    textField.becomeFirstResponder()
    
    return cell
  }
  
  // MARK: - UITextField delegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    var rc = false
    if textField.text != ""
    {
      rc = true
      if textField == currentTextField
      {
        converter?.ampsString = textField.text!
      }
      if textField == resistanceTextField
      {
        converter?.ohmsString = textField.text!
      }
      if textField == voltageTextField
      {
        converter?.voltsString = textField.text!
      }
      if textField == powerTextField
      {
        converter?.wattsString = textField.text!
      }
    }
    
    if rc
    {
      textField.resignFirstResponder()
    }
    
    converter?.findOtherValuesIfPossible()
    
    return rc
  }
  
  // MARK: - ValueTypesViewController delegate
  
  func valueTypeWasChosen(_ chosenValueType: String)
  {
    navigationController?.dismiss(animated: true, completion: nil)
    if converter == nil
    {
      converter = ElectricityConversions()
      converter?.delegate = self
    }
    
    let cellIdentifier = valueTypes[chosenValueType]
    tableData.append(cellIdentifier!)
    if tableData.count == 2
    {
      addValueTypeBarButtonItem.isEnabled = false
    }
    
    let row = (tableData as NSArray).index(of: cellIdentifier!)
    tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
  }
  
  // MARK: - ElectricityConversions delegate
  
  func valuesWereCalculated()
  {
    resetValueTypesDictionary()
    
    if voltageTextField == nil
    {
      let cellIdentifier = valueTypes["Volts"]
      tableData.append(cellIdentifier!)
    }
    if currentTextField == nil
    {
      let cellIdentifier = valueTypes["Amps"]
      tableData.append(cellIdentifier!)
    }
    if resistanceTextField == nil
    {
      let cellIdentifier = valueTypes["Ohms"]
      tableData.append(cellIdentifier!)
    }
    if powerTextField == nil
    {
      let cellIdentifier = valueTypes["Watts"]
      tableData.append(cellIdentifier!)
    }
    
    tableView.reloadData()
  }
  
  // MARK: - Action Handlers
  
  @IBAction func clearTransaction(_ sender: UIBarButtonItem)
  {
    tableData.removeAll(keepingCapacity: true)
    addValueTypeBarButtonItem.isEnabled = true
    converter = nil
    voltageTextField = nil
    currentTextField = nil
    resistanceTextField = nil
    powerTextField = nil
    resetValueTypesDictionary()
    tableView.reloadData()
  }
  
  @IBAction func addNewElectricityType(sender: UIBarButtonItem)
  {
    let valueTypesVC = ValueTypesTableViewController(style: .plain)
    valueTypesVC.modalPresentationStyle = .popover
    valueTypesVC.delegate = self
    valueTypesVC.popoverPresentationController?.delegate = self
    valueTypesVC.popoverPresentationController?.barButtonItem = sender
    let contentHeight = 44.0 * CGFloat(valueTypes.count)
    valueTypesVC.preferredContentSize = CGSize(width: CGFloat(100.0), height: contentHeight)
    valueTypesVC.valueTypes = Array(valueTypes.keys)
    present(valueTypesVC, animated: true, completion: nil)
  }
  
  // MARK: - UIPopoverPresentation delegate
  
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
  {
    return .none
  }
  
  // MARK: - Private methods
  
  func resetValueTypesDictionary()
  {
    valueTypes.removeAll(keepingCapacity: true)
    valueTypes = ["Amps": "CurrentCell", "Ohms": "ResistanceCell", "Volts": "VoltageCell", "Watts": "PowerCell"]
  }
}
