//
//  Models.swift
//  Put them on
//
//  Created by Harris Musungu on 7/1/24.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

struct Song: Identifiable {
    let id: UUID
    let title: String
    let artist: String
    let user: User

    init(id: UUID = UUID(), title: String, artist: String, user: User) {
        self.id = id
        self.title = title
        self.artist = artist
        self.user = user
    }
}
