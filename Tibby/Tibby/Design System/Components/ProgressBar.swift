//
//  ProgressBar.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 20/08/24.
//

import Foundation
import SwiftUI
enum ProgressBarType {
    case eat, sleep, emotion
}

struct CustomProgressBar: ProgressViewStyle {
    @ObservedObject var vm = ProgressBarViewModel()
    var enviroment: Enviroment
    var strokeColor = Color.blue
    var strokeWidth = 25.0
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return ZStack {
            Capsule()
                .fill(.black.opacity(0.5))
                .aspectRatio(6, contentMode: .fit)
                .foregroundStyle(vm.getProgressColor(progress: fractionCompleted))
            Capsule()
                .aspectRatio(6, contentMode: .fit)
                .foregroundStyle(vm.getProgressColor(progress: fractionCompleted))
        }
    }
}

struct TestView: View {
    var body: some View {
        ProgressView(value: 1.0)
            .progressViewStyle(CustomProgressBar(enviroment: .bedroom))
    }
}

#Preview {
    TestView()
}
