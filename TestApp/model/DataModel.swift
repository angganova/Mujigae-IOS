//
//  DataModel.swift
//  TestApp
//
//  Created by Ania on 15/04/19.
//  Copyright © 2019 FullStackDiv. All rights reserved.
//

import UIKit

class DataModel: Equatable, Hashable{
    var id : String
    var name : String
    var selected : Bool = false
    
    init (id: String, name: String){
        self.id = id
        self.name = name
    }
    
    var hashValue: Int{
        get{
            return id.hashValue
        }
    }
    
    static func ==(lhs: DataModel, rhs: DataModel) -> Bool{
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
