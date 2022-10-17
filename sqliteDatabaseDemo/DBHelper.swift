//
//  DBHelper.swift
//  sqliteDatabaseDemo
//
//  Created by Vishal Jagtap on 14/10/22.
//

import Foundation
import SQLite3

class DBHelper{
    
    init(){
        db = openDatabase()
        createTable()
    }
    
    let dbPath : String = "myDatabase.sqlite"
    var db : OpaquePointer?
    
    func openDatabase()->OpaquePointer?{
        let fileURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent(dbPath)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("Error in opening your database!")
            return nil
        }else{
            print("Database is created successfully -- \(dbPath)")
            print("Database file URL --\(fileURL)")
            return db!
        }
    }
    
    func createTable(){
        let createTableString = "CREATE TABLE IF NOT EXISTS Person(Id INTEGER PRIMARY KEY, Age INTEGER, Name TEXT);"
        
        var createTableStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(
            db,
            createTableString,
            -1,
            &createTableStatement,
            nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Person Table is created!")
            }else{
                print("Person Table creation failed!")
            }
        }else{
            print("Create Statement Could Not be Prepared!")
        }
        
        sqlite3_finalize(createTableStatement)
    }
}
