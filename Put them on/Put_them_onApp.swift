//
//  Put_them_onApp.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@main
struct Put_them_onApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AuthenticatedView(unauthenticated: LoginView()) {
                FeedView()
            }
            .environmentObject(authViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
