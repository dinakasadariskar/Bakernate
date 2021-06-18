//
//  IngredientConversions.swift
//  Bakernate
//
//  Created by Apriliani Putri Prasetyo on 16/06/21.
//

import Foundation

enum IngredientName {
    case bakingsoda
    case bakingpowder
    case buttermilk
    case honey
    case molasses
    case maplesyrup
    case lemonjuice
    case limejuice
    case vinegar
    case whitewine
    case sourcream
    case mayonnaise
    case coconutmilk
    case yogurt
    case egg
    case mashedbanana
    case chiaseed
    case agaragar
    case unsaltedbutter
    case vegetableoil
    case heavycream
    case coconutcream
    case evaporatedmilk
    case creamcheese
    case mascarpone
    case brownsugar
    case coconutsugar
    case whitesugar
    case cornstarch
    case allpurposeflour
    case tapioca
    
    static let getAllUnits = [bakingsoda, bakingpowder, buttermilk, honey, molasses, maplesyrup, lemonjuice, limejuice, vinegar, whitewine, sourcream, mayonnaise, coconutmilk, yogurt, egg, mashedbanana, chiaseed, agaragar, unsaltedbutter, vegetableoil, heavycream, coconutcream, evaporatedmilk, creamcheese, mascarpone, brownsugar, coconutsugar, whitesugar, cornstarch, allpurposeflour, tapioca]
}

struct IngredientConversions {
    let value: Double
    let initialIngredientName: IngredientName
    
    init(initialIngredientName: IngredientName, value: Double) {
        self.value = value
        self.initialIngredientName = initialIngredientName
    }
    
    func convert(initialIngredientName to: IngredientName) -> Double {
        var output = 0.0
        
        switch initialIngredientName {
        case .bakingsoda:
            if to == .bakingpowder {
                output = value * 4
            }
        case .bakingpowder:
            if to == .bakingsoda {
                output = value * 0.25
            }
        case .buttermilk:
            if to == .yogurt || to == .sourcream || to == .coconutmilk {
                output = value * 1
            } else {
                output = value * 1
            }
        case .honey:
            if to == .molasses || to == .maplesyrup {
                output = value * 1
            } else {
                output = value * 1.7044
            }
        case .molasses:
            if to == .honey || to == .maplesyrup {
                output = value * 1
            } else {
                output = value * 1.7044
            }
        case .maplesyrup:
            if to == .honey || to == .molasses {
                output = value * 1
            } else {
                output = value * 1.7044
            }
        case .lemonjuice:
            if to == .limejuice {
                output = value * 1
            } else if to == .vinegar || to == .whitewine {
                output = value * 2
            }
        case .limejuice:
            if to == .limejuice || to == .vinegar || to == .whitewine {
                output = value * 1
            }
        case .vinegar:
            if to == .limejuice || to == .lemonjuice {
                output = value * 1
            } else if to == .whitewine {
                output = value * 2
            }
        case .whitewine:
            if to == .limejuice || to == .lemonjuice {
                output = value * 0.25
            } else if to == .vinegar {
                output = value * 0.5
            }
        case .sourcream:
            if to == .yogurt || to == .mayonnaise || to == .coconutmilk {
                output = value * 1
            } else {
                output = value * 1
            }
        case .mayonnaise:
            if to == .yogurt || to == .sourcream || to == .coconutmilk {
                output = value * 1
            } else {
                output = value * 1
            }
        case .coconutmilk:
            if to == .yogurt || to == .sourcream || to == .mayonnaise {
                output = value * 1
            } else {
                output = value * 1
            }
        case .yogurt:
            if to == .coconutmilk || to == .sourcream || to == .mayonnaise {
                output = value * 1
            } else {
                output = value * 1
            }
        case .egg:
            if to == .mashedbanana {
                output = value * 1
            } else if to == .chiaseed {
                output = value * 0.1111
            } else if to == .agaragar {
                output = value * 0.1429
            }
        case .mashedbanana:
            if to == .egg {
                output = value * 1
            } else if to == .chiaseed {
                output = value * 0.1111
            } else if to == .agaragar {
                output = value * 0.1429
            }
        case .chiaseed:
            if to == .egg {
                output = value * 10
            } else if to == .mashedbanana {
                output = value * 10
            } else if to == .agaragar {
                output = value * 1.4286
            }
        case .agaragar:
            if to == .egg {
                output = value * 7
            } else if to == .mashedbanana {
                output = value * 7
            } else if to == .chiaseed {
                output = value * 0.7778
            }
        case .unsaltedbutter:
            if to == .vegetableoil {
                output = value * 0.875
            }
        case .vegetableoil:
            if to == .unsaltedbutter {
                output = value * 1.1429
            }
        case .heavycream:
            if to == .coconutcream || to == .yogurt || to == .sourcream || to == .creamcheese || to == .mascarpone {
                output = value * 1
            }
        case .coconutcream:
            if to == .heavycream || to == .evaporatedmilk || to == .creamcheese || to == .mascarpone {
                output = value * 1
            }
        case .evaporatedmilk:
            if to == .heavycream || to == .coconutcream || to == .creamcheese || to == .mascarpone {
                output = value * 1
            }
        case .creamcheese:
            if to == .heavycream || to == .coconutcream || to == .evaporatedmilk || to == .mascarpone {
                output = value * 1
            }
        case .mascarpone:
            if to == .heavycream || to == .coconutcream || to == .evaporatedmilk || to == .creamcheese {
                output = value * 1
            }
        case .brownsugar:
            if to == .coconutsugar || to == .whitesugar {
                output = value * 1
            } else if to == .honey || to == .maplesyrup || to == .molasses{
                output = value * 0.5867
            }
        case .coconutsugar:
            if to == .brownsugar || to == .whitesugar {
                output = value * 1
            } else if to == .honey || to == .maplesyrup || to == .molasses{
                output = value * 0.5867
            }
        case .whitesugar:
            if to == .brownsugar || to == .coconutsugar {
                output = value * 1
            } else if to == .honey || to == .maplesyrup || to == .molasses{
                output = value * 0.5867
            }
        case .cornstarch:
            if to == .allpurposeflour || to == .tapioca {
                output = value * 2
            }
        case .allpurposeflour:
            if to == .cornstarch {
                output = value * 0.5
            } else if to == .tapioca {
                output = value * 1
            }
        case .tapioca:
            if to == .cornstarch {
                output = value * 0.5
            } else if to == .allpurposeflour {
                output = value * 1
            }
        }
        
        return output
    }
}
