//
//  QuizMediaLibraryTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.10.2022.
//

import UIKit

final class QuizMediaLibraryTableViewController: UITableViewController {
    
    private let categories = [QuizMediaLibraryModel(title: "астрономия", icon: "astronomy.png", music: "space music.mp3", sound: "space.wav", background: "earth.background.jpeg"), QuizMediaLibraryModel(title: "история", icon: "history.jpeg", music: "history music.mp3", sound: "history.wav", background: "history.background.jpeg"), QuizMediaLibraryModel(title: "анатомия", icon: "anatomy.jpeg", music: "anatomy music.mp3", sound: "anatomy.mp3", background: "anatomy.background.jpeg"),QuizMediaLibraryModel(title: "спорт", icon: "sport.jpeg", music: "sport music.mp3", sound: "sport.wav", background: "sport.background.jpeg"),QuizMediaLibraryModel(title: "игры", icon: "games.jpeg", music: "games music.mp3", sound: "games.mp3", background: "games.background.jpeg"), QuizMediaLibraryModel(title: "IQ", icon: "IQ.jpeg", music: "IQ music.mp3", sound: "IQ.mp3", background: "IQ.background.jpeg"), QuizMediaLibraryModel(title: "экономика", icon: "economy.jpeg", music: "economy music.mp3", sound: "economics.mp3", background: "economy.background.jpeg"), QuizMediaLibraryModel(title: "география", icon: "geography.jpeg", music: "geography music.mp3", sound: "geography.mp3", background: "geography.background.jpeg"),QuizMediaLibraryModel(title: "экология", icon: "ecology.jpeg", music: "ecology music.mp3", sound: "ecology.wav", background: "ecology.background.jpeg"), QuizMediaLibraryModel(title: "физика", icon: "physics.jpeg", music: "physics music.mp3", sound: "physics.mp3", background: "physics.background.jpeg"), QuizMediaLibraryModel(title: "химия", icon: "chemistry.jpeg", music: "chemistry music.mp3", sound: "chemistry.mp3", background: "chemistry.background.jpeg"), QuizMediaLibraryModel(title: "информатика", icon: "informatics.jpeg", music: "informatics music.mp3", sound: "informatics.mp3", background: "informatics.background.jpeg"), QuizMediaLibraryModel(title: "литература", icon: "literature.jpeg", music: "literature music.mp3", sound: "literature.mp3", background: "literature.background.jpeg"), QuizMediaLibraryModel(title: "Swift", icon: "swift.jpeg", music: "Swift music.mp3", sound: "swift.mp3", background: "swift.background.jpeg"), QuizMediaLibraryModel(title: "подводный мир", icon: "underwater.png", music: "underwater music.mp3", sound: "underwater.wav", background: "underwater.background.jpeg"), QuizMediaLibraryModel(title: "шахматы", icon: "chess.png", music: "chess music.mp3", sound: "chess.mp3", background: "chess.background.jpeg"), QuizMediaLibraryModel(title: "хэллоуин", icon: "halloween.png", music: "halloween music.mp3", sound: "halloween.wav", background: "halloween.background.jpeg"), QuizMediaLibraryModel(title: "новый год", icon: "newyear.png", music: "newyear music.mp3", sound: "newyear.mp3", background: "newyear.background.jpeg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: QuizMediaLibraryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: QuizMediaLibraryTableViewCell.identifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizMediaLibraryTableViewCell.identifier, for: indexPath) as! QuizMediaLibraryTableViewCell
        
        cell.configure(medialibrary: categories[indexPath.row])
        
        return cell
    }
}
