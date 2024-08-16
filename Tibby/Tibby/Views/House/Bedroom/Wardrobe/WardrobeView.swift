import SwiftUI
import SpriteKit

/// A view that represents the wardrobe interface in the Tibby app.
/// Users can view and select accessories for their Tibby character.
struct WardrobeView: View {
    
    /// The `TibbyView` instance responsible for displaying the Tibby character with accessories.
    @State var tibbyView = TibbyView()
    
    /// Environment object containing global constants.
    @EnvironmentObject var constants: Constants
    
    /// Environment object providing services such as data fetching and manipulation.
    @EnvironmentObject var service: Service
    
    /// The accessory currently selected by the user, if any.
    @State var selectedAccessory: Accessory?
    
    /// The current selection status of the accessories.
    @State var status: SelectionStatus = .unselected
    
    /// The list of accessories available to the user.
    @State var accessories: [Accessory] = []
    
    /// The `Tibby` character that the user is customizing.
    var tibby: Tibby
    
    /// Grid layout for displaying the accessories in two columns.
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    /// The currently selected category of accessories.
    @State var category: String = "All"
    
    /// List of available accessory categories.
    let categories = ["All", "Head", "Body"]
    
    /// Binding to control whether the wardrobe view is open or closed.
    @Binding var wardrobeIsOpen: Bool
    
    var body: some View {
        
        ZStack {
            // Background for the wardrobe view
            RoundedRectangle(cornerRadius: 45)
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.top, 100)
            
            VStack {
                
                // Top bar with close button
                HStack(alignment: .top) {
                    Button(action: {}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.xMark.rawValue, text: "")})
                        .buttonSecondary(bgColor: .black)
                        .hidden()
                    Spacer()
                    Button(action: {wardrobeIsOpen.toggle()}, label: {ButtonLabel(type: .secondary, image: TibbySymbols.xMark.rawValue, text: "")})
                        .buttonSecondary(bgColor: .black)
                }
                .padding()
                
                // Category selector
                SegmentedPicker(selection: $category, categories: categories)
                    .padding(.horizontal)
                
