//
//  EmptyListView.swift
//  TodoList
//
//  Created by Youssef Mohamed on 21/12/2025.
//

import SwiftUI

struct EmptyListView: View {
    @State private var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no Items!")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Are you a productive person? I think you should click the add buttton and add a bunch of items to you todo list!")
                    .padding(.bottom, 20)
                    
                
                NavigationLink(destination: AddView()) {
                    Text("Add Something 🥳")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondaryAccentColor : .accentColor)
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : .accentColor.opacity(0.7),
                        radius: 10,
                        x: 0, y: animate ? 30 : 20)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }
        
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(Animation
                .easeInOut(duration: 2.0)
                .repeatForever()) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationView {
        EmptyListView()
    }
}
