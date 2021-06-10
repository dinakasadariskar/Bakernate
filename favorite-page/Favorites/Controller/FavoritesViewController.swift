//
//  FavoritesViewController.swift
//  Bakernate
//
//  Created by Roshani Ayu Pranasti on 07/06/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var favoriteTableView: UITableView!
    
    //dummy
    var ingredientNames = ["Buttermilk", "Corn Syrup", "Egg", "Honey", "Maple Syrup", "Molasses"]
//    var ingredientNames = [String]()
    var amount = ["100 grams", "1 cup","100 grams", "1 cup","100 grams", "1 cup"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self

        favoriteTableView.separatorStyle = .none
        favoriteTableView.showsVerticalScrollIndicator = false
        
        // Do any additional setup after loading the view.
        
        let nib = UINib.init(nibName: "FavoriteTableViewCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "favoriteCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ingredientNames.isEmpty {
            print("empty")
        }
        
        return ingredientNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell
        cell?.commonInit(ingredientNames[indexPath.row], amount[indexPath.row])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(ingredientNames[indexPath.row])
        
    }
    

}

