//
//  Bus.swift
//  QUIZ
//
//  Created by Марк Киричко on 17.08.2022.
//

import Foundation

final class Bus {
    static let shared = Bus()
    
    private init() {}
    
    enum EventType {
        case newsFetch
    }
    
    struct Subscription {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[Article]>)-> Void)
    }
    
    private var subscriptions = [Subscription]()
    
    // Subscriptions
    
    func subscribe(_ event: EventType, block: @escaping((Event<[Article]>)->Void)) {
        let new = Subscription(type: event,
                               queue: .global(),
                               block: block)
        subscriptions.append(new)
    }
    
    func subscribeOnMain(_ event: EventType, block: @escaping((Event<[Article]>)->Void)) {
        let new = Subscription(type: event,
                               queue: .main,
                               block: block)
        subscriptions.append(new)
    }
    
    // Publications
    
    func publish(type: EventType, event: NewsFetchEvent) {
        let subscribers = subscriptions.filter({$0.type == type})
        subscriptions.forEach { subsriber in
            subsriber.queue.async {
                subsriber.block(event)
            }
        }
    }
}
