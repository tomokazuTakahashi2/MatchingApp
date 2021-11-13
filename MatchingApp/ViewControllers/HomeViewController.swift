//
//  HomeViewController.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/10.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    private var user: User?
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            let registerController = RegisterViewController()
//            let nav = UINavigationController(rootViewController: registerController)
//            nav.modalPresentationStyle = .fullScreen //フルスクリーン遷移
//            self.present(nav, animated: true) //まずは登録画面へ遷移
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //ログイン時にユーザー情報を取得
        Firestore.fetchUserFromFirestore(uid: uid) { (user) in
            if let user = user {
                self.user = user
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //ログイン情報(uid)がnilだったら、登録画面へ遷移
        if Auth.auth().currentUser?.uid == nil {
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen //フルスクリーン遷移
            self.present(nav, animated: true) //まずは登録画面へ遷移
        }
    }
    
    // MARK: - Methods
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let topControlView = TopControlView()
        let cardView = CardView()
        let bottomControlView = BottomControlView()
        
        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false //必須
        stackView.axis = .vertical //縦方向に
        
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)]
            .forEach {$0.isActive = true}
        
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
    }
    
    @objc private func tappedLogoutButton() {
        
        do {
            try Auth.auth().signOut()
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen //フルスクリーン遷移
            self.present(nav, animated: true) //登録画面へ遷移
        } catch {
            print("ログアウトに失敗: ", error)
        }
    }

}

