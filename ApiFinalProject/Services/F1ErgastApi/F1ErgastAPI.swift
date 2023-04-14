//
//  F1ErgastAPI.swift
//  ApiFinalProject
//
//  Created by Angelo Paolella on 2023-04-10.
//

import Foundation
import UIKit

class F1ErgastAPI{
    
    static let missingEndpoints  = "https://ergast.com/api/f1/"
    
    
    static func getCurrentStandings(successHandler: @escaping (_ httpStatusCode : Int, _ response : [String: Any]) -> Void,
                                    failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void){
        
        let endPoint = "current/driverStandings.json"
        
        let payload : [String:String] = [:]
     
        API.call(baseURL: missingEndpoints, endPoint: endPoint, payload: payload, successHandler: successHandler, failHandler: failHandler)
        
    }
    
    static func getPreviousStandings(year: String,successHandler: @escaping (_ httpStatusCode : Int, _ response : [String: Any]) -> Void,
                                    failHandler : @escaping (_ httpStatusCode : Int, _ errorMessage: String) -> Void){
        
        let endPoint = "\(year)/driverStandings.json"
        
        let payload : [String:String] = [:]
     
        API.call(baseURL: missingEndpoints, endPoint: endPoint, payload: payload, successHandler: successHandler, failHandler: failHandler)
        
    }
}

struct F1CurrentDriversStandings : Codable{
    
    var standingLists : [StandingsList]
    
    private enum CodingKeys: String,CodingKey{
      
        case standingLists = "StandingsLists"
    }
    
   struct StandingsList : Codable{
        
        var season : String
        var round : String
        var driverStandings : [DriverStandings]

        private enum CodingKeys: String, CodingKey{
            case season
            case round
            case driverStandings = "DriverStandings"
        }
    }
    
    struct DriverStandings : Codable {
        
        var position : String?
        var constructors : [Constructors]
        var driver : Driver
        var points : String?
        
        private enum CodingKeys: String,CodingKey{
            case position
            case constructors = "Constructors"
            case driver = "Driver"
            case points
        }
    }

    struct Constructors : Codable{
        
        var nationality : String?
        var name : String?
        
        private enum CodingKeys: String,CodingKey{
            case nationality
            case name
        }
    }
    struct Driver : Codable{
        
        var givenName : String?
        var familyName : String?
        var nationality : String?
        var url : String?
    }

    static func decode(json:[String:Any])->F1CurrentDriversStandings?{
        
        let decoder = JSONDecoder()
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let object = try decoder.decode(F1CurrentDriversStandings.self, from: data)
            return object
        }catch{
            print(error.localizedDescription)
        }
        return nil
    }
}

