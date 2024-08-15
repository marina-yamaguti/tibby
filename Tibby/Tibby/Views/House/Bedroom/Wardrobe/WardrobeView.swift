//
//  WardrobeView.swift
//  Tibby
//
//  Created by Sofia Sartori on 18/07/24.
//

import SwiftUI
import SpriteKit

struct WardrobeView: View {
    @State var tibbyView = TibbyView()
    @EnvironmentObject var constants: Constants
    @EnvironmentObject var service: Service
    @State var selectedAccessory: Accessory?
    @State var status: SelectionStatus = .unselected
    @State var accessories: [Accessory] = []

    var tibby: Tibby
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var category: String = "All"
    let categories = ["All","Head", "Body"]
    @Binding var wardrobeIsOpen: Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 45)
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.top, 100)
            VStack {
                
                HStack(alignment: .top) {
                    ActionButton(image: TibbySymbols.xMark.rawValue, action: {}).hidden()
                    Spacer()
                    ActionButton(image: TibbySymbols.xMark.rawValue, action: {wardrobeIsOpen.toggle()})
                }.padding()
                SegmentedPicker(selection: $category, categories: categories)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        
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
                }.scrollIndicators(.hidden)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
                
                
            }.padding(.top, 100)
            VStack {
                SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 200, height: 200)
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

struct SegmentedPicker: UIViewRepresentable {
    @Binding var selection: String
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
        //        segmentedControl.setTitleTextAttributes([.font: UIFont.preferredFont(from: Font.typography(.headline)) ], for: .normal)
        //        segmentedControl.setTitleTextAttributes([.font: UIFont.preferredFont(from: Font.typography(.label))], for: .selected)
        return segmentedControl
    }
    
    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        if let index = categories.firstIndex(of: selection) {
            uiView.selectedSegmentIndex = index
        }
    }
    
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
        default: /*.body */ .body
        }
        return  UIFont.preferredFont(forTextStyle: style)
    }
}
