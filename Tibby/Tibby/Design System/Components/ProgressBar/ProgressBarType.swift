//
//  CustomProgressBar.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 21/08/24.
//

import Foundation
import SwiftUI

enum ProgressBarType {
    case eat, sleep, emotion, xp
}

struct CustomProgressBar: ProgressViewStyle {
    @ObservedObject var vm = CustomBarViewModel()
    @EnvironmentObject var constants: Constants
    var barType: ProgressBarType
    var height = 10.0
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return GeometryReader { geometry in
            VStack {
                if barType == .sleep || barType == .emotion {
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.black.opacity(0.5))
                            .frame(height: CGFloat(height))
                        
                        Capsule()
                            .fill(vm.getProgressColor(progress: fractionCompleted))
                            .frame(width: geometry.size.width * CGFloat(fractionCompleted), height: CGFloat(height))
                    }
                    .aspectRatio(6, contentMode: .fit)
                } else if barType == .eat {
                    HStack(spacing: 8) {
                        ForEach(0..<3) { segment in
                            Capsule()
                                .fill(vm.getSegmentedProgressColor(segment: segment, progress: fractionCompleted))
                                .frame(width: geometry.size.width / 3, height: CGFloat(height))
                        }
                    }
                    .aspectRatio(3, contentMode: .fit)
                } else {
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(.tibbyBasePearlBlue)
                            .frame(height: CGFloat(height))
                        
                        Capsule()
                            .fill(.tibbyBaseSaturatedGreen)
                            .frame(width: geometry.size.width * CGFloat(fractionCompleted), height: CGFloat(height))
                    }
                }
                HStack {
                    Text(vm.getText(value: fractionCompleted, barType: barType))
                        .foregroundStyle(.tibbyBaseBlack)
                        .font(.typography(.label))
                        .padding(.top, 4)
                    Spacer()
                }
            }
        }
    }
}
