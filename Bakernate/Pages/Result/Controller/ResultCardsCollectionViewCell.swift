//
//  ResultCardsCollectionViewCell.swift
//  Bakernate
//
//  Created by Dinaka Sadariskar on 11/06/21.
//

import UIKit

class ResultCardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var resultCardView: UIView!
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultNameLabel: UILabel!
    @IBOutlet weak var resultAmountLabel: UILabel!
    
    @IBOutlet weak var isVeganImage: UIImageView!
    @IBOutlet weak var isEggImage: UIImageView!
    @IBOutlet weak var isSoyImage: UIImageView!
    @IBOutlet weak var isTreeNutsImage: UIImageView!
    @IBOutlet weak var isPeanutImage: UIImageView!
    @IBOutlet weak var isGlutenImage: UIImageView!
    @IBOutlet weak var isDairyImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(card: Ingredients, amount: String, unit: String) {
        
        resultImage.image = UIImage(named: card.ingredientImage!)
        resultNameLabel.text = card.ingredientName
        resultAmountLabel.text = "\(amount) \(unit)"
        
        if card.isVegan! {
            isVeganImage.image = UIImage(named: "Enabled Vegan")
        } else {
            isVeganImage.image = UIImage(named: "Disabled Vegan")
        }
        
        if card.isEggs! {
            isEggImage.image = UIImage(named: "Enabled Egg")
        } else {
            isEggImage.image = UIImage(named: "Disabled Egg")
        }
        
        if card.isSoy! {
            isSoyImage.image = UIImage(named: "Enabled Soy")
        } else {
            isSoyImage.image = UIImage(named: "Disabled Soy")
        }
        
        if card.isTreeNuts! {
            isTreeNutsImage.image = UIImage(named: "Enabled Tree Nuts")
        } else {
            isTreeNutsImage.image = UIImage(named: "Disabled Tree Nuts")
        }
        
        if card.isPeanut! {
            isPeanutImage.image = UIImage(named: "Enabled Peanut")
        } else {
            isPeanutImage.image = UIImage(named: "Disabled Peanut")
        }
        
        if card.isGluten! {
            isGlutenImage.image = UIImage(named: "Enabled Gluten")
        } else {
            isGlutenImage.image = UIImage(named: "Disabled Gluten")
        }
        
        if card.isDairy! {
            isDairyImage.image = UIImage(named: "Enabled Dairy")
        } else {
            isDairyImage.image = UIImage(named: "Disabled Dairy")
        }
        
        resultCardView.backgroundColor = .white
        resultCardView.layer.cornerRadius = 20
        
        resultImage.layer.cornerRadius = 20
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
    
    
}






