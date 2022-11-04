//
//  tableViewCells.swift
//  NextGenPrecticalTest
//
//  Created by Mayank Mangukiya on 04/11/22.
//

import UIKit

class tableViewCells: UITableViewCell {
    @IBOutlet weak var lblProductQuantity: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductNote: UILabel!
    
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var removeButtton: UIButton!
    
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.cornerRadius = 15
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // Set up Product
    func setCellWithValuesOf(_ product: Product) {
        lblProductName.text = product.name
        lblProductQuantity.text = "\(product.quantity)"
        lblProductPrice.text = "\(product.price)"
        
        if product.note == "" {
            lblProductNote.isHidden = true
        }else{
            lblProductNote.isHidden = false
            lblProductNote.text = product.note
        }
        
        if product.quantity == 0.0 {
            orderButton.isUserInteractionEnabled = false
            orderButton.backgroundColor = .gray
            backView.backgroundColor = .lightGray
        }else{
            orderButton.backgroundColor = .blue
            backView.backgroundColor = .white
            orderButton.isUserInteractionEnabled = true
        }
       
    }
    
}
