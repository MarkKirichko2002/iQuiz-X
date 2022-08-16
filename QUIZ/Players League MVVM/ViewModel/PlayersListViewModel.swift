//
//  PlayerViewModel.swift
//  QUIZ
//
//  Created by Марк Киричко on 02.07.2022.
//

import Foundation

struct PlayersListViewModel {
    var players: PlayerObserver<[PlayersTableViewCellViewModel]> = PlayerObserver([])
}

