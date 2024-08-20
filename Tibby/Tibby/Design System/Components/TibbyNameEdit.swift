//
//  TibbyNameEdit.swift
//  Tibby
//
//  Created by Marina Yamaguti on 13/08/24.
//

import SwiftUI

/// A view that allows the user to edit the name of a Tibby character.
///
/// The view displays the Tibby's name and provides an option to edit it. The name field supports editing with a character limit, and the editing state is visually indicated with an icon.
struct TibbyNameEdit: View {
    @EnvironmentObject var constants: Constants
    
    /// The Tibby object whose name is being edited.
    @Binding var tibby: Tibby
    
    /// State variable to track whether the name is currently being edited.
    @State private var isEditing: Bool = false
    
    /// State variable to store the width of the text for proper layout adjustments.
    @State private var textWidth: CGFloat = 0
    
    @FocusState private var isFocused: Bool

    
    var body: some View {
        HStack(spacing: 16) {
            nameEditView
            editIcon
        }
        .frame(height: 36) // Set a fixed height for the HStack
    }
    
    /// A view that either displays the Tibby's name as a static text or as an editable text field.
    private var nameEditView: some View {
        ZStack {
            // Hidden text to measure the width of the name
            Text(tibby.name)
                .font(.typography(.headline))
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            textWidth = geometry.size.width
                        }
                        .onChange(of: tibby.name) {
                            textWidth = geometry.size.width
                        }
                })
                .hidden()
            if isEditing {
                // Text field for editing the name
                TextField("Given Name", text: $tibby.name)
                    .disableAutocorrection(true)
                    .font(.typography(.headline))
                    .foregroundStyle(Color.tibbyBaseBlack)
                    .frame(width: textWidth)
                    .onChange(of: tibby.name) { oldValue, newValue in
                        // Limit the name length to 10 characters
                        if newValue.count > 10 {
                            tibby.name = String(newValue.prefix(10))
                        }
                    }
                    .onSubmit {
                        isEditing = false
                    }
                    .focused($isFocused)
            } else {
                // Static text displaying the name
                Text(tibby.name)
                    .font(.typography(.headline))
                    .foregroundStyle(Color.tibbyBaseBlack)
                    .frame(width: textWidth)
                    .onTapGesture {
                        isEditing = true
                    }
            }
        }
    }
    
    /// An icon that toggles between editing and viewing modes.
    private var editIcon: some View {
        ZStack {
            Circle()
                .foregroundStyle(.black.opacity(0.5))
            Image(systemName: isEditing ? "checkmark" : "pencil")
                .foregroundStyle(Color.tibbyBaseWhite)
        }
        .onTapGesture {
            if constants.vibration {
                HapticManager.instance.impact(style: .soft)
            }
            isEditing.toggle()
            isFocused.toggle()
        }
    }
}

