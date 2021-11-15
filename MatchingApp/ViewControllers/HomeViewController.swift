//
//  HomeViewController.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/10.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private var user: User?
    //自分以外のユーザー情報
    private var users = [User]()
    private let disposeBag = DisposeBag()
    
    let topControlView = TopControlView()
    let cardView = UIView()
    let bottomControlView = BottomControlView()

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
        setupBindings()
        
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
        
        fetchUsers()
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
    
    private func fetchUsers() {
        HUD.show(.progress) //グルグルインジケーター
        Firestore.fetchUsersFromFirestore { (users) in
            HUD.hide() //インジケーターを非表示
            self.users = users
            
            self.users.forEach { user in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
            }
            print("ユーザー情報の取得に成功")
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false //必須
        stackView.axis = .vertical //縦方向に
        
        self.view.addSubview(stackView)
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)]
            .forEach {$0.isActive = true}
    }
    
    private func setupBindings() {
        
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let profile = ProfileViewController()
                profile.user = self?.user
                profile.presentationController?.delegate = self
                self?.present(profile, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }

}

//MARK: - UIAdaptivePresentationControllerDelegate
extension HomeViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if Auth.auth().currentUser == nil {
            self.user = nil
            self.users = []
            
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen //フルスクリーン遷移
            self.present(nav, animated: true) //登録画面へ遷移
        }
    }
}
