//
//  Ex+Image.swift
//  TasKClicks
//
//  Created by Sameh Sengab on 27/08/2021.
//
import UIKit

extension UIImageView {
    func loadImage(_ url : URL?) {
        self.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "placeholder"),
            options: [
                
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        self.kf.indicatorType = .activity
       
    }
}
