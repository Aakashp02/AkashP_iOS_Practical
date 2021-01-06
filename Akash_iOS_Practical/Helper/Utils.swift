//
//  Utils.swift
//  Akash_iOS_Practical
//
//  Created by Aakash Patel on 06/01/21.
//

import Foundation

class Utils : NSObject
{
    static let shared = Utils()
    
    //MARK: Save data to userdefault
    func SaveToUserDefault(value : Any, Key : String)
    {
        UserDefaults.standard.set(value, forKey: Key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Fetch data to userdefault
    func FetchFromUserDefault(Key : String) -> Any
    {
        return UserDefaults.standard.object(forKey: Key) as Any
    }
}
