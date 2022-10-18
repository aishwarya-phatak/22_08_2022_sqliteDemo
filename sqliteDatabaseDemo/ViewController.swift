//
//  ViewController.swift
//  sqliteDatabaseDemo
//
//  Created by Vishal Jagtap on 14/10/22.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var dbHelper = DBHelper()
        dbHelper.openDatabase()
        dbHelper.createTable()
        dbHelper.retriveDataFromDatabase()
        dbHelper.insert(id: 1, age: 23, name: "Akshay T")
        dbHelper.insert(id: 2, age: 24, name: "Akshay V")
        dbHelper.insert(id: 3, age: 24, name: "Vinod")
        dbHelper.insert(id: 4, age: 27, name: "XYZ")
        dbHelper.insert(id: 5, age: 21, name: "ABC")
        
        dbHelper.retriveDataFromDatabase()
        dbHelper.deleteRecordFromDatabase(id: 2)
        dbHelper.retriveDataFromDatabase()
    }
}
