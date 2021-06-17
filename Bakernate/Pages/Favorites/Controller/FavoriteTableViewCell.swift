//
//  FavoriteTableViewCell.swift
//  Bakernate
//
//  Created by Dinaka Sadariskar on 10/06/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var favoriteCellView: UIView!
    
    var isselected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.favoriteCellView.layer.cornerRadius = 10
        
        self.favoriteCellView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.favoriteCellView.layer.shadowColor = UIColor.black.cgColor
        self.favoriteCellView.layer.shadowOpacity = 0.3
        self.favoriteCellView.layer.shadowRadius = 2
        

    }
    
    func commonInit(line: Ingredients, amount: String, unit: String) {
        ingredientLabel.text = line.ingredientName
        amountLabel.text = "\(amount) \(unit)"
    }
    
    
    
}
