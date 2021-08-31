//
//  UserDefaultsHelper.swift
//  UserDefaultObject
//
//  Created by Milan on 31/08/21.
//  Copyright © 2021 Milan. All rights reserved.
//

import Foundation

class UserDefaultsHelper: NSObject {
    
    static let shared = UserDefaultsHelper()
    
    func setDataToPreference(data: Any, forKey key: String) {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            UserDefaults.standard.set(archivedData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print("setDataToPreference error = \(error)")
        }
    }
    
    func getDataFromPreference(key: String) -> Any? {
        let archivedData = UserDefaults.standard.object(forKey: key)
        if(archivedData != nil) {
            do {
                let value = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData! as! Data)
                return value
            } catch {
                print("getDataFromPreference error = \(error)")
                
            }
        }
        return nil
    }
    
    func setData<T: Codable>(data: T, forKey key: String) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(jsonData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch let error {
            print(error)
        }
    }
    
    func getData<T: Codable>(objectType: T.Type, forKey key: String) -> T? {
        guard let result = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(objectType, from: result)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func removeDataFromPreference(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func isKeyExistInPreference(key: String) -> Bool {
        if(UserDefaults.standard.object(forKey: key) == nil) {
            return false
        }
        return true
    }
}
