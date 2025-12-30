//
//  AddView.swift
//  TodoList
//
//  Created by Youssef Mohamed on 21/12/2025.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: CoreDataViewModel
    @State private var textFieldString: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Add a new item", text: $textFieldString)
                    .padding(10)
                    .frame(height: 55)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                
                Button {
                    if textFieldString.count <= 2 {
                        showAlert.toggle()
                        alertTitle = "Please enter at least 3 characters"
                    }
                    else {
                        viewModel.addItem(title: textFieldString)
                        presentationMode.wrappedValue.dismiss() // Go back one view
                    }
                } label: {
                    Text("Save".uppercased())
                        .foregroundStyle(Color(.white))
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.accent)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
                
        }
        .navigationTitle("Add an Item 🖋️")
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle))
        }
    }
}

#Preview {
    NavigationView {
        AddView()
    }.environmentObject(CoreDataViewModel())
}
