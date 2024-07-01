//
//  FriendsView.swift
//  Put them on
//
//  Created by Harris Musungu on 7/1/24.
//

import SwiftUI

struct FriendsView: View {
    @State private var songs: [Song] = []

    var body: some View {
        List(songs) { song in
            VStack(alignment: .leading) {
                Text(song.title)
                    .font(.headline)
                Text("by \(song.artist)")
                    .font(.subheadline)
                Text("Posted by \(song.user.name)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Button(action: {
                    // Handle play song
                }) {
                    Image(systemName: "play.circle.fill")
                }
            }
            .padding()
        }
        .onAppear {
            loadFriendsSongs()
        }
        .navigationTitle("Friends")
    }

    func loadFriendsSongs() {
        // Load the friends' songs
        // Placeholder data
        let user1 = User(name: "Alice")
        let user2 = User(name: "Bob")
        self.songs = [
            Song(title: "Song A", artist: "Artist A", user: user1),
            Song(title: "Song B", artist: "Artist B", user: user2)
        ]
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
