//
//  User.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/13.
//

import Foundation
import Firebase

class User {
    
    var email: String
    var name: String
    var createdAt: Timestamp
    
    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
