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
    @IBOutlet weak var substituteButton: UIButton!
    
    let ingredientPickerView = UIPickerView()
    var ingredientArray = ["Buttermilk", "Corn Syrup", "Egg", "Honey", "Maple Syrup", "Molasses"]
    
    let unitPickerView = UIPickerView()
    var unitArray = ["Cup", "Gram", "Kilogram", "Liter", "Mililiter", "Oz", "Tablespoon", "Teaspoon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        amountTextField.keyboardType = .decimalPad
        
        picker()
        createToolbar()
        checkAmout()
    }
    
    func checkAmout() {
        substituteButton.layer.cornerRadius = 10
        substituteButton.backgroundColor = #colorLiteral(red: 0.6, green: 0.6784313725, blue: 0.6745098039, alpha: 1)
        substituteButton.tintColor = #colorLiteral(red: 0.4156862745, green: 0.4549019608, blue: 0.4705882353, alpha: 1)
        substituteButton.isEnabled = false
        [amountTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard let amount = amountTextField.text, !amount.isEmpty else {
            substituteButton.backgroundColor = #colorLiteral(red: 0.6, green: 0.6784313725, blue: 0.6745098039, alpha: 1)
            substituteButton.isEnabled = false
            return
        }
        
        substituteButton.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.3568627451, blue: 0.3529411765, alpha: 1)
        substituteButton.tintColor = .white
        substituteButton.isEnabled = true
    }
    
    func picker() {
        ingredientPickerView.delegate = self
        ingredientPickerView.delegate?.pickerView?(ingredientPickerView, didSelectRow: 0, inComponent: 0)
        ingredientPickerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        ingredientTextField.inputView = ingredientPickerView
        
        unitPickerView.delegate = self
        unitPickerView.delegate?.pickerView?(unitPickerView, didSelectRow: 0, inComponent: 0)
        unitPickerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        unitTextField.inputView = unitPickerView
    }
    
    func createToolbar() {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        
        ingredientTextField.inputAccessoryView = toolbar
        unitTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
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

    @objc func showInformation() {
        let slideVC = InformationView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @IBAction func clickInfoButton(_ sender: Any) {
        showInformation()
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

extension SubstitutionViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
