//
//  VoiceCommandsTableViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 03.01.2023.
//

import UIKit
import Combine

class VoiceCommandsTableViewController: UITableViewController {
    
    private var voiceCommandViewModel = VoiceCommandViewModel()
    private var cancellation: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: VoiceCommandTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: VoiceCommandTableViewCell.identifier)
        voiceCommandViewModel.$commands.sink { [weak self] category in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellation)
        self.voiceCommandViewModel.GetVoiceCommands()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return voiceCommandViewModel.commands.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voiceCommandViewModel.commands[section].commands.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .black
            headerView.textLabel?.textColor = .white
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.text = voiceCommandViewModel.commands[section].name
        view.addSubview(lbl)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VoiceCommandTableViewCell.identifier, for: indexPath) as? VoiceCommandTableViewCell else {return UITableViewCell()}
        cell.configure(voicecommand: voiceCommandViewModel.commands[indexPath.section].commands[indexPath.row])
        return cell
    }
    
}
