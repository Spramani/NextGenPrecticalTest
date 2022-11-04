//
//  ViewProductListVC.swift
//  NextGenPrecticalTest
//
//  Created by Mayank Mangukiya on 04/11/22.
//

import UIKit

class ViewProductListVC: UIViewController {
    
    var isQuantityEmpty:Bool = false
    private var viewModel = ProductListViewModel()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let nib = UINib(nibName: "tableViewCells", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "tableViewCells")
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableView.automaticDimension
            tableView.tableFooterView = nil
            tableView.tableHeaderView = nil
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product List"
        viewModel.connectToDatabase()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
        tableView.reloadData()
    }
    
    // MARK: - Load data from SQLite database
    private func loadData() {
        viewModel.loadDataFromSQLiteDatabase()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
//MARK: - TableView delegate and datasource
extension ViewProductListVC: UITableViewDelegate, UITableViewDataSource{
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.numberOfRowsInSection(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCells", for: indexPath) as! tableViewCells
        // Configure the cell...
        let object = viewModel.cellForRowAt(indexPath: indexPath)
        cell.removeButtton.tag = indexPath.row
        cell.orderButton.tag = indexPath.row
        cell.removeButtton.addTarget(self, action: #selector(tappedRemoveButton), for: .touchUpInside)
        cell.orderButton.addTarget(self, action: #selector(tappedOrderButton), for: .touchUpInside)
        cell.setCellWithValuesOf(object)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @objc func tappedRemoveButton(sender: UIButton){
        
        let product = viewModel.productArray[sender.tag]
        // Delete contact from database table
        SQLiteCommands.deleteRow(productId: product.id)
        
        // Updates the UI after delete changes
        self.loadData()
        self.tableView.reloadData()
    }
    
    @objc func tappedOrderButton(sender: UIButton){
        
        
        var data = viewModel.productArray[sender.tag]
       
            data.quantity = data.quantity - 1
            
            updateContact(data)
    
        
      

        
    }
    
    // MARK: - Update contact
    private func updateContact(_ productValues: Product) {
        
        
        let contactUpdatedInTable = SQLiteCommands.updateRow(productValues)
        
        
        // Phone number is unique to each contact so we check if it already exists
        if contactUpdatedInTable == true {
//            if let cellClicked = navigationController {
//                cellClicked.popViewController(animated: true)
//            }
            showError("Congrasulation!.", message: "Order is created with total : \(productValues.price)")
            self.loadData()
            self.tableView.reloadData()

        } else {
            showError("Error", message: "sd")
        }
    }
}
