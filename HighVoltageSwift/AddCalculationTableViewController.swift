//
//  AddCalculationTableViewController.swift
//  HighVoltageSwift
//
//  Created by Shane Nelson on 5/1/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//


import UIKit

class ValueTypesTableViewController: UITableViewController
{
  
  var delegate: ValueTypesViewControllerDelegate?
  var valueTypes = [String]()
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TypeCell")
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
    return valueTypes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
    
    cell.textLabel?.text = self.valueTypes[indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    delegate?.valueTypeWasChosen(valueTypes[indexPath.row])
  }
}
