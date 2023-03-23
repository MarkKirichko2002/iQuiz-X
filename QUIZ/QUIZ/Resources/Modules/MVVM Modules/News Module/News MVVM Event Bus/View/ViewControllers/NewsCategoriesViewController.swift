//
//  NewsCategoriesViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.01.2023.
//

import UIKit

final class NewsCategoriesViewController: UIViewController {
    
    private var newsListViewModel = NewsListViewModel()
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
            animation.SpringAnimation(view: self.SelectNewsCategoryButton)
            animation.SpringAnimation(view: self.NewsCategoryIcon)
            animation.SpringAnimation(view: self.NewsCategoryName)
            newsListViewModel.SelectNewsCategory(category: category)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            animation.SpringAnimation(view: self.SelectNewsCategoryButton)
        }
    }
}

extension NewsCategoriesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newsListViewModel.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
        return newsListViewModel.categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NewsCategoryIcon.image = UIImage(named: newsListViewModel.categories[row].icon)
        NewsCategoryIcon.sound = newsListViewModel.categories[row].sound
        NewsCategoryName.text = newsListViewModel.categories[row].name.capitalized
        animation.SpringAnimation(view: self.NewsCategoryIcon)
        animation.SpringAnimation(view: self.NewsCategoryName)
        player.PlaySound(resource: newsListViewModel.categories[row].sound)
        category = newsListViewModel.categories[row]
    }
}
