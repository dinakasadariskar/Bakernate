//
//  OnBoardingViewController.swift
//  Bakernate
//
//  Created by Natalia fellyana Laurensia on 10/06/21.
//

import UIKit

struct onBoardingSlide {
    var title : String?
    var desc : String?
    var image : UIImage?
}

class OnBoardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var onBoardingCV: UICollectionView!
    @IBOutlet weak var getStarted: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slide.count - 1 {
                //getStarted.isHidden = false
                getStarted.setTitle("Get Started", for: .normal)
                getStarted.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                getStarted.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                getStarted.backgroundColor = #colorLiteral(red: 0.2592023611, green: 0.4294797182, blue: 0.4283112288, alpha: 1)
                
            } else {
                getStarted.setTitle("Skip", for: .normal)
                getStarted.setTitleColor(#colorLiteral(red: 0.2592023611, green: 0.4294797182, blue: 0.4283112288, alpha: 1), for: .normal)
                getStarted.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                getStarted.backgroundColor = UIColor.clear
            }
        }
    }
    
    var slide :[onBoardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slide = [onBoardingSlide(title: "Substitute", desc: "Find an alternative ingredients that suits your pantry", image: #imageLiteral(resourceName: "icon substitution-3")), onBoardingSlide(title: "Measure", desc: "Get the right measurement for your substitute ingredient", image: #imageLiteral(resourceName: "icon substitution-4")), onBoardingSlide(title: "Learn", desc: "In this app, you can discover and learn about the ingredients that you want to use", image: #imageLiteral(resourceName: "icon substitution-5"))]
        
        designInterface()
        onBoardingCV.delegate = self
        onBoardingCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func designInterface() {
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        onBoardingCV.backgroundColor = #colorLiteral(red: 0.9642314315, green: 0.9890750051, blue: 0.9884980321, alpha: 1)
        getStarted.layer.cornerRadius = 10
        getStarted.clipsToBounds = true
    }
    
    @IBAction func getStartedBtn(_ sender: Any) {
        if currentPage == slide.count - 1 {
            performSegue(withIdentifier: "substitution", sender: self)
        } else if (currentPage == slide.count - 3){
            currentPage += 2
            let indexPath = IndexPath(item: currentPage, section: 0)
            onBoardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onBoardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onBoardingCV.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCollectionViewCell
        
        cell.set(slide[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onBoardingCV.frame.width, height: onBoardingCV.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
