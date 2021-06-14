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
    
    
    func set(_ card: resultIngredient) {
        
        resultImage.image = card.resultImage
        resultNameLabel.text = card.resultName
        resultAmountLabel.text = card.resultAmount
        
        
        resultCardView.backgroundColor = .white
        resultCardView.layer.cornerRadius = 20
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
    
    
}






