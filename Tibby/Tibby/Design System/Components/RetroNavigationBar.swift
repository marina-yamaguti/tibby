//
//  SwiftUIView.swift
//  Tibby
//
//  Created by Sofia Sartori on 09/08/24.
//

import SwiftUI

/// A custom navigation bar styled with a retro theme for the Tibby app.
///
/// `RetroNavigationBar` provides a navigation bar with buttons for navigating back to the previous screen and accessing the settings screen.
struct RetroNavigationBar: View {
    /// Environment variable to control the presentation mode of the current view.
    @Environment(\.presentationMode) var presentationMode
    
    /// State variable to track whether the settings screen should be displayed.
    @State var goToSettings: Bool = false
    
    var body: some View {
        HStack {
            // Back button and label for navigating to the home screen
            backButton
            
            Spacer()
            
            // Title section with decorative dots
            titleSection
            
            Spacer()
            
            // Settings button and label
            settingsButton
                .navigationDestination(isPresented: $goToSettings, destination: {SettingsView()})
        }
        .padding(.horizontal)

    }
    
    /// The back button and label.
    private var backButton: some View {
        VStack(alignment: .leading) {
            Button(action: {presentationMode.wrappedValue.dismiss()},
                   label: {ButtonLabel(type: .tertiary, image: "", text: "")})
                .buttonTertiary()
            Text("home")
                .foregroundStyle(.tibbyBaseBlack)
                .font(.typography(.label))
                .padding(.top, 4)
        }
    }
    
    /// The title section with decorative dots and the app name.
    private var titleSection: some View {
        VStack {
            VStack {
                HStack {
                    ForEach(0..<10, id: \.self) { _ in
                        Circle()
                            .fill(.tibbyBaseGrey)
                            .frame(width: 5, height: 5)
                    }
                }
                HStack {
                    ForEach(0..<8, id: \.self) { _ in
                        Circle()
                            .fill(.tibbyBaseGrey)
                            .frame(width: 5, height: 5)
                    }
                }
            }
            Text("tibby")
                .foregroundStyle(.tibbyBaseBlack)
                .font(.typography(.headline))
                .padding(.vertical)
        }
    }
    
    /// The settings button and label.
    private var settingsButton: some View {
        VStack(alignment: .trailing) {
            Button(action: {goToSettings = true},
                   label: {ButtonLabel(type: .tertiary, image: "", text: "")})
                .buttonTertiary()
            Text("settings")
                .foregroundStyle(.tibbyBaseBlack)
                .font(.typography(.label))
                .padding(.top, 4)
        }
    }
}

#Preview {
    RetroNavigationBar()
}
