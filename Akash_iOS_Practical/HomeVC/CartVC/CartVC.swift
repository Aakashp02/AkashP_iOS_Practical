//
//  CartVC.swift
//  Akash_iOS_Practical
//
//  Created by Aakash Patel on 06/01/21.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblView : UITableView!
    var cartListArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CART"
        self.cartListArray = CartModel.shared.get_Cart_Prod_Array()
        self.cart_Empty_Check()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK:- TableView delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ProductCartCell", for: indexPath) as! ProductCartCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let dataModel = (self.cartListArray.object(at: indexPath.row) as! NSDictionary)
        
        cell.prodImg.image = UIImage.init(named: (dataModel.object(forKey: "prodImage") as? String ?? ""))
        cell.prodName.text = (dataModel.object(forKey: "prodName") as? String ?? "")
        cell.prodPrice.text = (dataModel.object(forKey: "prodPrice") as? String ?? "")
        
        if UserDefaults.standard.object(forKey: cartProdArrayKey) != nil
        {
            cell.prodQTY.text = CartModel.shared.qty_Existing_Check(dict: dataModel)
        }else{
            cell.prodQTY.text = "0"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    //MARK:- Add Product
    @IBAction func add_Product_Action(_ Sender : Any)
    {
        let buttonPosition = (Sender as AnyObject).convert(CGPoint.zero, to: self.tblView)
        let indexPath = self.tblView.indexPathForRow(at: buttonPosition)
        let dataModel = (self.cartListArray.object(at: indexPath!.row) as! NSDictionary)
        CartModel.shared.add_Prod_Cart(dict: dataModel)
        self.cartListArray = CartModel.shared.get_Cart_Prod_Array()
        self.cart_Empty_Check()
        self.tblView.reloadData()
    }
    
    //MARK:- Remove Product
    @IBAction func remove_Product_Action(_ Sender : Any)
    {
        let buttonPosition = (Sender as AnyObject).convert(CGPoint.zero, to: self.tblView)
        let indexPath = self.tblView.indexPathForRow(at: buttonPosition)
        let dataModel = (self.cartListArray.object(at: indexPath!.row) as! NSDictionary)
        CartModel.shared.remove_Prod_Cart(dict: dataModel)
        self.cartListArray = CartModel.shared.get_Cart_Prod_Array()
        self.cart_Empty_Check()
        self.tblView.reloadData()
    }
    
    //MARK:- Cart empty
    func cart_Empty_Check()
    {
        if self.cartListArray.count == 0
        {
            self.tblView.isHidden = true
        }else{
            self.tblView.isHidden = false
        }
    }
}
class ProductCartCell:UITableViewCell
{
    @IBOutlet weak var prodImg: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var prodQTY: UILabel!
}
