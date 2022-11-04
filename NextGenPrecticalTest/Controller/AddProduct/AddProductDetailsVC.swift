//
//  AddProductDetailsVC.swift
//  NextGenPrecticalTest
//
//  Created by Mayank Mangukiya on 04/11/22.
//

import UIKit
import SkyFloatingLabelTextField

class AddProductDetailsVC: UIViewController {
    
    var viewModel: ProductViewModel!
    
    @IBOutlet weak var txtProductName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtProductQuantity: SkyFloatingLabelTextField!
    @IBOutlet weak var txtProductPrice: SkyFloatingLabelTextField!
    @IBOutlet weak var txtProductNote: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var btnAddProduct: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        title = "Add Product"

        txtProductName.delegate = self
        txtProductQuantity.delegate = self
        txtProductPrice.delegate = self
        txtProductNote.delegate = self
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Connect to database and create table.
    private func createTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
    }
    

    @IBAction func tappedAddProductButton(_ sender: UIButton) {
        
        
        let validationResult = validateForm()
        guard  validationResult.self else
        {
//             self.showErrorMessage2(message: "Please fill Mendetory Fields.")
            return
        }
        
        let id: Int = viewModel == nil ? 0 : viewModel.id!
        let name = txtProductName.text ?? ""
        let quantity = Double(txtProductQuantity.text ?? "") ?? 0.0
        let price = Double(txtProductPrice.text ?? "") ?? 0.0
        let note = txtProductNote.text ?? ""
        
        if quantity <= 0.0 {
            showError("Alert", message: "Can not enter nagative quantity.")
            return
        }
        
        if price <= 0.0 {
            showError("Alert", message: "Can not enter nagative price value.")
            return
        }
        
        let productValue = Product(id: id, name: name, quantity: quantity, price: price, note: note)
        
        if viewModel == nil {
            createProduct(productValue)
        }
    }
    
    // MARK: - Create new contact
    private func createProduct(_ productValues:Product) {
        let contactAddedToTable = SQLiteCommands.insertRow(productValues)
        
        // Phone number is unique to each contact so we check if it already exists
        if contactAddedToTable == true {
            self.navigationController?.popViewController(animated: true)
        } else {
            showError("Error", message: "Product is already in the list.")
        }
    }
   
}


extension AddProductDetailsVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if textField == txtProductName {
            txtProductName.errorMessage = ""
            txtProductName.errorColor = .black
        }
        if textField == txtProductQuantity {
            txtProductQuantity.errorMessage = ""
            txtProductQuantity.errorColor = .black
        }
        if textField == txtProductPrice {
            txtProductPrice.errorMessage = ""
            txtProductPrice.errorColor = .black
        }
        return true
    }
}
extension AddProductDetailsVC {
    // MARK: - Validation Login
    func validateForm() -> Bool {
        
        var isvalids:Bool = true
 
        let names = txtProductName.text ?? ""
        let quantitys = txtProductQuantity.text ?? ""
        let prices = txtProductPrice.text ?? ""
        
        if names.count == 0 {
            txtProductName.errorMessage = "Please Fill Product Name"
            txtProductName.errorColor = .red
            isvalids = false
        }
        
        if quantitys.count == 0  {
            txtProductQuantity.errorMessage = "Please Fill Product Quantity"
            txtProductQuantity.errorColor = .red
            isvalids = false
        }
        if prices.count == 0  {
            txtProductPrice.errorMessage = "Please Fill Product Price"
            txtProductPrice.errorColor = .red
            isvalids = false
        }
     
        return isvalids
    }
}
