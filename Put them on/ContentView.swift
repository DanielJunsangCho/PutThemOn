//
//  ContentView.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isSignedIn = false

    var body: some View {
        NavigationView {
            VStack {
                if isSignedIn {
                    FeedView()
                } else {
                    LoginView(isSignedIn: $isSignedIn)
                }
            }
            .onAppear {
                self.checkSignInStatus()
            }
        }
    }

    func checkSignInStatus() {
        if Auth.auth().currentUser != nil {
            self.isSignedIn = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
