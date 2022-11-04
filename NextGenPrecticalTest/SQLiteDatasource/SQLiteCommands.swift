//
//  SQLiteCommands.swift
//  NextGenPrecticalTest
//
//  Created by Mayank Mangukiya on 04/11/22.
//

import Foundation
import SQLite

class SQLiteCommands {
    
    static var table = Table("product")
    
    // product details
    static let id = Expression<Int>("id")
    static let name = Expression<String>("Name")
    static let quantity = Expression<Double>("Quantity")
    static let price = Expression<Double>("Price")
    static let note = Expression<String>("Note")
    
    // Creating product table
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            // ifNotExists: true - Will NOT create a table if it already exists
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name, unique: true)
                table.column(quantity)
                table.column(price)
                table.column(note)
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }
    
    // Inserting Row
    static func insertRow(_ productValues:Product) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        do {
            try database.run(table.insert(name <- productValues.name, quantity <- productValues.quantity, price <- productValues.price, note <- productValues.note))
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Insertion failed: \(error)")
            return false
        }
    }
    
    // Updating Row
    static func updateRow(_ productValues: Product) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        // Extracts the appropriate contact from the table according to the id
        let contact = table.filter(id == productValues.id).limit(1)
        
        do {
            // Update the contact's values
            if try database.run(contact.update(name <- productValues.name, quantity <- productValues.quantity, price <- productValues.price, note <- productValues.note)) > 0 {
                print("Updated contact")
                return true
            } else {
                print("Could not update contact: contact not found")
                return false
            }
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Update row faild: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Updation failed: \(error)")
            return false
        }
    }
    
    // Present Rows
    static func presentRows() -> [Product]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        // product Array
        var productArray = [Product]()
        
        // Sorting data in descending order by ID
        table = table.order(id.desc)
        
        do {
            for product in try database.prepare(table) {
                
                let idValue = product[id]
                let nameValue = product[name]
                let quantityValue = product[quantity]
                let priceValue = product[price]
                let noteValue = product[note]
                
                // Create object
                let productObject = Product(id: idValue, name: nameValue, quantity: quantityValue, price: priceValue, note: noteValue)
              
                // Add object to an array
                productArray.append(productObject)
                
                print("id \(product[id]), name: \(product[name]), quantity: \(product[quantity]), price: \(product[price]), note: \(product[note])")
            }
        } catch {
            print("Present row error: \(error)")
        }
        return productArray
    }
    
    // Delete Row
    static func deleteRow(productId: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            let product = table.filter(id == productId).limit(1)
            try database.run(product.delete())
        } catch {
            print("Delete row error: \(error)")
        }
    }
}
