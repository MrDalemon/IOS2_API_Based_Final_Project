//
//  Driver.swift
//  ApiFinalProject
//
//  Created by Angelo Paolella on 2023-04-14.
//

import Foundation

class Driver {
    
    var name : String = ""
    var championshipPos : String = ""
    var constructor : String = ""
    var points : String = ""
   
    
    //constructor
    init(name : String, championshipPos : String,constructor : String , points : String){
        self.name = name
        self.championshipPos = championshipPos
        self.constructor = constructor
        self.points = points
    }
    
}
