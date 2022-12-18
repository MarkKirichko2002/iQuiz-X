//
//  ProfileViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 09.10.2022.
//
import Foundation
import RxSwift
import RxCocoa
import Firebase

class ProfileViewModel {
    
    var user = PublishSubject<Profile>()
    private var fbManager = FBManager()
    
    func GetProfileData() {
        fbManager.LoadProfileInfo { profile in
            self.user.onNext(profile)
        }
    }
}
