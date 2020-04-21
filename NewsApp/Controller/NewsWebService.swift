//
//  NewsWebService.swift
//  NewsApp
//
//  Created by Ashwini Prabhu on 4/21/20.
//  Copyright © 2020 experiment. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class NewsWebService{
    
    func makeRequest(articles: Array<NewsArticle>){
        let params = [
            "sortBy" : "latest",
        ]

            Alamofire.request("https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=b819439b081343b5bdcbe3d8e6cc46c5",
                              method: .get,
                              parameters: params)
            .validate()
            .responseJSON { response in
                if let json = response.result.value as? [String : Any]{
                    print(json)
                if let articleArray = json["articles"] as? Array<[String : Any]>{
                    for articleData in articleArray{
                        guard let article = Mapper<NewsArticle>().map(JSON: articleData) else{ continue}
                        self.articles.append(article)
                    }
                }
            }
        }
    }
}
