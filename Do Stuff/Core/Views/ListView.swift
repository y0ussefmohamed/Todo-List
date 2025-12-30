//
//  ListView.swift
//  TodoList
//
//  Created by Youssef Mohamed on 21/12/2025.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var viewModel: CoreDataViewModel

    var body: some View {
        ZStack {
            if(viewModel.savedItems.isEmpty) {
                EmptyListView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }
            else {
                List {
                    ForEach(viewModel.savedItems, id: \.self) { item in
                        ListRowView(item: item)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                    .onMove(perform: viewModel.moveItem)
                }
            }
        }.navigationTitle("Todo List 📝")
            .navigationBarItems(
                leading: viewModel.savedItems.isEmpty ? nil : EditButton(),
                trailing: NavigationLink("Add", destination: AddView()))
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(CoreDataViewModel())
}
