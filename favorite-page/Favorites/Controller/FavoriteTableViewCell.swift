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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.favoriteCellView.layer.cornerRadius = 10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            favoriteCellView.backgroundColor = .green
        } else {
            favoriteCellView.backgroundColor = .white
        }
        // Configure the view for the selected state
    }
    
    func commonInit(_ ingredientName:String, _ amount:String) {
        ingredientLabel.text = ingredientName
        amountLabel.text = amount
    }
    
    
    
}
