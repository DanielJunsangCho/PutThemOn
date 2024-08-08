//
//  Spotify.swift
//  Put them on
//
//  Created by Harris Musungu on 8/8/24.
//

import UIKit
import SwiftUI

struct Spotify: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    Spotify()
}
