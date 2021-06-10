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
    
    let ingredientPickerView = UIPickerView()
    var ingredientArray = ["Buttermilk", "Corn Syrup", "Egg", "Honey", "Maple Syrup", "Molasses"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        amountTextField.keyboardType = .decimalPad
        ingredientPicker()
        createToolbar()
    }
    
    func ingredientPicker()
    {
        
        ingredientPickerView.delegate = self
        ingredientPickerView.delegate?.pickerView?(ingredientPickerView, didSelectRow: 0, inComponent: 0)
        ingredientTextField.inputView = ingredientPickerView
    }
    
    func createToolbar()
    {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SubstitutionViewController.closePickerView))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        ingredientTextField.inputAccessoryView = toolbar
    }
    
    @objc func closePickerView()
    {
        
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
            return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return ingredientArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
            return ingredientArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        ingredientTextField.text =  ingredientArray[row]
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

