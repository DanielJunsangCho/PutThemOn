//
//  DiscoverView.swift
//  Put them on
//
//  Created by Harris Musungu on 7/1/24.
//

import SwiftUI

struct DiscoverView: View {
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
            loadDiscoverSongs()
        }
        .navigationTitle("Discover")
    }

    func loadDiscoverSongs() {
        // Load the discover songs (friends of friends' songs)
        // Placeholder data
        let user3 = User(name: "Charlie")
        let user4 = User(name: "Dave")
        self.songs = [
            Song(title: "Song C", artist: "Artist C", user: user3),
            Song(title: "Song D", artist: "Artist D", user: user4)
        ]
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
