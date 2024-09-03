import SwiftUI

enum ResourceCategory: Hashable, CaseIterable {
    case credits
    case support
    case rateInAppStore
    case follow
    
    var label: String {
        switch self {
        case .credits:
            return "Credits"
        case .support:
            return "Contact Support"
        case .rateInAppStore:
            return "Rate in App Store"
        case .follow:
            return "Follow @tibby_app"
        }
    }
    
    var symbol: TibbySymbols {
        switch self {
        case .credits:
            return .starListBlack
        case .support:
            return .envelopeBlack
        case .rateInAppStore:
            return .starBlack
        case .follow:
            return .atBlack
        }
    }
    
    var redirectLink: String? {
        switch self {
        case .credits:
            return nil
        case .support:
            return "mailto:tibby_app@icloud.com"
        case .rateInAppStore:
            return "https://apps.apple.com/app/id6504777300?action=write-review"
        case .follow:
            return "https://instagram.com/tibby_app"
        }
    }
    
    var trailingType: TibbySymbols {
        switch self {
        case .credits:
            return .chevronRight
        case .support, .rateInAppStore, .follow:
            return .arrowDiagonalUp
        }
    }
}

struct ResourcesComponent: View {
    @State private var showCredits: Bool = false
    var appVersion: String = "v.1.0.0"
    
    var body: some View {
        VStack(spacing: 16) {
            Divider()
            
            HStack {
                Text("Resources")
                    .font(.typography(.label2))
                    .foregroundStyle(.tibbyBaseGrey)
                    .padding(.bottom, 8)
                Spacer()
            }
            
            ForEach(ResourceCategory.allCases, id: \.self) { category in
                HStack(alignment: .center, spacing: 8) {
                    Image(category.symbol.rawValue)
                        .font(.typography(.body2))
                    
                    Text(category.label)
                        .font(.typography(.body2))
                    Spacer()
                    Image(category.trailingType.rawValue)
                }
                .foregroundStyle(.tibbyBaseBlack)
                .onTapGesture {
                    handleTap(for: category)
                }
                Divider()
            }
            Image("Logo")
                .padding(.top, 16)
            if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
                Text("v.\(appVersion)")
                    .font(.typography(.label))
            }
        }
        .sheet(isPresented: $showCredits) {
            CreditsComponent()
                .padding(16)
            Spacer()
        }
    }
    
    private func handleTap(for category: ResourceCategory) {
        guard let urlString = category.redirectLink, let url = URL(string: urlString) else {
            if category == .credits {
                showCredits = true
            }
            return
        }
        UIApplication.shared.open(url)
    }
}

#Preview {
    ResourcesComponent()
}
