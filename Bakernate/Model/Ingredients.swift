//
//  Ingredients.swift
//  Bakernate
//
//  Created by Apriliani Putri Prasetyo on 13/06/21.
//

import Foundation

struct Ingredients {
    let ingredientId: [String]?
    let ingredientName: String?
    let ingredientDesc: String?
    let ingredientImage: String?
    let isDairy: Bool?
    let isEggs: Bool?
    let isGluten: Bool?
    let isPeanut: Bool?
    let isSoy: Bool?
    let isTreeNuts: Bool?
    let isVegan: Bool?
    var isFavorited: Bool?
    var ingredientAmount: String?
    var initialUnit: String?
    var substituteUnit: String?
}
