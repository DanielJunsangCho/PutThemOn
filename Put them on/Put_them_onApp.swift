//
//  Put_them_onApp.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

import SwiftUI
import Firebase

@main
struct Put_them_onApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
