//
//  EditItemView.swift
//  TodoList
//
//  Created by Youssef Mohamed on 24/12/2025.
//


import SwiftUI
import CoreData

struct EditItemView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: CoreDataViewModel
    var item: ItemEntity
    
    @State private var newTitle: String = ""

    var body: some View {
        Form {
            Section(header: Text("New Title")) {
                TextField("Edit title", text: $newTitle)
            }
            
            Section {
                Button {
                    viewModel.updateItem(item: item,  newTitle: newTitle)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .listRowBackground(Color.accent)
                .disabled(newTitle.isEmpty)
            }
        }
        .navigationTitle("Edit Item ✍🏽")
        .onAppear {
            newTitle = item.title ?? ""
        }
    }
}

#Preview {
    // 1. Create a temporary in-memory Core Data stack
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "ItemsContainer") // Make sure this matches your Data Model name
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { _, _ in }
        return container.viewContext
    }()
    
    // 2. Create the dummy item
    let newItem = ItemEntity(context: context)
    newItem.title = "Buy Groceries"
    newItem.isDone = false
    
    // 3. Return the view with the ViewModel
    return EditItemView(item: newItem)
        .environmentObject(CoreDataViewModel())
}
