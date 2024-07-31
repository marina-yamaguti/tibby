//
//  CustomPicker.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 18/07/24.
//

//
//  StyledPicker.swift
//  PickerPlus
//
//  Created by Alejandro Ulate on 10/2/23.
//
import SwiftUI
import UIKit

struct StyledPicker: View {
    @State private var selectedSegment = 0
    var segments = ["All", "Head", "Body"]
    
    init() {
        // Sets the background color of the Picker
        UISegmentedControl.appearance().backgroundColor = UIColor(red: 0.74, green: 0.85, blue: 0.94, alpha: 1.0)
        
        // Changes the color for the selected item
        UISegmentedControl.appearance().selectedSegmentTintColor = .tibbyBaseWhite
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedSegment) {
                ForEach(0..<segments.count) { index in
                    Text(self.segments[index]).tag(index)
                    
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}

struct StyledPicker_Previews: PreviewProvider {
    static var previews: some View {
        StyledPicker()
    }
}
