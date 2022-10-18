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
    
    //Creating Database
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
    
    //Creating Table in Database
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
    
    //Inserting data to table - insert query
    func insert(id : Int,age : Int,name : String ){
        
        let persons = retriveDataFromDatabase()
        
        for eachPerson in persons{
            if eachPerson.id == id{
                return
            }
        }
        
        let queryStringForInsert = "INSERT INTO Person(Id,Age,Name) VALUES (?,?,?);"
        var insertStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              queryStringForInsert,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_int(insertStatement, 2, Int32(age))
            sqlite3_bind_text(insertStatement,
                              3,
                              (name as NSString).utf8String,
                              -1,
                              nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Row inserted successfully!")
            }else{
                print("Row not inserted")
            }
            
        }else{
            print("Prepare Statement not created")
        }
        sqlite3_finalize(insertStatement)
    }
    
    //Retrive records from database
    func retriveDataFromDatabase()->[Person]{
        
        let queryForFetchingRecords = "SELECT * FROM Person;"
        var retriveStatement : OpaquePointer? = nil
        var persons : [Person] = []
        //var persons = [Person]()
        if sqlite3_prepare_v2(db,
                              queryForFetchingRecords,
                              -1,
                              &retriveStatement,
                              nil) == SQLITE_OK{
            while sqlite3_step(retriveStatement) == SQLITE_ROW{
                let retrivedId = sqlite3_column_int(retriveStatement, 0)
                let retrivedAge = sqlite3_column_int(retriveStatement, 1)
                let retrivedName = String(describing:
                                            String(
                                                cString:
                                                sqlite3_column_text(retriveStatement, 2)))
                
                persons.append(Person(id: Int(retrivedId), age: Int(retrivedAge), name: retrivedName))
                print("Id -- \(retrivedId)  Age -- \(retrivedAge)  Name -- \(retrivedName)")
            }
        }else{
            print("retrive query statement could not be prepared!")
        }
        sqlite3_finalize(retriveStatement)
        return persons
    }
    
    func deleteRecordFromDatabase(id : Int){
        let queryStringForDeletingRecord = "DELETE FROM Person WHERE Id = ?;"
        var deleteQueryStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              queryStringForDeletingRecord,
                              -1,
                              &deleteQueryStatement,
                              nil) == SQLITE_OK{
            
            sqlite3_bind_int(deleteQueryStatement, 1, Int32(id))
           if sqlite3_step(deleteQueryStatement) == SQLITE_DONE{
                print("Record deleted successfully!")
            }
            else {
                print("Record deletion unsuccessful!")
            }
        }else{
            print("Query for delete not prepared")
        }
        sqlite3_finalize(deleteQueryStatement)
    }
}
