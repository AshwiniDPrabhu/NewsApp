//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Ashwini Prabhu on 4/21/20.
//  Copyright © 2020 experiment. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsArticle : Mappable{

    var articleTitle : String = ""
    var imageURL : String = ""
    var url : String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        articleTitle <- map["title"]
        imageURL <- map["urlToImage"]
        url <- map["url"]
    }
}
