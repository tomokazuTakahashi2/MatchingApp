//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/11.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()
    
    //MARK: -UIViews
    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "メールアドレス")
    private let passwordTextField = RegisterTextField(placeHolder: "パスワード")
    //↑に替わる
//    let nameTextField: UITextField = {
//       let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
//
//    let emailTextField: UITextField = {
//       let textField = UITextField()
//        textField.placeholder = "メールアドレス"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
//
//    let passwordTextField: UITextField = {
//       let textField = UITextField()
//        textField.placeholder = "パスワード"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
    
    private let registerButton = RegisterButton(text: "登録")
    //↑に替わる
//    let registerButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("登録", for: .normal)
//        button.backgroundColor = .red
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        return button
//    }()
    
    private let alreadyHaveAccountButton = UIButton(type: .system).creatAboutAccountButton(text: "既にアカウントをお持ちの場合はこちら")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ナビゲーションバーを非表示にする
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: -Methods
    //グラデーション
    private func setupGradientLayer() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        
        layer.colors = [startColor, endColor] //色１　→　色２
        layer.locations = [0.0, 1.3] //一番上(0.0)から一番下ちょい過ぎ(1.3)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    private func setupLayout() {
        passwordTextField.isSecureTextEntry = true //パスワードを非表示
        
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccountButton)
        
        nameTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor,  leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        alreadyHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
    }
    
    private func setupBindings() {
        //textfieldのバインディング
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
                //textの情報ハンドル
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")
                //textの情報ハンドル
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")
                //textの情報ハンドル
            }
            .disposed(by: disposeBag)
        //Buttonのバインディング
        registerButton.rx.tap //登録ボタン
            .asDriver()
            .drive {  [weak self] _ in
                //登録時の処理
                self?.createUser()
            }
            .disposed(by: disposeBag)
        
        alreadyHaveAccountButton.rx.tap //既にアカウントをお持ちの場合は〜ボタン
            .asDriver()
            .drive {  [weak self] _ in
                let login = LoginViewController()
                self?.navigationController?.pushViewController(login, animated: true)
            }
            .disposed(by: disposeBag)
        
        //viewModelのバインディング
        viewModel.validRegisterDriver
            .drive { validAll in
                print("validAll: ", validAll)
                self.registerButton.isEnabled = validAll
                //全て正しく入力されたら登録ボタンの色がついて、そうでなかったら灰色になる
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)
    }
    
    private func createUser() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        Auth.createUserToFireAuth(email: email, password: password, name: name) { succces in
            if succces {
                print("処理が完了")
                self.dismiss(animated: true) //処理が完了したらHome画面へ戻る
            } else {
                
            }
        }
    }
    
//    //firebase/Authにログイン情報を保存
//    private func createUserToFireAuth() {
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//        
//        Auth.auth().createUser(withEmail: email, password: password) { auth, err in
//            if let err = err {
//                print("auth情報の保存に失敗: ", err)
//                return
//            }
//            
//            guard let uid = auth?.user.uid else { return }
//            print("auth情報の保存に成功: ", uid)
//            self.setUserDataToFirestore(email: email, uid: uid)
//        }
//    }
//    
//    //firestoreへの保存
//    private func setUserDataToFirestore(email: String, uid: String) {
//        guard let name = nameTextField.text else { return }
//        
//        let document = [
//            "name" : name,
//            "email" : email,
//            "createdAt" : Timestamp()
//        ] as [String : Any]
//        
//        Firestore.firestore().collection("users").document(uid).setData(document){ err in
//            
//            if let err = err {
//                print("ユーザー情報のfirestoreへの保存が失敗: ",err)
//                return
//            }
//            
//            print("ユーザー情報のfirestoreへの保存が成功")
//        }
//    }
}
