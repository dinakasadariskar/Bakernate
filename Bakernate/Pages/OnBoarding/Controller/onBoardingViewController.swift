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
                getStarted.setTitle("Get Started", for: .normal)
                getStarted.setTitleColor(BakernateColor().white, for: .normal)
                getStarted.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                getStarted.backgroundColor = BakernateColor().green100
            } else {
                getStarted.setTitle("Next", for: .normal)
                getStarted.setTitleColor(BakernateColor().green100, for: .normal)
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
    }
    
    func designInterface() {
        getStarted.layer.cornerRadius = 10
        getStarted.clipsToBounds = true
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
    
    @IBAction func getStartedBtn(_ sender: Any) {
        if currentPage == slide.count - 1 {
            performSegue(withIdentifier: "substitution", sender: self)
        }
//        else if (currentPage == slide.count - 3){
//            currentPage += 2
//            let indexPath = IndexPath(item: currentPage, section: 0)
//            onBoardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        } else{
//            currentPage += 1
//            let indexPath = IndexPath(item: currentPage, section: 0)
//            onBoardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        if currentPage == slide.count - 1 {
            performSegue(withIdentifier: "substitution", sender: self)
        } else if (currentPage == slide.count - 3){
            currentPage += 2
            let indexPath = IndexPath(item: currentPage, section: 0)
            onBoardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onBoardingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
