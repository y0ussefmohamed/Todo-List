//
//  ListViewModel.swift
//  TodoList
//
//  Created by Youssef Mohamed on 21/12/2025.
//

import Foundation
import Combine
import SwiftUI


/// Was used before using the CoreDataViewModel
class ListViewModel: ObservableObject {
    @Published var items: [Item] = [] {
        didSet { // called anytime we change the items array
            saveItems()
        }
    }
    
    let itemsKey = "items_list"
    
    init() {
        getItemsFromUD()
    }
    
    func getItemsFromUD() {
        guard
            let savedData = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([Item].self, from: savedData)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(src: IndexSet, dest: Int) {
        items.move(fromOffsets: src, toOffset: dest)
    }
    
    func addItem(title: String) {
        items.append(Item(title: title, isDone: false))
    }
    
    func updateItem(_ item: Item) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

