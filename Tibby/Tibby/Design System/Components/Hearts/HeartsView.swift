//
//  HeartsView.swift
//  Tibby
//
//  Created by Marina Yamaguti on 18/07/24.
//

import SwiftUI

struct HeartsView: View {
    @ObservedObject var viewModel: HeartsViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Image(viewModel.getHeartImage(index: index))
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            Text(viewModel.category.rawValue)
                .font(.typography(.title))
        }
        .onAppear {
            viewModel.fetchCategoryValue()
        }
    }
}

//#Preview {
//    HeartsView(viewModel: HeartsViewModel(category: .hunger, service: Service()))
//}
