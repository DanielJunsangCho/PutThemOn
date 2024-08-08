//
//  ContentView.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spotify()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
        .environmentObject(AuthenticationViewModel())
    }
  }
}
