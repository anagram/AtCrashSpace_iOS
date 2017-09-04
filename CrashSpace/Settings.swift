//
//  Settings.swift
//  CrashSpace
//
//  Created by anne graham on 09/04/17.
//  Copyright © 2017 anagramfx. All rights reserved.
//

import Foundation


class Settings {
    
    
    var version : String = "v1.00"
        
    public static var userName: String? {
        get {
            if let theValue = UserDefaults.standard.string(forKey: "userName"){
                print("returning topic  \(theValue)")
                return UserDefaults.standard.string(forKey: "userName")!
            }
            return nil
        }
        set(newValue) {
            print("saving userName \(String(describing: newValue))")
            UserDefaults.standard.set(newValue, forKey: "userName")
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var message: String? {
        get {
            if let theValue = UserDefaults.standard.string(forKey: "message"){
                print("returning message  \(theValue)")
                return UserDefaults.standard.string(forKey: "message")!
            }
            return nil
        }
        set(newValue) {
            print("saving message \(String(describing: newValue))")
            UserDefaults.standard.set(newValue, forKey: "message")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    let defaults = UserDefaults.standard
    
    init() {
        print("called init of Settings class")
        registerDefaults()
    }
    
    
    // MARK: - User Defaults Initial values when app is first run:
    
    func registerDefaults() {
        
        defaults.register(defaults: [
            "userName": "ios test user",
            "message": "ios test!"
            ])
        
    }
    
}
