//
//  TodayTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 24.03.2022.
//

import UIKit
import SCLAlertView

final class TodayTableViewController: UITableViewController {

    @IBOutlet weak var InfoCategoriesButton: UIBarButtonItem!
    
    var todays = TodayStorage.shared.todays
    
    var player = SoundClass()
    
    func CurrentDate() {
        let date = Date()
        let calendar = Calendar.current
        
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
            
            case 1:
            navigationItem.title = "Сегодня Воскресенье"
            
            case 2:
            navigationItem.title = "Сегодня Понедельник"
            
            case 3:
            navigationItem.title = "Сегодня Вторник"
            
            case 4:
            navigationItem.title = "Сегодня Среда"
            
            case 5:
            navigationItem.title = "Сегодня Четверг"
            
            case 6:
            navigationItem.title = "Сегодня Пятница"
            
            case 7:
            navigationItem.title = "Сегодня Cуббота"
            
            
        default:
            break
        }
    }
 
    
    @IBAction func ShowTodayInfo() {
        player.Sound(resource: "future click sound.wav")
        SCLAlertView().showInfo("О разделе \"Сегодня\"", subTitle: "В данном разделе есть информация на сегодняшний день")
    }
    
    override func viewDidLoad() {
        CurrentDate()
        super.viewDidLoad()
        print(todays.count)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todays.count
    }
    
    func PresentWeather(){
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "WeatherViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
       }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player.Sound(resource: "selected sound.wav")
        switch(indexPath.row) {
            case 0:  PresentWeather()
            default: break
        }
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodayTableViewCell.identifier, for: indexPath) as! TodayTableViewCell
        
        cell.configure(todays[indexPath.row])
        
        
        return cell
    }
    
}

