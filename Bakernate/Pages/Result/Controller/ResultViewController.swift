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
    @IBOutlet weak var editInitialAmountTextField: UITextField!
    @IBOutlet weak var initialUnitPicker: UITextField!
    @IBOutlet weak var showUnitPicker: UITextField!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var resultCardsCollectionView: UICollectionView!
    
    // MARK:- let & var
    var ingredientCollection: [Ingredients] = []
    var ingredientTitle: [Ingredients] = []
    var favorite: Bool = false
    var titleIngredient = ""
    var initialAmount = ""
    var initialUnit = ""
    var showUnit = ""
    var showAmount = 0.0
    var showCardAmount = 0.0
    var selectedDetails = 0
    var selectedIndex = 0
    var unitRow = 0
    var type: [String] = []
    var editUnitPickerView = UIPickerView()
    let showUnitPickerView = UIPickerView()
    var unitArray = ["Cups", "Tablespoon", "Teaspoon", "Ounce", "Gram"]
        
    // MARK:- function
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveData()
        retrieveDataTitle(name: titleIngredient)
        
        if ingredientTitle[selectedIndex].isFavorited! {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        }
        
        picker()
        createToolbar()
        
        editInitialAmountTextField.keyboardType = .decimalPad
        
        editInitialAmountTextField.text = initialAmount
        ingredientNameLabel.text = titleIngredient
        initialUnitPicker.text = ingredientTitle[selectedIndex].initialUnit
        
        if ingredientTitle[selectedIndex].substituteUnit!.count == 0 {
            showUnitPicker.text = ingredientTitle[selectedIndex].initialUnit
        } else {
            showUnitPicker.text = ingredientTitle[selectedIndex].substituteUnit!
            showUnit = ingredientTitle[selectedIndex].substituteUnit!
        }
        
        initialUnit = ingredientTitle[selectedIndex].initialUnit!
        
        convertAmount(initialUnit: initialUnit, showUnit: showUnit)
