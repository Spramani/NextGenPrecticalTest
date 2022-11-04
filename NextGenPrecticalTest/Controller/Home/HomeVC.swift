//
//  HomeVC.swift
//  NextGenPrecticalTest
//
//  Created by Mayank Mangukiya on 04/11/22.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func tappedAddProductButton(_ sender: UIButton) {
        let vc = AddProductDetailsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedProductListButton(_ sender: UIButton) {
        
        let vc = ViewProductListVC()
        self.navigationController?.pushViewController(vc, animated: true)
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
