//
//  IngredientDetailsViewController.swift
//  Bakernate
//
//  Created by Roshani Ayu Pranasti on 11/06/21.
//

import UIKit

class IngredientDetailsViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imagesPageControl: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var isVeganImage: UIImageView!
    @IBOutlet weak var isEggImage: UIImageView!
    @IBOutlet weak var isSoyImage: UIImageView!
    @IBOutlet weak var isTreeNutsImage: UIImageView!
    @IBOutlet weak var isPeanutImage: UIImageView!
    @IBOutlet weak var isGlutenImage: UIImageView!
    @IBOutlet weak var isDairyImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productScrollView: UIScrollView!
    
    var selectedProductName: String = ""
    var selectedProductIsVegan: Bool = false
    var selectedProductIsEgg: Bool = false
    var selectedProductIsSoy: Bool = false
    var selectedProductIsTreeNuts: Bool = false
    var selectedProductIsPeanut: Bool = false
    var selectedProductIsGluten: Bool = false
    var selectedProductIsDairy: Bool = false
    var selectedProductDescriptions: String = ""
    var selectedProductImages: String = ""
    var currentPage = 0 {
        didSet {
            imagesPageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        productScrollView.delegate = self
        
        prepareUI()
    }
    
    func prepareUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(handleBackButton))
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2047558129, green: 0.356741339, blue: 0.3546977937, alpha: 1)
        
        productName.text = selectedProductName
        setupChip()
        productDescription.text = selectedProductDescriptions
    }
    
    func setupChip() {
        if selectedProductIsVegan {
            isVeganImage.image = UIImage(named: "Enabled Vegan")
        } else {
            isVeganImage.image = UIImage(named: "Disabled Vegan")
        }
        
        if selectedProductIsEgg {
            isEggImage.image = UIImage(named: "Enabled Egg")
        } else {
            isEggImage.image = UIImage(named: "Disabled Egg")
        }
        
        if selectedProductIsSoy {
            isSoyImage.image = UIImage(named: "Enabled Soy")
        } else {
            isSoyImage.image = UIImage(named: "Disabled Soy")
        }
        
        if selectedProductIsTreeNuts {
            isTreeNutsImage.image = UIImage(named: "Enabled Tree Nuts")
        } else {
            isTreeNutsImage.image = UIImage(named: "Disabled Tree Nuts")
        }
        
        if selectedProductIsPeanut {
            isPeanutImage.image = UIImage(named: "Enabled Peanut")
        } else {
            isPeanutImage.image = UIImage(named: "Disabled Peanut")
        }
        
        if selectedProductIsGluten {
            isGlutenImage.image = UIImage(named: "Enabled Gluten")
        } else {
            isGlutenImage.image = UIImage(named: "Disabled Gluten")
        }
        
        if selectedProductIsDairy {
            isDairyImage.image = UIImage(named: "Enabled Dairy")
        } else {
            isDairyImage.image = UIImage(named: "Disabled Dairy")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        productScrollView.contentInset = UIEdgeInsets(top: -46, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! IngredientDetailsCollectionViewCell
        cell.ingredientImage.image = UIImage(named: "\(selectedProductImages) \(indexPath.row + 1)")
            
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    // MARK:- objc
    @objc func handleBackButton(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension IngredientDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = imagesCollectionView.frame.size
        
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
