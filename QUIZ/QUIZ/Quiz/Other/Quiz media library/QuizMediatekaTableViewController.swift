//
//  QuizMediaLibraryTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 08.10.2022.
//

import UIKit

class QuizMediaLibraryTableViewController: UITableViewController {

    var categories = [QuizMediaLibraryModel(title: "астрономия", icon: "planets.jpeg", music: "space music.mp3"), QuizMediaLibraryModel(title: "история", icon: "history.jpeg", music: "history music.mp3"), QuizMediaLibraryModel(title: "анатомия", icon: "anatomy.jpeg", music: "anatomy music.mp3"),QuizMediaLibraryModel(title: "спорт", icon: "sport.jpeg", music: "sport music.mp3"),QuizMediaLibraryModel(title: "игры", icon: "games.jpeg", music: "games music.mp3"), QuizMediaLibraryModel(title: "IQ", icon: "IQ.jpeg", music: "IQ music.mp3"), QuizMediaLibraryModel(title: "экономика", icon: "economy.jpeg", music: "economy music.mp3"), QuizMediaLibraryModel(title: "география", icon: "geography.jpeg", music: "geography music.mp3"),QuizMediaLibraryModel(title: "экология", icon: "ecology.jpeg", music: "ecology music.mp3"), QuizMediaLibraryModel(title: "физика", icon: "physics.jpeg", music: "physics music.mp3"), QuizMediaLibraryModel(title: "химия", icon: "chemistry.jpeg", music: "chemistry music.mp3"), QuizMediaLibraryModel(title: "информатика", icon: "informatics.jpeg", music: "informatics music.mp3"), QuizMediaLibraryModel(title: "литература", icon: "literature.jpeg", music: "literature music.mp3"), QuizMediaLibraryModel(title: "Swift", icon: "swift.jpeg", music: "Swift music.mp3"), QuizMediaLibraryModel(title: "подводный мир", icon: "underwater.png", music: "underwater music.mp3"), QuizMediaLibraryModel(title: "шахматы", icon: "chess.png", music: "chess music.mp3"), QuizMediaLibraryModel(title: "хэллоуин", icon: "halloween.png", music: "halloween music.mp3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizMediaLibraryTableViewCell.identifier, for: indexPath) as! QuizMediaLibraryTableViewCell

        cell.configure(mediateka: categories[indexPath.row])
        
        return cell
    }
}
