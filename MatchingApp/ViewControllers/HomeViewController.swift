//
//  HomeViewController.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/10.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let registerController = RegisterViewController()
            registerController.modalPresentationStyle = .fullScreen //フルスクリーン遷移
            self.present(registerController, animated: true) //まずは登録画面へ遷移
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let topControlView = TopControlView()
        let cardView = CardView()
        let bottomControlView = BottomControlView()
        
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

}

