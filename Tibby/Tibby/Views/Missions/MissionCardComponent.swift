//
//  MissionCardComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 11/09/24.
//

import SwiftUI

struct MissionCardComponent: View {
    @Binding var missions: [MissionProtocol]
    var body: some View {
        VStack(spacing: 0) {
            ForEach($missions, id: \.id) { $mission in
                MissionProgressComponent(mission: $mission)
                    .padding(.vertical, 8)
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.tibbyBasePearlBlue)
        }
    }
    
}


