//
//  ProfileViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 09.10.2022.
//

import RxSwift
import RxCocoa
import SDWebImage
import SnapKit

class ProfileViewModel {
    
    var user = PublishSubject<Profile>()
    private var fbManager = FirebaseManager()
    private var spinner = RoundedImageView()
    private var loadingText = UILabel()
    private var animation = AnimationClass()
    var view: UIView?
    
    func GetProfileData() {
        fbManager.LoadProfileInfo { profile in
            self.user.onNext(profile)
        }
    }
    
    func ShowLoading() {
        view?.addSubview(spinner)
        loadingText.text = "загрузка профиля..."
        loadingText.font = UIFont.boldSystemFont(ofSize: 22.0)
        view?.addSubview(loadingText)
        makeConstraints()
        spinner.sd_setImage(with: URL(string: UserDefaults.standard.value(forKey: "url") as? String ?? "https://cdn-icons-png.flaticon.com/512/3637/3637624.png"))
        animation.StartRotateAnimation(view: spinner)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.GetProfileData()
            self.spinner.removeFromSuperview()
            self.loadingText.removeFromSuperview()
        }
    }
    
    private func makeConstraints() {
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        loadingText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(spinner.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.width.equalTo(220)
        }
    }
}
