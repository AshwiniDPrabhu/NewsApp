//
//  ViewController.swift
//  NewsApp
//
//  Created by Ashwini Prabhu on 4/21/20.
//  Copyright © 2020 experiment. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import ObjectMapper
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var newsTable: UITableView!
    var articles: Array<NewsArticle> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsTable.delegate = self
        newsTable.dataSource = self
        
        let params = [
            "sortBy" : "latest",
        ]

            Alamofire.request("https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=b819439b081343b5bdcbe3d8e6cc46c5",
                              method: .get,
                              parameters: params)
            .validate()
            .responseJSON { response in
                if let json = response.result.value as? [String : Any]{
                if let articleArray = json["articles"] as? Array<[String : Any]>{
                    for articleData in articleArray{
                        guard let article = Mapper<NewsArticle>().map(JSON: articleData) else{ continue}
                        self.articles.append(article)
                    }
                }
            }
            self.newsTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
       }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = newsTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
    
    let article = articles[indexPath.row]
    cell.newsLabel.text = article.articleTitle
    
    if let imgURL = URL(string: article.imageURL){
        cell.newsImage.kf.setImage(with: imgURL)
    }
        
    return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        if let artURL = URL(string: article.url){
            UIApplication.shared.openURL(artURL)
        }
    }

}

