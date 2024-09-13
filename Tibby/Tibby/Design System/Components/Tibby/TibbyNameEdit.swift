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
    
    @State private var stateColor: Color = .tibbyBaseGrey
            
    let characterLimit: Int = 10
    
    var spacing: CGFloat {
          return isEditing ? 0 : 16
    }
      
    
    var body: some View {
        HStack(spacing: spacing) {
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
                ZStack {
                    // Text field for editing the name
                    HStack {
                        TextField("Given Name", text: $tibby.name)
                            .disableAutocorrection(true)
                            .font(.typography(.headline))
                            .foregroundStyle(Color.tibbyBaseBlack)
                            .frame(width: textWidth)
                            .onChange(of: tibby.name) {oldValue, newValue in
                                if newValue.count > characterLimit {
                                    tibby.name = String(newValue.prefix(characterLimit))
                                    HapticManager.instance.impact(style: .heavy)
                                } else if  newValue.count == characterLimit{
                                    stateColor = .red
                                } else {
                                    stateColor = .tibbyBaseGrey
                                }
                            }
                            .onSubmit {
                                isEditing = false
                            }
                            .focused($isFocused)
                        
                        Text("\(tibby.name.count)/\(characterLimit)")
                            .font(.caption)
                            .foregroundColor(stateColor)
                    }
                    .padding()
                }
                
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
                .foregroundStyle(isEditing ? .tibbyBaseSaturatedGreen : .black.opacity(0.5))
            Image(isEditing ? TibbySymbols.checkmarkWhite.rawValue: TibbySymbols.pen.rawValue)
                .foregroundStyle(Color.tibbyBaseWhite)
        }
        .onTapGesture {
            HapticManager.instance.impact(style: .soft)
            isEditing.toggle()
            isFocused.toggle()
        }
    }
}

