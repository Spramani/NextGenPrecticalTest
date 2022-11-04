//
//  ProductViewModel.swift
//  NextGenPrecticalTest
//
//  Created by Mayank Mangukiya on 04/11/22.
//

import Foundation


class ProductViewModel {
    
    private var productValues: Product?
    
    let id: Int?
    let name: String?
    let quantity: Double?
    let price: Double?
    let note: String?
    
    init(productValues: Product?) {
        self.productValues = productValues
        
        self.id = productValues?.id
        self.name = productValues?.name
        self.quantity = productValues?.quantity
        self.price = productValues?.price
        self.note = productValues?.note
        
    }
}
