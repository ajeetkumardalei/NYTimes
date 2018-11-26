//
//  Model.swift
//  NYTimeDemo
//
//  Created by Ajeet on 26/11/18.
//  Copyright © 2018 Ajeet. All rights reserved.
//

import Foundation

let apiKey = "6269d985deb24f17804dbbead501de08"
let baseURL = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/"
let endPoint = "all-sections/7.json?api-key=\(apiKey)"


struct Response:Codable{
    let status:String?
    let copyright:String?
    let num_results:Int?
    let results:Result?
    
    init(_ dictionary:[String:Any]){
        self.status = dictionary["status"] as? String
        self.copyright = dictionary["copyright"] as? String
        self.num_results = dictionary["num_results"] as? Int
        self.results = dictionary["results"] as? Result
    }
}

struct Result:Codable {
    //we required this 3 key-value only to show in table
    var title:String?
    var published_date:String?
    var byline:String?
    var url:String?
    
    init(_ dict:[String:Any]){
        self.title = dict["title"] as? String
        self.published_date = dict["published_date"] as? String
        self.byline = dict["byline"] as? String
        self.url = dict["url"] as? String
    }
}


