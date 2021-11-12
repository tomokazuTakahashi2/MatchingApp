//
//  RegisterViewModel.swift
//  MatchingApp
//
//  Created by 高橋智一 on 2021/11/12.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelInputs {
    var nameTextInput: AnyObserver<String> { get }
    var emailTextInput: AnyObserver<String> { get }
    var passwordTextInput: AnyObserver<String> { get }
}

protocol RegisterViewModelOutputs {
    var nameTextOutput: PublishSubject<String> { get }
    var emailTextOutput: PublishSubject<String> { get }
    var passwordTextOutput: PublishSubject<String> { get }
}

class RegisterViewModel: RegisterViewModelInputs, RegisterViewModelOutputs {
    
    private let disposeBag = DisposeBag()
    
    //MARK: observable
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
    
    //MARK: observer (viewControllerから入ってくる)
    var nameTextInput: AnyObserver<String> {
        nameTextOutput.asObserver()
    }
    
    var emailTextInput: AnyObserver<String> {
        emailTextOutput.asObserver()
    }
    
    var passwordTextInput: AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    
    var validRegisterDriver: Driver<Bool> = Driver.never()
    
    init() {
        
        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
        //3文字以上だったらOK
        let nameValid = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 3
            }
        
        //５文字以上だったらOK
        let emailValid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        
        //６文字じゃないとダメ
        let passwordValid = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count == 6
            }
        
//        nameTextOutput
//            .asObservable()
//            .subscribe { text in
//                print("name: ", text)
//            }
//            .disposed(by: disposeBag)
//
//        emailTextOutput
//            .asObservable()
//            .subscribe { text in
//                print("email: ", text)
//            }
//            .disposed(by: disposeBag)
//
//        passwordTextOutput
//            .asObservable()
//            .subscribe { text in
//                print("password: ", text)
//            }
//            .disposed(by: disposeBag)
        
        Observable.combineLatest(nameValid, emailValid, passwordValid){ $0 && $1 && $2 }
            .subscribe { validAll in
                self.validRegisterSubject.onNext(validAll)
            }
            .disposed(by: disposeBag)
    }
}
