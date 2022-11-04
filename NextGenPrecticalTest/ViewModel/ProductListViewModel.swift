//
//  ProductListViewModel.swift
//  NextGenPrecticalTest
//
//  Created by Mayank Mangukiya on 04/11/22.
//

import Foundation


class ProductListViewModel {
    
     var productArray = [Product]()
    
    func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    
    func loadDataFromSQLiteDatabase() {
        productArray = SQLiteCommands.presentRows() ?? []
    }
    
    func numberOfRowsInSection (section: Int) -> Int {
        if productArray.count != 0 {
            return productArray.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Product {
        return productArray[indexPath.row]
    }
}
