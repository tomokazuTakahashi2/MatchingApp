//
//  Firebase-Extension.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/12.
//

import Firebase

//MARK: - Auth
extension Auth {
    //firebase/Authにログイン情報を保存
    static func createUserToFireAuth(email: String?, password: String?, name: String?, completion: @escaping (Bool) -> ()) {
        guard let email = email else { return }
        guard let password = password else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { auth, err in
            if let err = err {
                print("auth情報の保存に失敗: ", err)
                return
            }
            
            guard let uid = auth?.user.uid else { return }
            print("auth情報の保存に成功: ", uid)
            Firestore.setUserDataToFirestore(email: email, uid: uid, name: name) { success in
                completion(success)
            }
        }
    }
}

//MARK: - Firestore
extension Firestore {
    //firestoreへの保存
    static func setUserDataToFirestore(email: String, uid: String, name: String?, completion: @escaping (Bool) -> ()) {
        guard let name = name else { return }
        
        let document = [
            "name" : name,
            "email" : email,
            "createdAt" : Timestamp()
        ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).setData(document){ err in
            
            if let err = err {
                print("ユーザー情報のfirestoreへの保存が失敗: ",err)
                return
            }
            completion(true)
            print("ユーザー情報のfirestoreへの保存が成功")
        }
    }
    
}
