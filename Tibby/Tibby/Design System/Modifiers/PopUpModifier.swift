//
//  PopUpModifier.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 23/09/24.
//

import SwiftUI

struct OverlayModifier<OverlayView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let overlayView: OverlayView
    
    init(isPresented: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self._isPresented = isPresented
        self.overlayView = overlayView()
    }
    
    func body(content: Content) -> some View {
        content.overlay(isPresented ? overlayView : nil)
    }
}

extension View {
    func popup<OverlayView: View>(
        isPresented: Binding<Bool>,
        overlayOpacity: Double = 0.5,
        @ViewBuilder overlayView: @escaping () -> OverlayView
    ) -> some View {
        ZStack {
            // Original content with conditional overlay
            self
            
            // Conditional black transparent layer when `isPresented` is true
            if isPresented.wrappedValue {
                Color.black
                    .opacity(overlayOpacity)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity) // Optional transition for smoother appearance
                    .animation(.easeInOut, value: isPresented.wrappedValue)
                
                overlayView()
                    .transition(.scale) // Optional transition for the overlay view
                    .animation(.easeInOut, value: isPresented.wrappedValue)
            }
        }
    }
}