                // Grid of accessories
                ScrollView {
                    LazyVGrid(columns: columns) {
                        
                        // Option to remove accessory
                        if selectedAccessory == nil {
                            Button(action: {
                                removeAccessory()
                            }, label: {
                                ItemCard(name: .constant("None"), status:.selected, color: .tibbyBaseBlue, image: "\(tibby.species)1")
                                    .frame(width: 150, height: 150)
                                    .padding(.bottom)
                                    .onTapGesture {
                                        removeAccessory()
                                    }
                                
                            })
                        } else {
                            Button(action: {
                                removeAccessory()
                            }, label: {
                                ItemCard(name:.constant("None"), status: .unselected, color: .tibbyBaseBlue, image: "\(tibby.species)1")
                                    .frame(width: 150, height: 150)
                                    .padding(.bottom)
                                    .onTapGesture {
                                        removeAccessory()
                                    }
                                
                            })
                        }
                        
                        // Displaying each accessory in the grid
                        ForEach($accessories) { $accessory in
                            Button {
                                selectedAccessory = accessory
                            } label: {
                                if tibby.id == accessory.tibbyId {
                                    ItemCard(name: $accessory.name, status: .selected, color: .tibbyBaseBlue, image: "\(accessory.image)-wardrobe")
                                        .frame(width: 150, height: 150)
                                        .padding(.bottom)
                                }
                                else {
                                    ItemCard(name: $accessory.name, status: .unselected, color: .tibbyBaseBlue, image: "\(accessory.image)-wardrobe")
                                        .frame(width: 150, height: 150)
                                        .padding(.bottom)
                                }
                            }
                            
                        }
                    }.padding()
                }
                .scrollIndicators(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 45))
                
            }
            .padding(.top, 100)
            
            // Tibby character view
            VStack {
                SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency])
                    .frame(width: 200, height: 200)
                Spacer()
            }
        }
        .onAppear {
            self.accessories = getFilteredList()
            for accessory in service.getAllAccessories() ?? [] {
                if tibby.id == accessory.tibbyId {
                    print("usando \(accessory.name)")
                    tibbyView.addAccessory(accessory) {
                        service.addAccessoryToTibby(tibbyId: tibby.id, accessory: accessory)
                    } remove: {
                        tibbyView.removeAccessory {
                            for accessory in service.getAllAccessories()! {
                                if accessory.tibbyId == tibby.id {
                                    service.removeAccessoryFromTibby(accessory: accessory)
                                }
                            }
                        }
                    }
                    selectedAccessory = accessory
                }
            }
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
            if constants.tibbySleeping {
                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
            }
        }
        .padding(.top, 40)
        .onChange(of: category, {
            accessories = getFilteredList()
        })
        .onChange(of: selectedAccessory, {
            if let accessory = selectedAccessory {
                tibbyView.addAccessory(accessory) {
                    service.addAccessoryToTibby(tibbyId: tibby.id, accessory: accessory)
                } remove: {
                    tibbyView.removeAccessory {
                        for accessory in service.getAllAccessories()! {
                            if accessory.tibbyId == tibby.id {
                                service.removeAccessoryFromTibby(accessory: accessory)
                            }
                        }
                    }
                }
            }
        })
    }
    
    /// Filters the list of accessories based on the selected category and returns a sorted list.
    private func getFilteredList() -> [Accessory] {
        var list: [Accessory] = []
        if let filteredList = service.getAllAccessories() {
            list = filteredList
        }
        if category == "All" {
            return list.sorted(by: {$0.name < $1.name})
        }
        list = list.filter({$0.category == category}).sorted(by: {$0.name < $1.name})
        return list
    }
    
    /// Removes the currently equipped accessory from the Tibby character.
    private func removeAccessory() {
        if let accessories = service.getAllAccessories() {
            for accessory in accessories {
                tibbyView.removeAccessory {
                    for accessory in service.getAllAccessories()! {
                        if accessory.tibbyId == tibby.id {
                            service.removeAccessoryFromTibby(accessory: accessory)
                        }
                    }
                }
                accessory.tibbyId = nil
                selectedAccessory = nil
            }
        }
    }
}

/// A custom picker component that allows users to select between different categories of accessories.
struct SegmentedPicker: UIViewRepresentable {
    
    /// The currently selected category.
    @Binding var selection: String
    
    /// The list of categories available for selection.
    var categories: [String]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: categories)
        segmentedControl.addTarget(context.coordinator, action: #selector(Coordinator.updateSelection(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = UIColor(Color.tibbyBaseWhite)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(Color.tibbyBaseBlack)], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(Color.tibbyBaseWhite)], for: .normal)
        return segmentedControl
    }
    
    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        if let index = categories.firstIndex(of: selection) {
            uiView.selectedSegmentIndex = index
        }
    }
    
    /// Coordinator class to handle updates to the segmented picker.
    class Coordinator: NSObject {
        var parent: SegmentedPicker
        
        init(_ parent: SegmentedPicker) {
            self.parent = parent
        }
        
        @objc func updateSelection(_ sender: UISegmentedControl) {
            let index = sender.selectedSegmentIndex
            parent.selection = parent.categories[index]
        }
    }
}

extension UIFont {
    /// Converts a SwiftUI Font to a corresponding UIFont, if possible.
    class func preferredFont(from font: Font) -> UIFont {
        let style: UIFont.TextStyle =
        switch font {
        case .largeTitle:   .largeTitle
        case .title:        .title1
        case .title2:       .title2
        case .title3:       .title3
        case .headline:     .headline
        case .subheadline:  .subheadline
        case .callout:      .callout
        case .caption:      .caption1
        case .caption2:     .caption2
        case .footnote:     .footnote
        default: .body
        }
        return  UIFont.preferredFont(forTextStyle: style)
    }
}
