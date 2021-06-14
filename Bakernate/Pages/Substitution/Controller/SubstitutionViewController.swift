//
//  SubstitutionViewController.swift
//  Bakernate
//
//  Created by Roshani Ayu Pranasti on 07/06/21.
//

import UIKit
import CoreData


protocol SubstitutionViewControllerDelegate: class { // this blueprint needed as our bridge between this view controller to other view controller who subscribed it
    func substituteIngredientData(amount: String, ingredientName: String)
}

class SubstitutionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK:- IBOutlet
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var substituteButton: UIButton!
    
    // MARK:- let & var
    weak var delegate: SubstitutionViewControllerDelegate?
    var amount = ""
    var substituteIngredientName = ""
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let ingredientPickerView = UIPickerView()
    let unitPickerView = UIPickerView()
    var ingredientArr = [Any]()
    var ingredientCollection = [Ingredients]()
    var ingredientNameArray = ["Salted Butter", "Cake Flour", "Cornstarch", "Buttermilk", "Baking Soda", "Honey", "Baking Powder", "Lemon Juice", "Sour Cream", "Egg", "Unsalted Butter", "Heavy Cream", "Brown Sugar"]
    var ingredientDescArray = ["Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test"]
    var ingredientImageArray = ["Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test"]
    var unitArray = ["Cup", "Gram", "Kilogram", "Liter", "Mililiter", "Oz", "Tablespoon", "Teaspoon"]
    
    // MARK:- Function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        amountTextField.keyboardType = .decimalPad
        setupInitialDataToCoreData()
        picker()
        createToolbar()
        checkAmout()
    }
    
    func setupInitialDataToCoreData() {
        
        retrieveData()
        
        if ingredientCollection.count == 0 {
            
            createData()
        }
        
        ingredientName()
    }
    
    func checkAmout() {
        
        substituteButton.layer.cornerRadius = 10
        substituteButton.backgroundColor = #colorLiteral(red: 0.6, green: 0.6784313725, blue: 0.6745098039, alpha: 1)
        substituteButton.tintColor = #colorLiteral(red: 0.4156862745, green: 0.4549019608, blue: 0.4705882353, alpha: 1)
        substituteButton.isEnabled = false
        [amountTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        
        guard let amount = amountTextField.text, !amount.isEmpty
        
        else {
            
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
            
            return ingredientArr.count
        } else {
            return unitArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == ingredientPickerView {
            
            return ("\(ingredientArr[row])")
        } else {
            
            return unitArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == ingredientPickerView {
            
            substituteIngredientName = ("\(ingredientArr[row])")
            ingredientTextField.text = substituteIngredientName
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
    
    // MARK:- CoreData
    func createData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        guard let ingredientEntity = NSEntityDescription.entity(forEntityName: "Ingredient", in: manageContext) else { return }
        for i in 1...ingredientNameArray.count {
            
            let ingredient = NSManagedObject(entity: ingredientEntity, insertInto: manageContext)
            ingredient.setValue(ingredientNameArray[i-1], forKey: "name")
            ingredient.setValue(ingredientDescArray[i-1], forKey: "descriptions")
            ingredient.setValue(ingredientImageArray[i-1], forKey: "image")
        }
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
                
                ingredientCollection.append(Ingredients(ingredientName: data.value(forKey: "name") as! String, ingredientDesc: data.value(forKey: "descriptions") as! String, ingredientImage: data.value(forKey: "image") as! String
                                                        //                    , isDairy: data.value(forKey: "isDairy") as! Bool, isEgg: data.value(forKey: "isEgg") as! Bool, isGluten: data.value(forKey: "isGluten") as! Bool, isPeanut: data.value(forKey: "isPeanut") as! Bool, isSoy: data.value(forKey: "isSoy") as! Bool, isTreeNuts: data.value(forKey: "isTreeNuts") as! Bool, isVegan: data.value(forKey: "isVegan") as! Bool, isFavorited: data.value(forKey: "isFavorited") as! Bool
                ))
            }
        } catch let error as NSError {
            
            print("Error due to : \(error.localizedDescription)")
        }
    }
    
    func ingredientName() {
        
        for ingredient in ingredientCollection {
            
            ingredientArr.append(ingredient.ingredientName)
        }
    }
    
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    // MARK:- IBAction
    @IBAction func clickInfoButton(_ sender: Any) {
        
        showInformation()
    }
    
    @IBAction func clickSubstituteButton(_ sender: UIButton) {
        
        activityIndicator("Substituting...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.effectView.removeFromSuperview()
            let storyboard = UIStoryboard(name: "Result", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "resultViewController") as! ResultViewController
            vc.initialAmount = self.amountTextField.text!
            vc.titleIngredient = self.substituteIngredientName
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

// MARK:- Extension
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
