//
//  ListRowView.swift
//  TodoList
//
//  Created by Youssef Mohamed on 21/12/2025.
//

import SwiftUI
import CoreData

struct ListRowView: View {
    @EnvironmentObject var viewModel: CoreDataViewModel
    let item: ItemEntity
    
    @State private var animateGradient = false
    var body: some View {
        ZStack {
            NavigationLink(destination: EditItemView(item: item)) {
                EmptyView()
            }
            .opacity(0)
            
            HStack {
                Button {
                    viewModel.toggleItemDone(item: item)
                } label: {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(item.isDone ? .green : .red)
                }
                .buttonStyle(.borderless)
                
                Text(item.title ?? "")
                    .font(Font.headline)
                    .strikethrough(item.isDone, color: .gray)
                
                Spacer()
                
                Image(systemName: "pencil")
                            .font(.title3)
                            .foregroundColor(.clear)
                            .overlay {
                                LinearGradient(
                                    colors: [.accentColor, .secondary, .blue],
                                    startPoint: animateGradient ? .topLeading : .bottomTrailing,
                                    endPoint: animateGradient ? .bottomTrailing : .topLeading
                                )
                                .mask(
                                    Image(systemName: "pencil")
                                        .font(.title3)
                                )
                            }
                            .onAppear {
                                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                                    animateGradient.toggle()
                                }
                            }
            }
            .padding(.vertical, 8)
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "ItemsContainer")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { _, _ in }
        return container.viewContext
    }()
    
    // 2. Create the dummy item
    let newItem = ItemEntity(context: context)
    newItem.title = "Buy Groceries"
    newItem.isDone = false
    
    // 3. Return the view with the ViewModel
    return ListRowView(item: newItem)
        .environmentObject(CoreDataViewModel())
}
