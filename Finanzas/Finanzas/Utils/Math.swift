//
//  Math.swift
//  Finanzas
//
//  Created by Daniel Aragon Ore on 6/16/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//

import UIKit

public class Math {
    
    static func computeIRR(cashFlows:[Double], presentValues: (([Double]) -> ())? = nil) -> Double? {
        
        // const
        let MAX_ITERATION = 1000        // Max Iteration
        let PRECISION_REQ = 0.00000001  // Percision
        
        // variable
        var guessRate0: Double = 0.1;   // Default: 10%
        var guessRate1: Double = 0.0;
        var derivative: Double = 0.0;
        var nowCash: Double = 0.0;
        var npv: Double = 0.0;
        
        let numOfFlows = cashFlows.count;
        var nowCashs = [Double?](repeating: nil, count: numOfFlows)
        
        for _ in 0 ..< MAX_ITERATION {
            npv = 0.0;
            derivative = 0.0;
            for j in 0 ..< numOfFlows {
                nowCash = (cashFlows[j] / pow(1 + guessRate0, Double(j)));
                npv = npv + nowCash;
                derivative += (Double(-j) * cashFlows[j] / pow(1 + guessRate0, Double(j + 1)));
                if nil != presentValues { nowCashs[j] = nowCash }
            }
            guessRate1 = guessRate0 - (npv / derivative);
            if (PRECISION_REQ >= abs(guessRate1 - guessRate0)) {
                presentValues?(nowCashs as! [Double])
                if nil != presentValues { nowCashs.removeAll() }
                return guessRate1;
            }
            guessRate0 = guessRate1;
        }
        if nil != presentValues { nowCashs.removeAll() }
        return nil
    }
    
    static func computeNPV(desc: Double, cashFlows: [Double]) -> Double{
        var npv = 0.0
        for (idx, value) in cashFlows.enumerated(){
            npv += value/pow(1+desc,Double(idx))
        }
        return npv
    }
}
