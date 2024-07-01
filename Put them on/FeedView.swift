//
//  FeedView.swift
//  Put them on
//
//  Created by Harris Musungu on 7/1/24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        VStack {
            // Top Navigation Bar
            HStack {
                Button(action: {
                    // Handle friend requests
                }) {
                    Image(systemName: "person.2.fill")
                }
                Spacer()
                Button(action: {
                    // Handle past posts
                }) {
                    Image(systemName: "square.and.pencil")
                }
                Spacer()
                Button(action: {
                    // Handle profile
                }) {
                    Image(systemName: "person.crop.circle")
                }
            }
            .padding()
            
            // TabView
            TabView {
                FriendsView()
                    .tabItem {
                        Label("Friends", systemImage: "person.2.fill")
                    }
                DiscoverView()
                    .tabItem {
                        Label("Discover", systemImage: "magnifyingglass")
                    }
            }
        }
        .navigationTitle("Feed")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
