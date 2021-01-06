//
//  HomeModel.swift
//  Akash_iOS_Practical
//
//  Created by Aakash Patel on 06/01/21.
//

import Foundation

class HomeModel : NSObject
{
    static let shared = HomeModel()
    
    //MARK:- Create Product List Array
    func create_Prod_Array()  -> NSArray
    {
        let prodListArray = NSMutableArray()
        
        for i in 0 ..< 5
        {
            let dict = ["prodName": "iPhone\(i + 1)",
                        "prodID" : "\(i + 101)",
                        "prodPrice": "\(i + 1000)$",
                        "prodImage":"prodImg\(i + 1)",]
            prodListArray.add(dict)
        }
        return prodListArray
    }
}
