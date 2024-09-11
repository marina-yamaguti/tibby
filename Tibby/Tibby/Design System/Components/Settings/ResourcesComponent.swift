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
            return .chevronRightGrey
        case .support, .rateInAppStore, .follow:
            return .arrowUpGrey
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
                        .resizable()
                        .frame(width: 16, height: 16)
                        .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)

                }
                .foregroundStyle(.tibbyBaseBlack)
                .onTapGesture {
                    handleTap(for: category)
                }
                Divider()
            }
            Image("TibbyLogoBW")
                .resizable()
                .frame(width: 120, height: 45)
                .padding(.top, 16)
            if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
                Text("v.\(appVersion)")
                    .font(.typography(.label))
                    .padding(.top, 16)
            }
        }
        .navigationDestination(isPresented: $showCredits, destination: {CreditsComponent()})
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
