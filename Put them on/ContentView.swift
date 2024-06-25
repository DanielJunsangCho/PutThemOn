//
//  ContentView.swift
//  Put them on
//
//  Created by Daniel Cho on 6/16/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var path = NavigationPath()
    @State private var isSignedIn = false

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.65))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text:$username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongUsername))
                    SecureField("Password", text:$password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongUsername))
                    Button("Login") {
                        path.append("LoginView")
                    }
                    .foregroundColor(.white)
                    .frame(width:300, height:50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    SignInWithGoogleButton()
                        .onTapGesture {
                            print("Google Sign-In button tapped")
                            signInWithGoogle()
                        }
                        .frame(width: 300, height: 50)
                }
            }
            .navigationDestination(for: String.self) { string in
                if string == "LoginView" {
                    LoginView(username: $username)
                }
            }
        }
        .navigationBarHidden(true)
    }

    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Failed to get clientID from Firebase app options")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            if let error = error {
                print("Error during sign-in: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {
                print("Failed to get GIDGoogleUser from result")
                return
            }
            
            let idToken = user.idToken!.tokenString
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error during Firebase sign-in: \(error.localizedDescription)")
                    return
                }
                
                // User is signed in
                isSignedIn = true
                print("User is signed in")
                path.append("LoginView")
            }
        }
    }

    func getRootViewController() -> UIViewController {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return UIViewController()
        }
        return window.rootViewController ?? UIViewController()
    }
}

struct SignInWithGoogleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        return GIDSignInButton()
    }

    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
}

struct LoginView: View {
    @Environment(\.isPresented) private var isPresented
    @Binding var username: String

    var body: some View {
        VStack {
            Text("You are logged in @\(username)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
