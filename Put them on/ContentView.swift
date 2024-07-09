//
//  ContentView.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

//import SwiftUI
//import SwiftData
//
//struct ContentView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @Environment(\.dismiss) var dismiss
//    @State private var path = NavigationPath()
//    @State private var isAuthenticated = false
//    @EnvironmentObject var authViewModel: AuthenticationViewModel
//    
//    var body: some View {
//        NavigationStack(path: $path) {
//            Button(action: signInWithGoogle) {
//                HStack {
//                    Image("Google")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24, alignment: .center)
//                    Text("Sign in with Google")
//                        .foregroundStyle(colorScheme == .dark ? .white : .black)
//                        .padding(.leading, 20)
//                }
//                .padding(.horizontal, 50)
//                .padding(.vertical, 8)
//            }
//            .buttonStyle(.bordered)
//            .cornerRadius(100)
////        }
//        .onChange(of: isAuthenticated) { oldValue, newValue in
//            if newValue {
//                print("Successfully authenticated")
//            }
//        }
//    }
//    
//    private func signInWithGoogle() {
//        print("Sign in button tapped")
//         Task {
//             do {
//                 isAuthenticated =  await authViewModel.signInWithGoogle()
//                 print("Authentication result: \(isAuthenticated)")
//             }
//         }
//     }
//}
//
//
//
//
//struct LoginView_Previews: PreviewProvider {
//  static var previews: some View {
//    Group {
//      ContentView()
//        .environmentObject(AuthenticationViewModel())
//    }
//  }
//}
