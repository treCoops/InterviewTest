//
//  APIHelper.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIHelper{
    var delagate : API?
    let url : String = "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json"
    
    
    func getHotelData(){
        
        var hotels : [Hotel] = []
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        if(json["status"] == 200){

                            if let body = json["data"].arrayObject{
                                for hotel in body {
                                    guard let innerDict = hotel as? [String: Any] else {
                                        continue
                                    }
            
                                    let image = JSON(innerDict["image"]!)
                                    
                                    hotels.append(Hotel(id: innerDict["id"] as! Int, title: innerDict["title"] as! String, description: innerDict["description"] as! String, address: innerDict["address"] as! String, postcode: innerDict["postcode"] as! String, phoneNumber: innerDict["phoneNumber"] as! String, latitude: innerDict["latitude"] as! String, longitude: innerDict["longitude"] as! String, image: Image(small: image["small"].rawValue as! String, medium: image["medium"].rawValue as! String, large: image["large"].rawValue as! String)))
                                }

                                self.delagate?.response(hotels: hotels)
                            }

                        }else{
                            self.delagate?.error(error: "No data available or internal server error.!")
                        }
                    
                    case .failure(let error):
                        print(error)
                        self.delagate?.error(error: error)
                    }
            })
    }
    
}

protocol API {
    func response(hotels: [Hotel])
    func error(error: Error)
    func error(error: String)
}

extension API {
    func response(hotels: [Hotel]){}
    func error(error: Error){}
    func error(error: String){}
}

