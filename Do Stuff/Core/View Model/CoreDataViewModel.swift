//
//  CoreDataViewModel.swift
//  TodoList
//
//  Created by Youssef Mohamed on 24/12/2025.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedItems: [ItemEntity] = []
    
    init() {
        self.container = NSPersistentContainer(name: "ItemsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Successfully loaded Core Data")
                self.fetchItems()
            }
        }
    }
    
   
    func fetchItems() {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        
        do {
            savedItems = try container.viewContext.fetch(request)
        } catch let error {
            print("Failed to fetch fruits: \(error)")
        }
    }
    
    func addItem(title: String) {
        let newItem = ItemEntity(context: container.viewContext)
        newItem.title = title
        newItem.isDone = false
        
        saveData()
    }
    
    func toggleItemDone(item: ItemEntity) {
        item.isDone.toggle()
        
        saveData()
    }
    
    func updateItem(item: ItemEntity, newTitle: String) {
        item.title = newTitle
        item.isDone = item.isDone
        
        saveData()
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let indexToDelete = indexSet.first else { return }
        let itemToDelete = savedItems[indexToDelete]
        container.viewContext.delete(itemToDelete)
        
        saveData()
    }
    
    func saveData() -> Void {
        do {
           try container.viewContext.save()
            fetchItems() // New List
        } catch let error {
            print("Failed to save data: \(error)")
        }
    }
    
    
    // MARK: - For UI (List)
    func moveItem(src: IndexSet, dest: Int) {
        savedItems.move(fromOffsets: src, toOffset: dest)
    }
}
