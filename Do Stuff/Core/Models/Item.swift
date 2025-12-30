//
//  Item.swift
//  TodoList
//
//  Created by Youssef Mohamed on 21/12/2025.
//

import Foundation


/// Was used before using the CoreData ItemEntity
struct Item: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let isDone: Bool
    
    init(id: String = UUID().uuidString, title: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
    
    func updateCompletion() -> Item {
        return Item(id: id, title: title, isDone: !isDone)
    }
}
