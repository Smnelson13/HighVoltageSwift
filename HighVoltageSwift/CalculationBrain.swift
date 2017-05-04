//
//  CalculationBrain.swift
//  HighVoltageSwift
//
//  Created by Shane Nelson on 5/1/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation

 class CalculationsBrain: NSObject
{
  var allValuesFound: Bool
  var delegate: CalculationsBrainDelegate
  
  init()
  {
    allValuesFound = false
    ampsString = ""
    ohmsString = ""
    wattsString = ""
    voltsString = ""
  }


 // var calculationToMake = Calculate.amps
  // if the app crashes just check here....
  var ampsString: String
  var ohmsString: String
  var wattsString: String
  var voltsString: String

  public func calculateIfPossible()
  {
    var count = 0
    if ampsString != ""
    {
      count += 1
    }
    if ohmsString != ""
    {
      count += 1
    }
    if wattsString != ""
    {
      count += 1
    }
    if voltsString != ""
    {
      count += 1
    }
    if count >= 2
    {
      calculateAllValues()
    }

  }

  fileprivate func calculateAllValues()
  {
    var amps = 0.0, ohms = 0.0, volts = 0.0, watts = 0.0
    if ohmsString != "" && voltsString != ""
    {
      ohms = (ohmsString as NSString).doubleValue
      volts = (voltsString as NSString).doubleValue
      amps = volts / ohms
      watts = volts * amps
    }
    else if ohmsString != "" && ampsString != ""
    {
      ohms = (ohmsString as NSString).doubleValue
      amps = (ampsString as NSString).doubleValue
      volts = amps * ohms
      watts = volts * amps
    }
    else if ohmsString != "" && wattsString != ""
    {
      ohms = (ohmsString as NSString).doubleValue
      watts = (wattsString as NSString).doubleValue
      amps = sqrt(watts / ohms)
      volts = amps * ohms
    }
    else if ampsString != "" && voltsString != ""
    {
      volts = (voltsString as NSString).doubleValue
      amps = (ampsString as NSString).doubleValue
      ohms = volts / amps
      watts = volts * amps
    }
    else if wattsString != "" && ampsString != ""
    {
      watts = (wattsString as NSString).doubleValue
      amps = (ampsString as NSString).doubleValue
      volts = watts / amps
      ohms = volts / amps
    }
    else if voltsString != "" && wattsString != ""
    {
      volts = (voltsString as NSString).doubleValue
      watts = (wattsString as NSString).doubleValue
      amps = watts / volts
      ohms = volts / amps
    }
    
    voltsString = "\(volts)"
    ampsString = "\(amps)"
    ohmsString = "\(ohms)"
    wattsString = "\(watts)"
    
    allValuesFound = true
    delegate?.valuesWereCalculated()
  }
}
