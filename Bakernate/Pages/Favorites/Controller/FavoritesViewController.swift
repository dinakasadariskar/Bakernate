//
//  FavoritesViewController.swift
//  Bakernate
//
//  Created by Roshani Ayu Pranasti on 07/06/21.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // MARK:- IBOutlets
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet var emptyView: UIView!

    
    // MARK:- let & var
    var ingredientCollection:[Ingredients] = []
    
    var initialUnit = ""
    var unitRow = 0
    var showUnit = ""
    var showAmount = 0.0
    
    var unitArray = ["Cups", "Tablespoon", "Teaspoon", "Ounce", "Gram"]
    
    // MARK:- functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData()
        
        if ingredientCollection.count == 0 {
            favoriteTableView.backgroundView = emptyView
        } else {
            favoriteTableView.backgroundView = nil
        }
        
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self

        favoriteTableView.separatorStyle = .none
        favoriteTableView.showsVerticalScrollIndicator = false
        
        // Do any additional setup after loading the view.
        
        let nib = UINib.init(nibName: "FavoriteTableViewCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "favoriteCell")
        
        favoriteTableView.reloadData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if ingredientCollection.count == 0 {
            favoriteTableView.backgroundView = emptyView
        } else {
            favoriteTableView.backgroundView = nil
        }
        
        retrieveData()
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self

        favoriteTableView.separatorStyle = .none
        favoriteTableView.showsVerticalScrollIndicator = false
        
        // Do any additional setup after loading the view.
        
        let nib = UINib.init(nibName: "FavoriteTableViewCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "favoriteCell")
        
        favoriteTableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ingredientCollection.count == 0 {
            favoriteTableView.backgroundView = emptyView
        } else {
            favoriteTableView.backgroundView = nil
        }
        
        return ingredientCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell
        
        var line = ingredientCollection[indexPath.row]
        
        cell?.commonInit(line: line, amount: line.ingredientAmount!, unit: line.initialUnit!)
        
        cell?.selectionStyle = .none
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FavoriteTableViewCell {

            let storyboard = UIStoryboard(name: "Result", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "resultViewController") as! ResultViewController
            
            vc.initialAmount = ingredientCollection[indexPath.row].ingredientAmount!
            vc.titleIngredient = ingredientCollection[indexPath.row].ingredientName!
            
//            print("INITIAL UNIT: \(ingredientCollection[indexPath.row].initialUnit!)")
//            print("SUBSTITUTE UNIT: \(ingredientCollection[indexPath.row].substituteUnit!)")
            
            vc.initialUnit = ingredientCollection[indexPath.row].initialUnit!
            vc.showUnit = unitArray[unitRow]
            vc.unitRow = self.unitRow
            vc.type = ingredientCollection[indexPath.row].ingredientId!
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        print(ingredientCollection[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FavoriteTableViewCell {
            cell.favoriteCellView.backgroundColor = .white
        }
    }
    
    
    // MARK:- core data
    func retrieveData() {
        ingredientCollection.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredient")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "isFavorited = true")
        do {
            let result = try manageContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                ingredientCollection.append(Ingredients(ingredientId: data.value(forKey: "id") as? [String] , ingredientName: data.value(forKey: "name") as? String , ingredientDesc: data.value(forKey: "descriptions") as? String , ingredientImage: data.value(forKey: "image") as? String , isDairy: data.value(forKey: "isDairy") as? Bool, isEggs: data.value(forKey: "isEggs") as? Bool, isGluten: data.value(forKey: "isGluten") as? Bool, isPeanut: data.value(forKey: "isPeanut") as? Bool, isSoy: data.value(forKey: "isSoy") as? Bool, isTreeNuts: data.value(forKey: "isTreeNuts") as? Bool, isVegan: data.value(forKey: "isVegan") as? Bool, isFavorited: data.value(forKey: "isFavorited") as? Bool, ingredientAmount: data.value(forKey: "amount") as? String, initialUnit: data.value(forKey: "initialUnit") as? String, substituteUnit: data.value(forKey: "substituteUnit") as? String
                ))
            }
        } catch let error as NSError {
            print("Error due to : \(error.localizedDescription)")
        }
    }
    
    

}
