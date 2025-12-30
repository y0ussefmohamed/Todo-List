//
//  TodoListApp.swift
//  TodoList
//
//  Created by Youssef Mohamed on 21/12/2025.
//

import SwiftUI

@main
struct TodoListApp: App {
    @StateObject var viewModel: CoreDataViewModel = CoreDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
        }
        .environmentObject(viewModel)
    }
}
