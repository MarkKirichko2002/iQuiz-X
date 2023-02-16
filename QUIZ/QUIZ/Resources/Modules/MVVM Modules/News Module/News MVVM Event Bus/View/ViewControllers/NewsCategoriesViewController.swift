//
//  NewsCategoriesViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.01.2023.
//

import UIKit

final class NewsCategoriesViewController: UIViewController {
    
    private var newsListViewModel = NewsListViewModel()
    private let categories = [NewsCategoryModel(id: 1, name: "главное", icon: "newspaper", sound: "literature.mp3"), NewsCategoryModel(id: 2, name: "технологии", icon: "technology", sound: "technology.wav"), NewsCategoryModel(id: 3, name: "спорт", icon: "sport.jpeg", sound: "sport.mp3"),NewsCategoryModel(id: 4, name: "бизнес", icon: "business", sound: "economics.mp3"), NewsCategoryModel(id: 5, name: "наука", icon: "science", sound: "chemistry.mp3")]
    private var category: NewsCategoryModel?
    private let animation = AnimationClass()
    private let player = SoundClass()
    
    private let NewsCategoryIcon: RoundedImageView = {
        let icon = RoundedImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()

    private let NewsCategoryName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let NewsCategoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let SelectNewsCategoryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        button.setTitle("выбрать категорию", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsCategoryPicker.delegate = self
        NewsCategoryPicker.dataSource = self
        view.addSubviews(NewsCategoryIcon, NewsCategoryName, NewsCategoryPicker, SelectNewsCategoryButton)
        SetUpConstraints()
        SelectNewsCategoryButton.addTarget(self, action: #selector(SelectNewsCategory), for: .touchUpInside)
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            
            NewsCategoryIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            NewsCategoryIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            NewsCategoryIcon.widthAnchor.constraint(equalToConstant: 120),
            NewsCategoryIcon.heightAnchor.constraint(equalToConstant: 120),
            
            NewsCategoryName.topAnchor.constraint(equalTo: NewsCategoryIcon.bottomAnchor, constant: 20),
            NewsCategoryName.leadingAnchor.constraint(equalTo: NewsCategoryIcon.leadingAnchor),
            NewsCategoryName.trailingAnchor.constraint(equalTo: NewsCategoryIcon.trailingAnchor),
            NewsCategoryName.heightAnchor.constraint(equalToConstant: 30),
            
            NewsCategoryPicker.topAnchor.constraint(equalTo: view.topAnchor),
            NewsCategoryPicker.leftAnchor.constraint(equalTo: NewsCategoryIcon.leftAnchor, constant: 100),
            
            SelectNewsCategoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            SelectNewsCategoryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            SelectNewsCategoryButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc private func SelectNewsCategory() {
        if let category = self.category {
            animation.springButton(button: self.SelectNewsCategoryButton)
            animation.springImage(image: self.NewsCategoryIcon)
            animation.springLabel(label: self.NewsCategoryName)
            newsListViewModel.CurrentCategory(category: category)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            animation.springButton(button: self.SelectNewsCategoryButton)
        }
    }
}

extension NewsCategoriesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
        return categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NewsCategoryIcon.image = UIImage(named: categories[row].icon)
        NewsCategoryIcon.sound = categories[row].sound
        NewsCategoryName.text = categories[row].name.capitalized
        animation.springImage(image: self.NewsCategoryIcon)
        animation.springLabel(label: self.NewsCategoryName)
        player.PlaySound(resource: categories[row].sound)
        category = categories[row]
    }
}
