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
    }
}
