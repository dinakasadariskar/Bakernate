//
//  onBoardingCollectionViewCell.swift
//  Bakernate
//
//  Created by Natalia fellyana Laurensia on 10/06/21.
//

import UIKit

class onBoardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCV: UIImageView!
    @IBOutlet weak var titleCV: UILabel!
    @IBOutlet weak var descCV: UILabel!
    
    func set(_ slide: onBoardingSlide) {
        imageCV.image = slide.image
        titleCV.text = slide.title
        descCV.text = slide.desc
    }
    
}
