//
//  ViewController.swift
//  Akash_iOS_Practical
//
//  Created by Aakash Patel on 06/01/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblView : UITableView!
    var productListArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HOME"
        self.navigationItem.hidesBackButton = true
        self.productListArray = HomeModel.shared.create_Prod_Array()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.badge_SetonCart()
        self.tblView.reloadData()
    }
    
    
    // MARK:- TableView delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ProductCell", for: indexPath) as! ProductCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let dataModel = (self.productListArray.object(at: indexPath.row) as! NSDictionary)
        
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
        let dataModel = (self.productListArray.object(at: indexPath!.row) as! NSDictionary)
        CartModel.shared.add_Prod_Cart(dict: dataModel)
        self.tblView.reloadData()
        self.badge_SetonCart()
    }
    
    //MARK:- Remove Product
    @IBAction func remove_Product_Action(_ Sender : Any)
    {
        let buttonPosition = (Sender as AnyObject).convert(CGPoint.zero, to: self.tblView)
        let indexPath = self.tblView.indexPathForRow(at: buttonPosition)
        let dataModel = (self.productListArray.object(at: indexPath!.row) as! NSDictionary)
        CartModel.shared.remove_Prod_Cart(dict: dataModel)
        self.tblView.reloadData()
        self.badge_SetonCart()
    }
    
    //MARK:- Cart Screen Open
    @IBAction func cart_Open_Action(_ Sender : Any)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Badge set
    func badge_SetonCart()
    {
        let badgeCount = UILabel(frame: CGRect(x: 22, y: -05, width: 20, height: 20))
        badgeCount.layer.borderColor = UIColor.clear.cgColor
        badgeCount.layer.borderWidth = 2
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .red
        badgeCount.text = "\(CartModel.shared.get_Cart_Prod_Array().count)"
        
        let rightBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        rightBarButton.setBackgroundImage(UIImage.init(systemName: "cart"), for: .normal)
        rightBarButton.tintColor = .darkGray
        rightBarButton.addTarget(self, action: #selector(self.cart_Open_Action), for: .touchUpInside)
        rightBarButton.addSubview(badgeCount)
        
        let rightBarButtomItem = UIBarButtonItem(customView: rightBarButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem
    }
}
class ProductCell:UITableViewCell
{
    @IBOutlet weak var prodImg: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var prodQTY: UILabel!
}
