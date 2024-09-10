//
//  SettingsComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 14/08/24.
//

import SwiftUI

/// Enum representing the type of trailing content in the settings component.
enum TrailingType {
    case toggleButton
    case details
}

/// A reusable SwiftUI component for displaying a settings option with either a toggle button or details view.
struct SettingsComponent: View {
    @State private var showHealthAlert = false
    @State var hapticManager = HapticManager.instance
    @State var audioManager = AudioManager.instance
    
    var trailingType: TrailingType
    
    /// The title displayed next to the circle.
    var title: String
    
    /// The labels for the toggle or details section.
    var labels: [String]
    
    /// The color of the circle next to the title.
    var color: Color

    
    var body: some View {
        VStack(spacing: 16) {
            // Header section with a colored circle and title
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.typography(.label))
                    .foregroundStyle(Color.tibbyBaseBlack)
                Spacer()
            }
            VStack(spacing: 0) {
                // Trailing content: iterate over labels and display the appropriate content
                ForEach(labels, id: \.self) { label in
                    HStack {
                        if trailingType == .details {
                            HStack {
                                Text(label)
                                    .font(.typography(.body2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 0))
                                Spacer()
                                HStack(alignment: .firstTextBaseline) {
                                    Text("Detail")
                                        .font(.body)
                                    Image(systemName: "chevron.right")
                                        .font(.body)
                                        .fontWeight(.bold)
                                }
                                .foregroundStyle(.tibbyBaseGrey)
                                .padding(.trailing, 24)
                            }
                        } else {
                            switch label {
                            case "Music":
                                Toggle(label, isOn: $audioManager.music)
                                    .font(.typography(.body2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                            case "Sound Effects":
                                Toggle(label, isOn: $audioManager.sfx)
                                    .font(.typography(.body2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                            case "Phone Vibrations":
                                Toggle(label, isOn: $hapticManager.vibration)
                                    .font(.typography(.body2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                            default:
                                EmptyView()
                            }
                        }
                    }
                    .onTapGesture {
                        if label == "Health" {
                            showHealthAlert = true
                        } else if label == "Notifications" {
                            print("Notification")
                        }
                    }
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.tibbyBasePearlBlue)
            }
        }
        .alert("How to allow?", isPresented: $showHealthAlert) {
            Button("Open Settings") {
                openSettings()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please go to Settings and allow the necessary permissions.")
        }
    }
    
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

