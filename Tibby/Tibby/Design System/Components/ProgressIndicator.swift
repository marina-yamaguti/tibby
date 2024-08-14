//
//  ProgressIndicator.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 12/08/24.
//

import SwiftUI

struct ProgressIndicator: View {
    let progressIndicator: [Color] = [.tibbyBaseRed, .tibbyBaseYellow, .tibbyBaseGreen, .tibbyBaseBlue]
    var page: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<progressIndicator.count, id: \.self) { index in
                Capsule()
                    .fill(page < index ? .black : progressIndicator[index])
                    .aspectRatio(6, contentMode: .fit)
            }
        }
    }
}


#Preview {
    ProgressIndicator(page: 1)
}
