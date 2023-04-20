//
//  ContentView.swift
//  EgoiPushExample
//
//  Created by João Silva on 20/04/2023.
//

import SwiftUI
import EgoiPushLibrary

struct ContentView: View {
    @State private var tokenIdentifier: String
    private let userDefaults = UserDefaults.standard
    
    init() {
        tokenIdentifier = userDefaults.string(forKey: UserDefaultsProperties.TOKEN_IDENTIFIER) ?? ""
    }
    
    var body: some View {
        VStack {
            Text("Example")
                .font(.largeTitle)
                .bold()
            
            Button {
                LocationHandler.requestLocationAccess()
            } label: {
                Text("Request foreground location")
            }
            .padding(5)
            
            Button {
                LocationHandler.requestLocationAccessInBackground()
            } label: {
                Text("Request background location")
            }
            .padding(5)
            
            Button {
                LocationHandler.addTestRegion()
            } label: {
                Text("Add test region")
            }
            .padding(5)
            
            let textField = TextField("Token identifier...", text: $tokenIdentifier)
                .frame(width: 200)
                .multilineTextAlignment(.center)
            
            if #available(iOS 15.0, *) {
                textField
                    .submitLabel(.done)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .onSubmit {
                        userDefaults.set(tokenIdentifier, forKey: UserDefaultsProperties.TOKEN_IDENTIFIER)
                    }
            }
            
            Button {
                if #unavailable(iOS 15.0) {
                    userDefaults.set(tokenIdentifier, forKey: UserDefaultsProperties.TOKEN_IDENTIFIER)
                }
                
                Network().registerToken(field: "email") { result in
                    print(result)
                }
            } label: {
                Text("Register token")
            }
            .padding(5)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
