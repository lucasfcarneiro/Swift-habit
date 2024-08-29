//
//  LocalDataSource.swift
//  Habit
//
//  Created by Lucas Fagundes Carneiro on 29/08/24.
//

import Foundation
import Combine

class LocalDataSource {
    
    private func saveValue(value: UserAuth){
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    private func readValue(forkey key: String) -> UserAuth?{
        var userAuth: UserAuth?
        
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth
    }
}

extension LocalDataSource {
    
    func insertUserAuth(userAuth: UserAuth){
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never>{
        let userAuth = readValue(forkey: "user_key")
        return Future { promise in
            promise(.success(userAuth))
        }
    }
}
