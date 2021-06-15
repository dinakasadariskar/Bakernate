//
//  ResultControllerViewController.swift
//  Bakernate
//
//  Created by Apriliani Putri Prasetyo on 13/06/21.
//

import UIKit
import CoreData

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
    
    var ingredientCollection:[Ingredients] = []
    var favorite:Bool = false
    var titleIngredient = ""
    var initialAmount = ""
    var initialUnit = ""
    
    var unitRow = 0
    
    var editUnitPickerView = UIPickerView()
    let showUnitPickerView = UIPickerView()
    
    var unitArray = ["Cup", "Gram", "Kilogram", "Liter", "Mililiter", "Oz", "Tablespoon", "Teaspoon"]
        
    // MARK:- function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        retrieveData()
        
        
        picker()
        createToolbar()
        
        self.hideKeyboardWhenTappedAround()
        editInitialAmountTextField.keyboardType = .decimalPad
        
        editInitialAmountTextField.text = initialAmount
        ingredientNameLabel.text = titleIngredient
        initialUnitPicker.text = initialUnit
        showUnitPicker.text = initialUnit

        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(handleBackButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        
        
//        cards = [
//            resultIngredient(resultName: "Maple Syrup", resultAmount: "100 grams", resultImage: UIImage(named: "maple_syrup_1")), resultIngredient(resultName: "Egg", resultAmount: "100 grams", resultImage: nil), resultIngredient(resultName: "Honey", resultAmount: "100 grams", resultImage: nil)
//        ]
        
        resultCardsCollectionView?.dataSource = self
        resultCardsCollectionView?.delegate = self
        resultCardsCollectionView?.showsHorizontalScrollIndicator = false
        
    }
    
    func retrieveData() {
        ingredientCollection.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        do {
            let result = try manageContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                ingredientCollection.append(Ingredients(ingredientId: data.value(forKey: "id") as? String , ingredientName: data.value(forKey: "name") as? String , ingredientDesc: data.value(forKey: "descriptions") as? String , ingredientImage: data.value(forKey: "image") as? String , isDairy: data.value(forKey: "isDairy") as? Bool, isEggs: data.value(forKey: "isEggs") as? Bool, isGluten: data.value(forKey: "isGluten") as? Bool, isPeanut: data.value(forKey: "isPeanut") as? Bool, isSoy: data.value(forKey: "isSoy") as? Bool, isTreeNuts: data.value(forKey: "isTreeNuts") as? Bool, isVegan: data.value(forKey: "isVegan") as? Bool, isFavorited: data.value(forKey: "isFavorited") as? Bool, ingredientAmount: data.value(forKey: "amount") as? String, initialUnit: data.value(forKey: "initialUnit") as? String, substituteUnit: data.value(forKey: "substituteUnit") as? String
                ))
            }
        } catch let error as NSError {
            print("Error due to : \(error.localizedDescription)")
        }
    }
    
    // MARK:- objc
    
    @objc func handleBackButton(_ sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleFavoriteButton(_ sender: UIBarButtonItem) {
        
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
    
    // MARK:- Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(ingredientCollection.count)
        
        return ingredientCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCardsCollectionViewCell", for: indexPath) as! ResultCardsCollectionViewCell
        
        let card = ingredientCollection[indexPath.item]
        
        cell.set(card: card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ResultCardsCollectionViewCell {
            cell.resultCardView.backgroundColor = .systemGray5
            let storyboard = UIStoryboard(name: "IngredientDetails", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "ingredientDetails") as! IngredientDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
            cell.resultCardView.backgroundColor = .white
        }
        
        print(ingredientCollection[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ResultCardsCollectionViewCell
        cell?.resultCardView.backgroundColor = .white
    }
    
    // MARK:- Picker
    
    func picker() {

        showUnitPickerView.delegate = self
        showUnitPickerView.delegate?.pickerView?(showUnitPickerView, didSelectRow: 0, inComponent: 0)
        showUnitPickerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        showUnitPickerView.selectRow(unitRow, inComponent: 0, animated: true)

        showUnitPicker.inputView = showUnitPickerView
            
        editUnitPickerView.delegate = self
        editUnitPickerView.delegate?.pickerView?(editUnitPickerView, didSelectRow: 0, inComponent: 0)
        editUnitPickerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        editUnitPickerView.selectRow(unitRow, inComponent: 0, animated: true)
        
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
