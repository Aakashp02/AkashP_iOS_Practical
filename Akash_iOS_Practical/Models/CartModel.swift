//
//  CartModel.swift
//  Akash_iOS_Practical
//
//  Created by Aakash Patel on 06/01/21.
//

import Foundation

class CartModel: NSObject
{
    static let shared = CartModel()
    
    //MARK:- Create Cart Product List Array
    func get_Cart_Prod_Array()  -> NSArray
    {
        let cartProdArray = NSMutableArray()
        cartProdArray.addObjects(from: (Utils.shared.FetchFromUserDefault(Key: cartProdArrayKey) as? NSArray ?? []) as! [Any])
        return cartProdArray
    }
    
    //MARK:- Add Product to Cart
    func add_Prod_Cart(dict : NSDictionary)
    {
        if UserDefaults.standard.object(forKey: cartProdArrayKey) == nil
        {
            let tempArray = NSMutableArray()
            let prodDict = NSMutableDictionary()
            prodDict.addEntries(from: dict as! [AnyHashable : Any])
            prodDict.setValue("1", forKey: "prodQTY")
            tempArray.add(prodDict)
            Utils.shared.SaveToUserDefault(value: tempArray, Key: cartProdArrayKey)
        }else{
            
            let saveProdArray = NSMutableArray()
            saveProdArray.addObjects(from: (Utils.shared.FetchFromUserDefault(Key: cartProdArrayKey) as? NSArray ?? []) as! [Any])
            var flagForNewProdAdd : Bool = false
            
            for i in 0 ..< saveProdArray.count
            {
                let dataModel = (saveProdArray.object(at: i) as! NSDictionary)
                let prodDict = NSMutableDictionary()
                prodDict.addEntries(from: dataModel as! [AnyHashable : Any])
                
                if (prodDict.object(forKey: "prodID") as? String ?? "") == (dict.object(forKey: "prodID") as? String ?? "")
                {
                    flagForNewProdAdd = true
                    let QTY = Int(prodDict.object(forKey: "prodQTY") as? String ?? "")! + 1
                    prodDict.setValue("\(QTY)", forKey: "prodQTY")
                    saveProdArray.replaceObject(at: i, with: prodDict)
                    Utils.shared.SaveToUserDefault(value: saveProdArray, Key: cartProdArrayKey)
                    break
                }
            }
            if flagForNewProdAdd == false
            {
                let saveProdArray = NSMutableArray()
                saveProdArray.addObjects(from: (Utils.shared.FetchFromUserDefault(Key: cartProdArrayKey) as? NSArray ?? []) as! [Any])
                let prodDict = NSMutableDictionary()
                prodDict.addEntries(from: dict as! [AnyHashable : Any])
                prodDict.setValue("1", forKey: "prodQTY")
                saveProdArray.add(prodDict)
                Utils.shared.SaveToUserDefault(value: saveProdArray, Key: cartProdArrayKey)
            }
        }
    }
    
    //MARK:- Remove Product to Cart
    func remove_Prod_Cart(dict : NSDictionary)
    {
        if UserDefaults.standard.object(forKey: cartProdArrayKey) != nil
        {
            let saveProdArray = NSMutableArray()
            saveProdArray.addObjects(from: (Utils.shared.FetchFromUserDefault(Key: cartProdArrayKey) as? NSArray ?? []) as! [Any])
            for i in 0 ..< saveProdArray.count
            {
                let dataModel = (saveProdArray.object(at: i) as! NSDictionary)
                let prodDict = NSMutableDictionary()
                prodDict.addEntries(from: dataModel as! [AnyHashable : Any])
                
                if (prodDict.object(forKey: "prodID") as? String ?? "") == (dict.object(forKey: "prodID") as? String ?? "")
                {
                    let QTY = Int(prodDict.object(forKey: "prodQTY") as? String ?? "")! - 1
                    if QTY < 1
                    {
                        saveProdArray.removeObject(at: i)
                        Utils.shared.SaveToUserDefault(value: saveProdArray, Key: cartProdArrayKey)
                        break
                    }else{
                        prodDict.setValue("\(QTY)", forKey: "prodQTY")
                        saveProdArray.replaceObject(at: i, with: prodDict)
                        Utils.shared.SaveToUserDefault(value: saveProdArray, Key: cartProdArrayKey)
                        break
                    }
                }
            }
        }
    }
    
    //MARK:- QTY check
    func qty_Existing_Check(dict : NSDictionary) -> String
    {
        var QTYString : String = "0"
        let saveProdArray = (Utils.shared.FetchFromUserDefault(Key: cartProdArrayKey) as? NSArray ?? [])
        for i in 0 ..< saveProdArray.count
        {
            let dataModel = (saveProdArray.object(at: i) as! NSDictionary)
            let prodDict = NSMutableDictionary()
            prodDict.addEntries(from: dataModel as! [AnyHashable : Any])
            
            if (prodDict.object(forKey: "prodID") as? String ?? "") == (dict.object(forKey: "prodID") as? String ?? "")
            {
                QTYString = (prodDict.object(forKey: "prodQTY") as? String ?? "")
            }
        }
        return QTYString
    }
}
