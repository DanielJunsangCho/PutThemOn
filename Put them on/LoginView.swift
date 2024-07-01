//
//  LoginView.swift
//  Put them on
//
//  Created by Harris Musungu on 7/1/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var isSignedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var loginError = ""

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 20)

            if !loginError.isEmpty {
                Text(loginError)
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            Button(action: {
                loginUser()
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.top, 20)

            NavigationLink(destination: SignUpView(isSignedIn: $isSignedIn)) {
                Text("Don't have an account? Sign up")
                    .foregroundColor(.blue)
                    .padding(.top, 10)
            }
        }
        .padding()
    }

    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.loginError = error.localizedDescription
                return
            }
            self.isSignedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isSignedIn: .constant(false))
    }
}
