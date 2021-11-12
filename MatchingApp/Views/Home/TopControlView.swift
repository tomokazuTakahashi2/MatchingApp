//
//  TopControlView.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/11.
//

import UIKit
import RxCocoa
import RxSwift

private let disposeBag = DisposeBag()

class TopControlView: UIView {
    
    let tinderButton = createTopButton(imageName: "tinder-selected", unselectedImage: "tinder-unselected")
    let goodButton = createTopButton(imageName: "good-selected", unselectedImage: "good-unselected")
    let commentButton = createTopButton(imageName: "comment-selected", unselectedImage: "comment-unselected")
    let profileButton = createTopButton(imageName: "profile-selected", unselectedImage: "profile-unselected")
    
    static private func createTopButton(imageName: String, unselectedImage: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .selected)
        button.setImage(UIImage(named: unselectedImage), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupBindings()
    }
    
    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 43
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 40, rightPadding: 40)
        //↑に替わる
//        [baseStackView.topAnchor.constraint(equalTo: topAnchor),
//         baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//         baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
//         baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
//        ].forEach { $0.isActive = true }
        
        //最初はtinderButtonが選択されている
        tinderButton.isSelected = true
    }
    
    private func setupBindings() {
        
        tinderButton.rx.tap
            .asDriver()
            .drive (onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.tinderButton)
            })
            .disposed(by: disposeBag)
        
        goodButton.rx.tap
            .asDriver()
            .drive (onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.goodButton)
            })
            .disposed(by: disposeBag)
        
        commentButton.rx.tap
            .asDriver()
            .drive (onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.commentButton)
            })
            .disposed(by: disposeBag)
        
        profileButton.rx.tap
            .asDriver()
            .drive (onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.profileButton)
            })
            .disposed(by: disposeBag)
        //↑に替わる
//        tinderButton.rx.tap.subscribe { _ in
//            self.handleSelectedButton(selectedButton: self.tinderButton)
//        }
//        .disposed(by: disposeBag)
//
//        goodButton.rx.tap.subscribe { _ in
//            self.handleSelectedButton(selectedButton: self.goodButton)
//        }
//        .disposed(by: disposeBag)
//
//        commentButton.rx.tap.subscribe { _ in
//            self.handleSelectedButton(selectedButton: self.commentButton)
//        }
//        .disposed(by: disposeBag)
//
//        profileButton.rx.tap.subscribe { _ in
//            self.handleSelectedButton(selectedButton: self.profileButton)
//        }
//        .disposed(by: disposeBag)
    }
    
    //ボタンのON/OFF
    private func handleSelectedButton(selectedButton: UIButton) {
        let buttons = [tinderButton, goodButton, commentButton, profileButton]
        
        buttons.forEach { button in
            if button == selectedButton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
