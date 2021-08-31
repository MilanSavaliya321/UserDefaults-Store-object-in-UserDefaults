//
//  ViewController.swift
//  UserDefaultObject
//
//  Created by Milan on 30/08/21.
//  Copyright © 2021 Milan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeData()
        getData()
        removeData()
    }
    
    func storeData() {
        let note = Note(id: 1, title: "test", body: "testboady")
        setData(data: note, forKey: "notes")
        //        let notes = [note]
        //
        //        do {
        //            // Create JSON Encoder
        //            let encoder = JSONEncoder()
        //
        //            // Encode Note
        //            let data = try encoder.encode(notes)
        //
        //            // Write/Set Data
        //            UserDefaults.standard.set(data, forKey: "notes")
        //
        //        } catch {
        //            print("Unable to Encode Array of Notes (\(error))")
        //        }
    }
    
    func getData() {
        let note = getData(objectType: Note.self, forKey: "notes")
        if let notes = note {
            print(notes)
        } else {
            print("no data")
        }
        
        //        if let data = UserDefaults.standard.data(forKey: "notes") {
        //            do {
        //                // Create JSON Decoder
        //                let decoder = JSONDecoder()
        //
        //                // Decode Note
        //                let notes = try decoder.decode([Note].self, from: data)
        //
        //                print(notes)
        //
        //            } catch {
        //                print("Unable to Decode Notes (\(error))")
        //            }
        //        } else {
        //            print("no Notes obj store in UserDefaults")
        //        }
    }
    
    func removeData() {
        if isKeyExistInPreference(key: "notes") {
            removeDataFromPreference(key: "notes")
        }
        getData()
    }
    
    private func setData<T: Codable>(data: T, forKey key: String) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(jsonData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch let error {
            print(error)
        }
    }
    
    private func getData<T: Codable>(objectType: T.Type, forKey key: String) -> T? {
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

struct Note: Codable {
    let id: Int
    let title: String
    let body: String
}


