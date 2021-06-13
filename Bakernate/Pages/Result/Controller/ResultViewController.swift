//
//  ResultControllerViewController.swift
//  Bakernate
//
//  Created by Apriliani Putri Prasetyo on 13/06/21.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var editInitialAmountTextField: UITextField!
    @IBOutlet weak var initialUnitPicker: UITextField!
    @IBOutlet weak var showUnitPicker: UITextField!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    
    // MARK:- let & var
        
    // MARK:- function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        editInitialAmountTextField.keyboardType = .decimalPad

        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}

extension ResultViewController: SubstitutionViewControllerDelegate {
    // Once we subscribe the delegate, we need to conform the protocol to sync the the data through the function provided
    func substituteIngredientData(amount: String, ingredientName: String) {
        
        self.editInitialAmountTextField.text = amount
        self.ingredientNameLabel.text = ingredientName
//        self.setAmount = amount
//        self.setIngredientName = ingredientName
    }
}
