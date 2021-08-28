//
//  DetailsCell.swift
//  TasKClicks
//
//  Created by Sameh Sengab on 25/08/2021.
//

import UIKit
import Kingfisher
class DetailsCell: UITableViewCell {
    
    @IBOutlet weak private var ViewCell: UIView!
    @IBOutlet weak var DetailsLabel: UILabel!
    @IBOutlet weak var SourceNameLabel: UILabel!
    @IBOutlet weak var TopicImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewCell.layer.cornerRadius = 16
        allShadowView(mView: ViewCell , radius: 4)
        layer.masksToBounds = true
        TopicImg.layer.cornerRadius = 16
        TopicImg.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
    }
    
    func allShadowView (mView : UIView , radius : CGFloat) {
        mView.layer.shadowColor = #colorLiteral(red: 0.4534327984, green: 0.4535132051, blue: 0.4534222484, alpha: 1)
        mView.layer.shadowOpacity = 1
        mView.layer.shadowOffset = .zero
        mView.layer.shadowRadius = radius
    }
    
    func Config(Model:Articles)  {
        DetailsLabel.text = Model.title ?? ""
        SourceNameLabel.text = Model.source?.name ?? ""
        TopicImg.loadImage(URL(string: Model.urlToImage ?? ""))
    }
}

