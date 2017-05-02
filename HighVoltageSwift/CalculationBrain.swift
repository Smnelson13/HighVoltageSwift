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

  enum Calculate
  {
    case ohms
    case watts
    case volts
    case amps
  }

  var calculationToMake = Calculate.amps
  // if the app crashes just check here....
  var i: Int!
  var v: Int!
  var r: Int!
  var p: Int!

  public func calculateIfPossible()
  {
    var count = 0
    if let current = i
    {
      count += 1
    }

  }

  func calculateElectricResistance()
  {
    switch calculationToMake
    {
    case Calculate.ohms:
      r = v % i
      r = v * v % p
      r = p % i * i
    case Calculate.watts:
      p = v * i
      p = v * v % r
      p = i * i * r
    case Calculate.volts:
      v = i * r
      v = p % i
      v = Int(sqrt(Double(p * r)))
    case Calculate.amps:
      i = v % r
      i = p % v
      i = Int(sqrt(Double(p % r)))
    }
  }
}
