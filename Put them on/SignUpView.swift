//
//  SignUpView.swift
//  Put them on
//
//  Created by Harris Musungu on 7/1/24.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @Binding var isSignedIn: Bool
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var signUpError = ""

    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .padding(.bottom, 20)

            if !signUpError.isEmpty {
                Text(signUpError)
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)

            Button(action: {
                signUpUser()
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .padding(.top, 20)

            NavigationLink(destination: LoginView(isSignedIn: $isSignedIn)) {
                Text("Already have an account? Log in")
                    .foregroundColor(.blue)
                    .padding(.top, 10)
            }
        }
        .padding()
    }

    func signUpUser() {
        guard password == confirmPassword else {
            self.signUpError = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.signUpError = error.localizedDescription
                return
            }

            // Update the user's profile with the username
            if let user = Auth.auth().currentUser {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = self.username
                changeRequest.commitChanges { error in
                    if let error = error {
                        self.signUpError = error.localizedDescription
                        return
                    }
                    self.isSignedIn = true
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isSignedIn: .constant(false))
    }
}
