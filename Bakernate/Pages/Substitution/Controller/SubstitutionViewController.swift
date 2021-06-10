//
//  SubstitutionViewController.swift
//  Bakernate
//
//  Created by Roshani Ayu Pranasti on 07/06/21.
//

import UIKit

class SubstitutionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    
    let ingredientPickerView = UIPickerView()
    var ingredientArray = ["Buttermilk", "Corn Syrup", "Egg", "Honey", "Maple Syrup", "Molasses"]
    
    let unitPickerView = UIPickerView()
    var unitArray = ["Cup", "Gram", "Kilogram", "Liter", "Mililiter", "Oz", "Tablespoon", "Teaspoon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        amountTextField.keyboardType = .decimalPad
        
        ingredientPicker()
        unitPicker()
        createToolbar()
        createToolbarUnit()
    }
    
    func ingredientPicker() {
        
        ingredientPickerView.delegate = self
        ingredientPickerView.delegate?.pickerView?(ingredientPickerView, didSelectRow: 0, inComponent: 0)
        ingredientTextField.inputView = ingredientPickerView
    }
    
    func unitPicker() {
        
        unitPickerView.delegate = self
        unitPickerView.delegate?.pickerView?(unitPickerView, didSelectRow: 0, inComponent: 0)
        unitTextField.inputView = unitPickerView
    }
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SubstitutionViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        ingredientTextField.inputAccessoryView = toolbar
    }
    
    func createToolbarUnit() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SubstitutionViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        unitTextField.inputAccessoryView = toolbar
    }
    
    @objc func closePickerView() {
        
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == ingredientPickerView {
            return ingredientArray.count
        } else {
            return unitArray.count
        }
            
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == ingredientPickerView {
            return ingredientArray[row]
        } else {
            return unitArray[row]
        }
            
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == ingredientPickerView {
            ingredientTextField.text =  ingredientArray[row]
        } else {
            unitTextField.text =  unitArray[row]
        }
        
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
}
