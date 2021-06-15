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

class ResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK:- IBOutlet
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var editInitialAmountTextField: UITextField!
    @IBOutlet weak var initialUnitPicker: UITextField!
    @IBOutlet weak var showUnitPicker: UITextField!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    
    @IBOutlet weak var resultCardsCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    
    // MARK:- let & var
    
    var cards:[resultIngredient] = []
    var favorite:Bool = false
    var titleIngredient = ""
    var initialAmount = ""
        
    // MARK:- function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        editInitialAmountTextField.keyboardType = .decimalPad
        editInitialAmountTextField.text = initialAmount
        ingredientNameLabel.text = titleIngredient

        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        cards = [
            resultIngredient(resultName: "Buttermilk", resultAmount: "100 grams", resultImage: nil), resultIngredient(resultName: "Egg", resultAmount: "100 grams", resultImage: nil), resultIngredient(resultName: "Honey", resultAmount: "100 grams", resultImage: nil)
        ]
        
        resultCardsCollectionView?.dataSource = self
        resultCardsCollectionView?.delegate = self
        resultCardsCollectionView?.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        if favorite {
            favoriteButton.image = UIImage(systemName: "heart")
            favorite = false
            print(favorite)
        } else {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            favorite = true
            print(favorite)
        }
    }
    
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
            let storyboard = UIStoryboard(name: "IngredientDetails", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "ingredientDetails") as! IngredientDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        print(cards[indexPath.item])
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? ResultCardsCollectionViewCell {
//            cell.resultCardView.backgroundColor = .white
//        }
//    }
    
}
