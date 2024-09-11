import SwiftUI

struct TibbyCard: View {
    @Binding var name: String
    @State var status: SelectionStatus
    var color: Color
    var image: String
    var rarity: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("Capsule\(rarity)")
                    .resizable()
                    .frame(width: 15, height: 15)
                Spacer()
                if status == .locked {
                    Image(TibbySymbols.lock.rawValue)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 9, height: 13)
                        .foregroundStyle(Color.tibbyBaseBlack)
                }
            }
            HStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .scaleEffect(1.5)
                    .scaledToFill()
                    .brightness(status == .locked ? -1 : 0) // Dim the image if the item is locked
                    .padding(.horizontal, 22)
            }
            .padding(.bottom, 5)
            HStack {
                Text(status == .locked ? "???" : name)
                    .font(.typography(.label2))
                    .padding(.vertical, 8)
                    .frame(width: 110)
                    .foregroundStyle(Color.tibbyBaseBlack)
            }
            .background(Color.tibbyBaseWhite.opacity(0.5))
            .withBorderRadius(20)
        }
        .padding(16)
        .aspectRatio(1, contentMode: .fit)
        .background {
            color
                .cornerRadius(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.tibbyBaseBlack, lineWidth: status == .unselected ? 0 : 1)
                }
        }
        .shadow(color: Color(red: 0.16, green: 0.17, blue: 0.22).opacity(0.2), radius: 2, x: 0, y: 0)
    }
}

