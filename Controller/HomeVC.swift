//
//  HomeVC.swift
//  TasKClicks
//
//  Created by Sameh Sengab on 25/08/2021.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class HomeVC: UIViewController {
    
    var topicArray = [Articles]()
    var searchTopicArray = [Articles]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        login()
    }
    
    @IBAction func SearchAction(_ sender: UIButton) {
        topicArray = searchTopicArray
        topicArray = topicArray.filter({(($0.title!).contains(searchTF.text ?? ""))})
        if searchTF.text == ""  {
            topicArray = searchTopicArray
        }
        tableView.reloadData()
    }
}

// Tableview custom
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        Cell.Config(Model: topicArray[indexPath.row])
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DetailsPageVC" ) as! DetailsPageVC
        vc.data = topicArray[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

// api

extension HomeVC {
    
    func login(){
        
        lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "https://newsapi.org/v2/top-headlines?country=eg&apiKey=9f2d51b497584a8481738475650cb27a") { [weak self] (Model: HomeModel? , err : String? ) in
            
            self?.unlock()
            
            if  err != nil {
                print("err")
            }else {
                
                self?.topicArray = Model?.articles ?? []
                self?.searchTopicArray = self?.topicArray ?? []
                self?.tableView.reloadData()
            }
        }
    }
}

