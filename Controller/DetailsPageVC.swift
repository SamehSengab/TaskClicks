//
//  DetailsPageVC.swift
//  TasKClicks
//
//  Created by Sameh Sengab on 25/08/2021.
//

import UIKit

class DetailsPageVC: UIViewController {
    
    var data : Articles?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var topicImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicImg.loadImage(URL(string:data?.urlToImage ?? "" ))
        detailsLabel.text = data?.description ?? ""
        titleLabel.text = data?.title ?? ""
        sourceNameLabel.text = data?.source?.name ?? ""
        self.mainView.layer.cornerRadius = 24
        self.blueView.layer.cornerRadius = 24
        
    }
    @IBAction func BackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
