//
//  NewsCategoriesViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 06.01.2023.
//

import UIKit

class NewsCategoriesViewController: UIViewController {
    
    private var newsListViewModel = NewsListViewModel()
    private let categories = [NewsCategoryModel(id: 1, name: "главное", icon: "newspaper", sound: "literature.mp3"), NewsCategoryModel(id: 2, name: "технологии", icon: "technology", sound: "technology.wav"), NewsCategoryModel(id: 3, name: "спорт", icon: "sport", sound: "sport.mp3"),NewsCategoryModel(id: 4, name: "бизнес", icon: "business", sound: "economics.mp3"), NewsCategoryModel(id: 5, name: "наука", icon: "science", sound: "chemistry.mp3")]
    private var category: NewsCategoryModel?
    private let animation = AnimationClass()
    private let player = SoundClass()
    @IBOutlet weak var CategoryIcon: RoundedImageView!
    @IBOutlet weak var CategoryName: UILabel!
    @IBOutlet weak var CategoryPicker: UIPickerView!
    @IBOutlet weak var SelectCategoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryPicker.delegate = self
        CategoryPicker.dataSource = self
    }
    
    @IBAction func SelectCategory() {
        if let category = self.category {
            animation.springButton(button: self.SelectCategoryButton)
            animation.springImage(image: self.CategoryIcon)
            animation.springLabel(label: self.CategoryName)
            newsListViewModel.CurrentCategory(category: category)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            animation.springButton(button: self.SelectCategoryButton)
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
        CategoryIcon.image = UIImage(named: categories[row].icon)
        CategoryIcon.sound = categories[row].sound
        CategoryName.text = categories[row].name.capitalized
        animation.springImage(image: self.CategoryIcon)
        animation.springLabel(label: self.CategoryName)
        player.PlaySound(resource: categories[row].sound)
        category = categories[row]
    }
}
