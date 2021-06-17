//
//  ResultControllerViewController.swift
//  Bakernate
//
//  Created by Apriliani Putri Prasetyo on 13/06/21.
//

import UIKit
import CoreData

class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK:- IBOutlet
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var editInitialAmountTextField: UITextField!
    @IBOutlet weak var initialUnitPicker: UITextField!
    @IBOutlet weak var showUnitPicker: UITextField!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    
    @IBOutlet weak var resultCardsCollectionView: UICollectionView!
    
    
    // MARK:- let & var
    var ingredientCollection:[Ingredients] = []
    var ingredientTitle:[Ingredients] = []
    
    var favorite:Bool = false
    var titleIngredient = ""
    var initialAmount = ""
    var initialUnit = ""
    var showUnit = ""
    var showAmount = 0.0
    
    var selectedIndex = 0
    var unitRow = 0
    var type:[String] = []
    
    var editUnitPickerView = UIPickerView()
    let showUnitPickerView = UIPickerView()
    
    var unitArray = ["Cups", "Tablespoon", "Teaspoon", "Ounce", "Gram"]
        
    // MARK:- function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        retrieveData()
        retrieveDataTitle(name: titleIngredient)
        
        print(ingredientTitle)
        
        if ingredientTitle[selectedIndex].isFavorited! {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        }
        
        
        picker()
        createToolbar()
        
        self.hideKeyboardWhenTappedAround()
        editInitialAmountTextField.keyboardType = .decimalPad
        
        editInitialAmountTextField.text = initialAmount
        ingredientNameLabel.text = titleIngredient
        initialUnitPicker.text = unitArray[unitRow]
        showUnitPicker.text = unitArray[unitRow]
        initialUnit = unitArray[unitRow]
        showUnit = unitArray[unitRow]
        convertAmount(initialUnit: initialUnit, showUnit: showUnit)

        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(handleBackButton))
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        
        resultCardsCollectionView?.dataSource = self
        resultCardsCollectionView?.delegate = self
        resultCardsCollectionView?.showsHorizontalScrollIndicator = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveData()
        retrieveDataTitle(name: titleIngredient)
        
        if ingredientTitle[selectedIndex].isFavorited! {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        }
        
        picker()
        createToolbar()
        
        self.hideKeyboardWhenTappedAround()
        editInitialAmountTextField.keyboardType = .decimalPad
        
        editInitialAmountTextField.text = initialAmount
        ingredientNameLabel.text = titleIngredient
        initialUnitPicker.text = unitArray[unitRow]
        showUnitPicker.text = unitArray[unitRow]
        initialUnit = unitArray[unitRow]
        showUnit = unitArray[unitRow]
        convertAmount(initialUnit: initialUnit, showUnit: showUnit)

        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(handleBackButton))
        
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        
        resultCardsCollectionView?.dataSource = self
        resultCardsCollectionView?.delegate = self
        resultCardsCollectionView?.showsHorizontalScrollIndicator = false
        
    }
    
    func convertAmount(initialUnit: String, showUnit: String) {
        var unit: Unit?
        if initialUnit == "Cups" {
            unit = Unit.cups
        } else if initialUnit == "Tablespoon" {
            unit = Unit.tablespoon
        } else if initialUnit == "Teaspoon" {
            unit = Unit.teaspoon
        } else if initialUnit == "Ounce" {
            unit = Unit.ounce
        } else if initialUnit == "Gram" {
            unit = Unit.gram
        }
        
        var show: Unit?
        if showUnit == "Cups" {
            show = Unit.cups
        } else if showUnit == "Tablespoon" {
            show = Unit.tablespoon
        } else if showUnit == "Teaspoon" {
            show = Unit.teaspoon
        } else if showUnit == "Ounce" {
            show = Unit.ounce
        } else if showUnit == "Gram" {
            show = Unit.gram
        }
        
        if let value = Double(initialAmount as String) {
            let amount = Conversions(unit: unit!, value: value)
            let result = amount.convert(unit: show!)
            //            let roundedResult = Double(round(10000 * result) / 10000)
            print("RESULT: \(result)")
            showAmount = result
        }
        
    }
    
    // MARK:- CoreData
    
    func retrieveDataTitle(name: String) {
        ingredientTitle.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        do {
            let result = try manageContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                ingredientTitle.append(Ingredients(ingredientId: data.value(forKey: "id") as? [String] , ingredientName: data.value(forKey: "name") as? String , ingredientDesc: data.value(forKey: "descriptions") as? String , ingredientImage: data.value(forKey: "image") as? String , isDairy: data.value(forKey: "isDairy") as? Bool, isEggs: data.value(forKey: "isEggs") as? Bool, isGluten: data.value(forKey: "isGluten") as? Bool, isPeanut: data.value(forKey: "isPeanut") as? Bool, isSoy: data.value(forKey: "isSoy") as? Bool, isTreeNuts: data.value(forKey: "isTreeNuts") as? Bool, isVegan: data.value(forKey: "isVegan") as? Bool, isFavorited: data.value(forKey: "isFavorited") as? Bool, ingredientAmount: data.value(forKey: "amount") as? String, initialUnit: data.value(forKey: "initialUnit") as? String, substituteUnit: data.value(forKey: "substituteUnit") as? String
                ))
            }
        } catch let error as NSError {
            print("Error due to : \(error.localizedDescription)")
        }
    }
    
    func retrieveData() {
//        ingredientCollection.removeAll()
        
//        let newIngredientCollection = ingredientCollection
        ingredientCollection.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        
        var result: [Ingredient] = []
        
        do {
            result = try manageContext.fetch(Ingredient.fetchRequest())
            var isNameDouble: Bool = false
            for ingr in result {
                print("\(ingr.name) \(ingr.id)")
                for id in ingr.id! {
                    for tipe in type {
                        if id == tipe {
                            if ingr.name == titleIngredient {
                                
                            }else{
                                if ingredientCollection.count == 0 {
                                    ingredientCollection.append(Ingredients(ingredientId: ingr.id , ingredientName: ingr.name , ingredientDesc: ingr.descriptions , ingredientImage: ingr.image , isDairy: ingr.isDairy, isEggs: ingr.isEggs, isGluten: ingr.isGluten, isPeanut: ingr.isPeanut, isSoy: ingr.isSoy, isTreeNuts: ingr.isTreeNuts, isVegan: ingr.isVegan, isFavorited: ingr.isFavorited, ingredientAmount: ingr.amount, initialUnit: ingr.initialUnit, substituteUnit: ingr.substituteUnit))
                                }else{
                                    for ingr2 in ingredientCollection{
                                        if ingr2.ingredientName == ingr.name{
                                            isNameDouble = true
                                            break
                                        }else{
                                            
                                        }
                                    }
                                    if (!isNameDouble){
                                        ingredientCollection.append(Ingredients(ingredientId: ingr.id , ingredientName: ingr.name , ingredientDesc: ingr.descriptions , ingredientImage: ingr.image , isDairy: ingr.isDairy, isEggs: ingr.isEggs, isGluten: ingr.isGluten, isPeanut: ingr.isPeanut, isSoy: ingr.isSoy, isTreeNuts: ingr.isTreeNuts, isVegan: ingr.isVegan, isFavorited: ingr.isFavorited, ingredientAmount: ingr.amount, initialUnit: ingr.initialUnit, substituteUnit: ingr.substituteUnit))
                                    }else{
                                        isNameDouble = false //udah nih
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            
        }
        
    }
    
    func updateFavoriteCoreData(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

        // 3. Prepare fetch dari entity coredata nya
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let object = try manageContext.fetch(fetchRequest)
            
            let objectToUpdate = object[0] as! NSManagedObject
            objectToUpdate.setValue(ingredientTitle[0].isFavorited, forKey: "isFavorited")
            
            do {
                try manageContext.save()
            } catch {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    // MARK:- objc
    
    @objc func handleBackButton(_ sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @objc func handleFavoriteButton(_ sender: UIBarButtonItem) {
        
//        updateFavoriteCoreData(name: titleIngredient)
        
//        print(ingredientCollection)
        
        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "favoritesViewController") as! FavoritesViewController
        
        
        if ingredientTitle[selectedIndex].isFavorited! {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            ingredientTitle[selectedIndex].isFavorited = false
            updateFavoriteCoreData(name: titleIngredient)
            
//            vc.unitRow = self.unitRow
//            vc.initialUnit = self.initialUnit
//            vc.showAmount = self.showAmount
//            vc.showUnit = self.showUnit
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            ingredientTitle[selectedIndex].isFavorited = true
            updateFavoriteCoreData(name: titleIngredient)
//            print(ingredientTitle[selectedIndex])
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
        
        cell.set(card: card, amount: String(format: "%.1f", showAmount), unit: showUnit)
        
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
        showUnitPickerView.backgroundColor = BakernateColor.backgroundGreen
        showUnitPickerView.selectRow(unitRow, inComponent: 0, animated: true)

        showUnitPicker.inputView = showUnitPickerView
            
        editUnitPickerView.delegate = self
        editUnitPickerView.delegate?.pickerView?(editUnitPickerView, didSelectRow: 0, inComponent: 0)
        editUnitPickerView.backgroundColor = BakernateColor.backgroundGreen
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
        toolbar.backgroundColor = BakernateColor.green10

        initialUnitPicker.inputAccessoryView = toolbar
        showUnitPicker.inputAccessoryView = toolbar
    }

    @objc func donePressed() {
        
//        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "favoritesViewController") as! FavoritesViewController
        
        convertAmount(initialUnit: initialUnit, showUnit: showUnit)
        resultCardsCollectionView.reloadData()
        
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
            showUnit = unitArray[row]
        } else {
            initialUnitPicker.text =  unitArray[row]
            initialUnit = unitArray[row]
        }
        
        
        //        showUnitPicker.text = unitArray[row]
        //        initialUnitPicker.text =  unitArray[row]
        
    }
    
}
