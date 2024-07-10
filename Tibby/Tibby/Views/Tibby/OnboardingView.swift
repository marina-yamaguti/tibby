//
//  Onboarding.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/07/24.
//

import SwiftUI

struct OnboardingView: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OnboardingView(imageName: hat", title: "Onboarding", description: "lorem ipsum")
}
