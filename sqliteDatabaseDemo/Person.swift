//
//  Person.swift
//  sqliteDatabaseDemo
//
//  Created by Vishal Jagtap on 14/10/22.
//

import Foundation
class Person{
    var id : Int = 0
    var age : Int = 0
    var name : String = ""
    
    init(id: Int, age: Int, name: String) {
        self.id = id
        self.age = age
        self.name = name
    }
}