//
//        navBar.shadowImage = UIImage()
//        navBar.isTranslucent = true
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(handleBackButton))
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        
        resultCardsCollectionView?.dataSource = self
        resultCardsCollectionView?.delegate = self
        resultCardsCollectionView?.showsHorizontalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData()
        retrieveDataTitle(name: titleIngredient)
        
        if ingredientTitle[selectedIndex].isFavorited! {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(handleFavoriteButton))
        }
        
        picker()
        createToolbar()
        
        editInitialAmountTextField.keyboardType = .decimalPad
        
        editInitialAmountTextField.text = initialAmount
        ingredientNameLabel.text = titleIngredient
        initialUnitPicker.text = unitArray[unitRow]
        showUnitPicker.text = unitArray[unitRow]

        initialUnit = unitArray[unitRow]
        showUnit = unitArray[unitRow]
        
        convertAmount(initialUnit: initialUnit, showUnit: showUnit)
        
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
            showAmount = result
        }
    }
    
    func ingredientConversions(initialIngredient: String, showIngredientSubstitution: String) {
        var ingredientName: IngredientName?
        if initialIngredient == "Baking Soda" {
            ingredientName = IngredientName.bakingsoda
        } else if initialIngredient == "Baking Powder" {
            ingredientName = IngredientName.bakingpowder
        } else if initialIngredient == "Buttermilk" {
            ingredientName = IngredientName.buttermilk
        } else if initialIngredient == "Honey" {
            ingredientName = IngredientName.honey
        } else if initialIngredient == "Molasses" {
            ingredientName = IngredientName.molasses
        } else if initialIngredient == "Maple Syrup" {
            ingredientName = IngredientName.maplesyrup
        } else if initialIngredient == "Lemon Juice" {
            ingredientName = IngredientName.lemonjuice
        } else if initialIngredient == "Lime Juice" {
            ingredientName = IngredientName.limejuice
        } else if initialIngredient == "Vinegar" {
            ingredientName = IngredientName.vinegar
        } else if initialIngredient == "White Wine" {
            ingredientName = IngredientName.whitewine
        } else if initialIngredient == "Sour Cream" {
            ingredientName = IngredientName.sourcream
        } else if initialIngredient == "Mayonnaise" {
            ingredientName = IngredientName.mayonnaise
        } else if initialIngredient == "Coconut Milk" {
            ingredientName = IngredientName.coconutmilk
        } else if initialIngredient == "Yogurt" {
            ingredientName = IngredientName.yogurt
        } else if initialIngredient == "Egg" {
            ingredientName = IngredientName.egg
        } else if initialIngredient == "Mashed Banana" {
            ingredientName = IngredientName.mashedbanana
        } else if initialIngredient == "Chia Seed" {
            ingredientName = IngredientName.chiaseed
        } else if initialIngredient == "Agar-agar" {
            ingredientName = IngredientName.agaragar
        } else if initialIngredient == "Unsalted Butter" {
            ingredientName = IngredientName.unsaltedbutter
        } else if initialIngredient == "Vegetable Oil" {
            ingredientName = IngredientName.vegetableoil
        } else if initialIngredient == "Heavy Cream" {
            ingredientName = IngredientName.heavycream
        } else if initialIngredient == "Coconut Cream" {
            ingredientName = IngredientName.coconutcream
        } else if initialIngredient == "Evaporated Milk" {
            ingredientName = IngredientName.evaporatedmilk
        } else if initialIngredient == "Cream Cheese" {
            ingredientName = IngredientName.creamcheese
        } else if initialIngredient == "Mascarpone" {
            ingredientName = IngredientName.mascarpone
        } else if initialIngredient == "Brown Sugar" {
            ingredientName = IngredientName.brownsugar
        } else if initialIngredient == "Coconut Sugar" {
            ingredientName = IngredientName.coconutsugar
        } else if initialIngredient == "White Sugar" {
            ingredientName = IngredientName.whitesugar
        } else if initialIngredient == "Cornstarch" {
            ingredientName = IngredientName.cornstarch
        } else if initialIngredient == "All Purpose Flour" {
            ingredientName = IngredientName.allpurposeflour
        } else if initialIngredient == "Tapioca" {
            ingredientName = IngredientName.tapioca
        }
        
        var ingredientShowName: IngredientName?
        if showIngredientSubstitution == "Baking Soda" {
            ingredientShowName = IngredientName.bakingsoda
        } else if showIngredientSubstitution == "Baking Powder" {
            ingredientShowName = IngredientName.bakingpowder
        } else if showIngredientSubstitution == "Buttermilk" {
            ingredientShowName = IngredientName.buttermilk
        } else if showIngredientSubstitution == "Honey" {
            ingredientShowName = IngredientName.honey
        } else if showIngredientSubstitution == "Molasses" {
            ingredientShowName = IngredientName.molasses
        } else if showIngredientSubstitution == "Maple Syrup" {
            ingredientShowName = IngredientName.maplesyrup
        } else if showIngredientSubstitution == "Lemon Juice" {
            ingredientShowName = IngredientName.lemonjuice
        } else if showIngredientSubstitution == "Lime Juice" {
            ingredientShowName = IngredientName.limejuice
        } else if showIngredientSubstitution == "Vinegar" {
            ingredientShowName = IngredientName.vinegar
        } else if showIngredientSubstitution == "White Wine" {
            ingredientShowName = IngredientName.whitewine
        } else if showIngredientSubstitution == "Sour Cream" {
            ingredientShowName = IngredientName.sourcream
        } else if showIngredientSubstitution == "Mayonnaise" {
            ingredientShowName = IngredientName.mayonnaise
        } else if showIngredientSubstitution == "Coconut Milk" {
            ingredientShowName = IngredientName.coconutmilk
        } else if showIngredientSubstitution == "Yogurt" {
            ingredientShowName = IngredientName.yogurt
        } else if showIngredientSubstitution == "Egg" {
            ingredientShowName = IngredientName.egg
        } else if showIngredientSubstitution == "Mashed Banana" {
            ingredientShowName = IngredientName.mashedbanana
        } else if showIngredientSubstitution == "Chia Seed" {
            ingredientShowName = IngredientName.chiaseed
        } else if showIngredientSubstitution == "Agar-agar" {
            ingredientShowName = IngredientName.agaragar
        } else if showIngredientSubstitution == "Unsalted Butter" {
            ingredientShowName = IngredientName.unsaltedbutter
        } else if showIngredientSubstitution == "Vegetable Oil" {
            ingredientShowName = IngredientName.vegetableoil
        } else if showIngredientSubstitution == "Heavy Cream" {
            ingredientShowName = IngredientName.heavycream
        } else if showIngredientSubstitution == "Coconut Cream" {
            ingredientShowName = IngredientName.coconutcream
        } else if showIngredientSubstitution == "Evaporated Milk" {
            ingredientShowName = IngredientName.evaporatedmilk
        } else if showIngredientSubstitution == "Cream Cheese" {
            ingredientShowName = IngredientName.creamcheese
        } else if showIngredientSubstitution == "Mascarpone" {
            ingredientShowName = IngredientName.mascarpone
        } else if showIngredientSubstitution == "Brown Sugar" {
            ingredientShowName = IngredientName.brownsugar
        } else if showIngredientSubstitution == "Coconut Sugar" {
            ingredientShowName = IngredientName.coconutsugar
        } else if showIngredientSubstitution == "White Sugar" {
            ingredientShowName = IngredientName.whitesugar
        } else if showIngredientSubstitution == "Cornstarch" {
            ingredientShowName = IngredientName.cornstarch
        } else if showIngredientSubstitution == "All Purpose Flour" {
            ingredientShowName = IngredientName.allpurposeflour
        } else if showIngredientSubstitution == "Tapioca" {
            ingredientShowName = IngredientName.tapioca
        }
        
        let amount = IngredientConversions(initialIngredientName: ingredientName!, value: showAmount)
        let result = amount.convert(initialIngredientName: ingredientShowName!)
        showCardAmount = result
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
                for id in ingr.id! {
                    for tipe in type {
                        if id == tipe {
                            if ingr.name == titleIngredient {
                                
                            } else {
                                if ingredientCollection.count == 0 {
                                    ingredientCollection.append(Ingredients(ingredientId: ingr.id , ingredientName: ingr.name , ingredientDesc: ingr.descriptions , ingredientImage: ingr.image , isDairy: ingr.isDairy, isEggs: ingr.isEggs, isGluten: ingr.isGluten, isPeanut: ingr.isPeanut, isSoy: ingr.isSoy, isTreeNuts: ingr.isTreeNuts, isVegan: ingr.isVegan, isFavorited: ingr.isFavorited, ingredientAmount: ingr.amount, initialUnit: ingr.initialUnit, substituteUnit: ingr.substituteUnit))
                                } else {
                                    for ingr2 in ingredientCollection{
                                        if ingr2.ingredientName == ingr.name{
                                            isNameDouble = true
                                            break
                                        } else {
                                            
                                        }
                                    }
                                    if (!isNameDouble){
                                        ingredientCollection.append(Ingredients(ingredientId: ingr.id , ingredientName: ingr.name , ingredientDesc: ingr.descriptions , ingredientImage: ingr.image , isDairy: ingr.isDairy, isEggs: ingr.isEggs, isGluten: ingr.isGluten, isPeanut: ingr.isPeanut, isSoy: ingr.isSoy, isTreeNuts: ingr.isTreeNuts, isVegan: ingr.isVegan, isFavorited: ingr.isFavorited, ingredientAmount: ingr.amount, initialUnit: ingr.initialUnit, substituteUnit: ingr.substituteUnit))
                                    } else {
                                        isNameDouble = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateFavoriteCoreData(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

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
    
    func updateAmountCoreData(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let object = try manageContext.fetch(fetchRequest)
            
            let objectToUpdate = object[0] as! NSManagedObject
            objectToUpdate.setValue(ingredientTitle[0].ingredientAmount, forKey: "amount")
            
            do {
                try manageContext.save()
            } catch {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateInitialUnit(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let object = try manageContext.fetch(fetchRequest)
            
            let objectToUpdate = object[0] as! NSManagedObject
            objectToUpdate.setValue(ingredientTitle[0].initialUnit, forKey: "initialUnit")
            
            do {
                try manageContext.save()
            } catch {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateSubstituteUnit(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Ingredient")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let object = try manageContext.fetch(fetchRequest)
            
            let objectToUpdate = object[0] as! NSManagedObject
            objectToUpdate.setValue(ingredientTitle[0].substituteUnit, forKey: "substituteUnit")
            
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
        let storyboard = UIStoryboard(name: "Favorites", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "favoritesViewController") as! FavoritesViewController
        
        if ingredientTitle[selectedIndex].isFavorited! {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            ingredientTitle[selectedIndex].isFavorited = false
            updateFavoriteCoreData(name: titleIngredient)
            
            ingredientTitle[selectedIndex].substituteUnit = ingredientTitle[selectedIndex].initialUnit!
            updateSubstituteUnit(name: titleIngredient)
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            ingredientTitle[selectedIndex].isFavorited = true
            updateFavoriteCoreData(name: titleIngredient)
            vc.unitRow = self.unitRow
        }
    }
    
    // MARK:- Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCardsCollectionViewCell", for: indexPath) as! ResultCardsCollectionViewCell
        
        let card = ingredientCollection[indexPath.item]
        
        ingredientConversions(initialIngredient: ingredientTitle[selectedIndex].ingredientName!, showIngredientSubstitution: ingredientCollection[indexPath.item].ingredientName!)
        
        cell.set(card: card, amount: String(format: "%.1f", showCardAmount), unit: showUnit)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ResultCardsCollectionViewCell {
            cell.resultCardView.backgroundColor = .systemGray5
            cell.resultCardView.backgroundColor = .white
            selectedDetails = indexPath.item
            navigateToIngredientDetail()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ResultCardsCollectionViewCell
        cell?.resultCardView.backgroundColor = .white
    }
    
    func navigateToIngredientDetail() {
        let ingredientDetails = ingredientCollection[selectedDetails]
        let detailsVC: UIStoryboard = UIStoryboard(name: "IngredientDetails", bundle: nil)
        let details = detailsVC.instantiateViewController(identifier: "ingredientDetails") as? IngredientDetailsViewController
        details?.selectedProductName = ingredientDetails.ingredientName ?? ""
        details?.selectedProductIsVegan = ingredientDetails.isVegan ?? false
        details?.selectedProductIsEgg = ingredientDetails.isEggs ?? false
        details?.selectedProductIsSoy = ingredientDetails.isSoy ?? false
        details?.selectedProductIsTreeNuts = ingredientDetails.isTreeNuts ?? false
        details?.selectedProductIsPeanut = ingredientDetails.isPeanut ?? false
        details?.selectedProductIsGluten = ingredientDetails.isGluten ?? false
        details?.selectedProductIsDairy = ingredientDetails.isDairy ?? false
        details?.selectedProductDescriptions = ingredientDetails.ingredientDesc ?? ""
        details?.selectedProductImages = ingredientDetails.ingredientImage ?? ""
        self.navigationController?.pushViewController(details!, animated: true)
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
        editInitialAmountTextField.inputAccessoryView = toolbar
    }

    @objc func donePressed() {
        ingredientTitle[selectedIndex].initialUnit = initialUnitPicker.text
        updateInitialUnit(name: titleIngredient)
        
        ingredientTitle[selectedIndex].substituteUnit = showUnitPicker.text
        updateSubstituteUnit(name: titleIngredient)
        
        initialAmount = editInitialAmountTextField.text!
        if initialAmount == "" {
            initialAmount = "0"
            editInitialAmountTextField.text = "0"
        }
        ingredientTitle[selectedIndex].ingredientAmount = initialAmount
        updateAmountCoreData(name: titleIngredient)
        
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
            initialUnitPicker.text = unitArray[row]
            initialUnit = unitArray[row]
        }
    }
    
}
