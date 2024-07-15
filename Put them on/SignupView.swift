//
//  SignupView.swift
//  Put them on
//
//  Created by Daniel Cho on 7/2/24.
//

import SwiftUI
import Combine
import Firebase

fileprivate enum FocusableField: Hashable {
    case username, email, password, confirmPassword
}

struct SignupView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState fileprivate var focus: FocusableField?
    @State private var showingImagePicker = false

    private func signUpWithEmailPassword() {
        Task {
            if await viewModel.signUpWithEmailPassword() == true {
                dismiss()
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    Image("SignUp")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: geometry.size.height * 0.3)
                    
                    Text("Profile")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Profile Picture Section
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        if let image = viewModel.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $viewModel.profileImage)
                    }

                    VStack(spacing: 15) {
                        InputField(icon: "person", placeholder: "Username", text: $viewModel.username, focusField: $focus, field: .username)
                        InputField(icon: "at", placeholder: "Email", text: $viewModel.email, focusField: $focus, field: .email)
                        InputField(icon: "lock", placeholder: "Password", text: $viewModel.password, isSecure: true, focusField: $focus, field: .password)
                        InputField(icon: "lock", placeholder: "Confirm password", text: $viewModel.confirmPassword, isSecure: true, focusField: $focus, field: .confirmPassword)
                    }

                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color(UIColor.systemRed))
                            .padding(.top, 5)
                    }

                    Button(action: signUpWithEmailPassword) {
                        if viewModel.authenticationState != .authenticating {
                            Text("Sign up")
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        } else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .disabled(!viewModel.isValid)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)

                    HStack {
                        Text("Already have an account?")
                        Button(action: { viewModel.switchFlow() }) {
                            Text("Log in")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding()
                .frame(minHeight: geometry.size.height)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

fileprivate struct InputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    @FocusState.Binding var focusField: FocusableField?
    let field: FocusableField

    var body: some View {
        HStack {
            Image(systemName: icon)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .focused($focusField, equals: field)
                    .submitLabel(.next)
                    .onSubmit {
                        switch field {
                        case .username: focusField = .email
                        case .email: focusField = .password
                        case .password: focusField = .confirmPassword
                        case .confirmPassword: break // Handle sign up action
                        }
                    }
            } else {
                TextField(placeholder, text: $text)
                    .focused($focusField, equals: field)
                    .submitLabel(.next)
                    .onSubmit {
                        switch field {
                        case .username: focusField = .email
                        case .email: focusField = .password
                        case .password: focusField = .confirmPassword
                        case .confirmPassword: break // Handle sign up action
                        }
                    }
            }
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 4)
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignupView()
            SignupView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(AuthenticationViewModel())
    }
}
