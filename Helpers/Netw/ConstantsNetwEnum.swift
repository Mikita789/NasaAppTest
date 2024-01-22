//
//  ConstantsNetwEnum.swift
//  NasaAppTest
//
//  Created by Никита Попов on 12.12.23.
//

import Foundation


enum ConstantsNetw{
    static var endPointUrl:URL?{
        //"https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "api.nasa.gov"
        urlComp.path = "/planetary/apod"
        urlComp.queryItems = [URLQueryItem(name: "api_key", value: "tBJr7TqVTPceXthKx79qXrX9ag4pPmdOcg3yUhju")]
        
        return urlComp.url
    }
    
    static var searchEndpoint:URL?{
        //https://images-api.nasa.gov
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "images-api.nasa.gov"
        urlComponents.path = "/search"
        urlComponents.queryItems = [URLQueryItem(name: "media_type", value: "image"),
                                    URLQueryItem(name: "page_size", value: "20")
        ]
        return urlComponents.url
    }
    
    static func getURLStringSearch(textQ: String )->String{
        guard let res = self.searchEndpoint else { return "no url" }
        let resultStr = res.absoluteString + "&q=\(textQ)"
        return resultStr
    }
    
    static func getURLString()-> String {
        guard let res = self.endPointUrl else { return "no url" }
        return res.absoluteString
    }
    
    
}
