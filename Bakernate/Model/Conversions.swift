//
//  Conversions.swift
//  Bakernate
//
//  Created by Apriliani Putri Prasetyo on 16/06/21.
//

import Foundation

enum Unit {
    case cups
    case tablespoon
    case teaspoon
    case ounce
    case gram
    
    static let getAllUnits = [cups, tablespoon, teaspoon, ounce, gram]
}

struct Conversions {
    let value: Double
    let unit: Unit
    
    init(unit: Unit, value: Double) {
        self.value = value
        self.unit = unit
    }
    
    func convert(unit to: Unit) -> Double {
        var output = 0.0
        
        switch unit {
        case .cups:
            if to == .tablespoon {
                output = value * 16
            } else if to == .teaspoon {
                output = value * 48
            } else if to == .ounce {
                output = value * 8
            } else if to == .gram {
                output = value * 225
            } else if to == .cups {
                output = value * 1
            }
        case .tablespoon:
            if to == .cups {
                output = value * 0.0625
            } else if to == .teaspoon {
                output = value * 3
            } else if to == .ounce {
                output = value * 0.5
            } else if to == .gram {
                output = value * 0.8789
            } else if to == .tablespoon {
                output = value * 1
            }
        case .teaspoon:
            if to == .cups {
                output = value * 0.0208
            } else if to == .tablespoon {
                output = value * 0.3333
            } else if to == .ounce {
                output = value * 0.1667
            } else if to == .gram {
                output = value * 0.2133
            } else if to == .teaspoon {
                output = value * 1
            }
        case .ounce:
            if to == .cups {
                output = value * 0.0044
            } else if to == .tablespoon {
                output = value * 2
            } else if to == .teaspoon {
                output = value * 6
            } else if to == .gram {
                output = value * 28
            } else if to == .ounce {
                output = value * 1
            }
        case .gram:
            if to == .cups {
                output = value * 0.0044
            } else if to == .tablespoon {
                output = value * 0.0714
            } else if to == .teaspoon {
                output = value * 0.2143
            } else if to == .ounce {
                output = value * 0.0357
            } else if to == .gram {
                output = value * 1
            }
        }
        
        return output
    }
}
