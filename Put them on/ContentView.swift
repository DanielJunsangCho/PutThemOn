//
//  ContentView.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.65))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text:$username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongUsername))
                    // SecureField hides the password. Could add functionality for show/hide
                    SecureField("Password", text:$password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongUsername))
                    Button("Login") {
                        //need to add functionality to authenticate user
                        path.append("LoginView")
                    }
                    .foregroundColor(.white)
                    .frame(width:300, height:50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationDestination(for: String.self) { string in
                if string == "LoginView" {
                    LoginView(username: $username)
                }
            }
        }
        .navigationBarHidden(true)

    }
    //obviously super limited to one user. will have to create a signup for this.
    func authenticateUser(username: String, password: String) {
        
    }
}

struct LoginView: View {
    @Environment(\.isPresented) private var isPresented
    @Binding var username: String

    var body: some View {
        VStack {
            Text("You are logged in @\(username)")

        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
