//
//  ResultControllerViewController.swift
//  Bakernate
//
//  Created by Apriliani Putri Prasetyo on 13/06/21.
//

import UIKit

struct resultIngredient {
    var resultName:String
    var resultAmount:String
    var resultImage:UIImage?
}

class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK:- IBOutlet
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var editInitialAmountTextField: UITextField!
    @IBOutlet weak var initialUnitPicker: UITextField!
    @IBOutlet weak var showUnitPicker: UITextField!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    
    @IBOutlet weak var resultCardsCollectionView: UICollectionView!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    
    // MARK:- let & var
    
    let editUnitPickerView = UIPickerView()
    let showUnitPickerView = UIPickerView()
    
    var unitArray = ["Cup", "Gram", "Kilogram", "Liter", "Mililiter", "Oz", "Tablespoon", "Teaspoon"]
    
    var cards:[resultIngredient] = []
    var favorite:Bool = false
    var titleIngredient = ""
    var initialAmount = ""
        
    // MARK:- function
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        picker()
        createToolbar()
        
        self.hideKeyboardWhenTappedAround()
        editInitialAmountTextField.keyboardType = .decimalPad
        editInitialAmountTextField.text = initialAmount
        ingredientNameLabel.text = titleIngredient

        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(handleBackButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        
        cards = [
            resultIngredient(resultName: "Maple Syrup", resultAmount: "100 grams", resultImage: UIImage(named: "maple_syrup_1")), resultIngredient(resultName: "Egg", resultAmount: "100 grams", resultImage: nil), resultIngredient(resultName: "Honey", resultAmount: "100 grams", resultImage: nil)
        ]
        
        resultCardsCollectionView?.dataSource = self
        resultCardsCollectionView?.delegate = self
        resultCardsCollectionView?.showsHorizontalScrollIndicator = false
        
    }
    
    @objc func handleBackButton()
    {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func handleFavoriteButton()
    {
        if favorite {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            favorite = false
            print(favorite)
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            favorite = true
            print(favorite)
        }
    }
    
//    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
//
//        if favorite {
//            favoriteButton.image = UIImage(systemName: "heart")
//            favorite = false
//            print(favorite)
//        } else {
//            favoriteButton.image = UIImage(systemName: "heart.fill")
//            favorite = true
//            print(favorite)
//        }
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCardsCollectionViewCell", for: indexPath) as! ResultCardsCollectionViewCell
        let card = cards[indexPath.item]
        
        print(card)
        
        cell.set(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ResultCardsCollectionViewCell {
            cell.resultCardView.backgroundColor = .systemGray5
        }
        print(cards[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ResultCardsCollectionViewCell {
            cell.resultCardView.backgroundColor = .white
        }
    }
    
    
    func picker() {
        
        showUnitPickerView.delegate = self
        showUnitPickerView.delegate?.pickerView?(showUnitPickerView, didSelectRow: 0, inComponent: 0)
        showUnitPickerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        showUnitPicker.inputView = showUnitPickerView
        
        editUnitPickerView.delegate = self
        editUnitPickerView.delegate?.pickerView?(editUnitPickerView, didSelectRow: 0, inComponent: 0)
        editUnitPickerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        initialUnitPicker.inputView = editUnitPickerView
        
    }
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
        
        initialUnitPicker.inputAccessoryView = toolbar
        showUnitPicker.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        
        view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return unitArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return unitArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == showUnitPickerView {
            showUnitPicker.text = unitArray[row]
        } else {
            initialUnitPicker.text =  unitArray[row]
        }
        
        
//        showUnitPicker.text = unitArray[row]
//        initialUnitPicker.text =  unitArray[row]
        
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
