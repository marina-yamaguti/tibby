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
    var tibby: Tibby
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var category = "All"
    let categories = ["All","Head", "Body"]
    @Binding var wardrobeIsOpen: Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 45)
                .foregroundStyle(.tibbyBaseBlack)
                .padding(.top, 100)
            VStack {
                
                HStack(alignment: .top) {
                    ActionButton(image: Symbols.xMark.rawValue, action: {})
                    Spacer()
                    ActionButton(image: Symbols.xMark.rawValue, action: {wardrobeIsOpen.toggle()})
                }.padding()
                SegmentedPicker(selection: $category, categories: categories)
                    .padding(.horizontal)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(service.getAllAccessories()?.sorted(by: {$0.name < $1.name}) ?? []) { accessory in
                            Button {
                                tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                            } label: {
                                if tibby.id == accessory.tibbyId {
                                    ItemCard(name: accessory.name, status: .selected, color: .tibbyBaseBlue, image: "\(accessory.image)-wardrobe")
                                        .frame(width: 150, height: 150)
                                }
                                else {
                                    ItemCard(name: accessory.name, status: .unselected, color: .tibbyBaseBlue, image: "\(accessory.image)-wardrobe")
                                        .frame(width: 150, height: 150)
                                }
                            }
                            .onChange(of: selectedAccessory, {
                                // Observes changes in the selected Tibby to update accessory interactions.
                                if tibby.id == accessory.tibbyId {
                                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                                }
                                
                            })
                            
                        }
                    }.padding()
                }.scrollIndicators(.hidden)
                    .clipShape(RoundedRectangle(cornerRadius: 45))
            }.padding(.top, 100)
            VStack {
                SpriteView(scene: tibbyView as SKScene, options: [.allowsTransparency]).frame(width: 200, height: 200)
                //                .offset(y: 100)
                Spacer()
            }
        }
        .onAppear {
            for accessory in service.getAllAccessories() ?? [] {
                if tibby.id == accessory.tibbyId {
                    print("usando \(accessory.name)")
                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                    selectedAccessory = accessory
                }
            }
            tibbyView.setTibby(tibbyObject: tibby, constants: constants, service: service)
            if constants.tibbySleeping {
                tibbyView.animateTibby((TibbySpecie(rawValue: tibby.species)?.sleepAnimation())!, nodeID: .tibby, timeFrame: 0.5)
            }
        }
        .onChange(of: selectedAccessory, {
            if let accessory = selectedAccessory {
                if tibby.id == accessory.tibbyId {
                    tibbyView.addAccessory(accessory, service, tibbyID: tibby.id)
                }
            }
        })
        .padding(.top, 40)
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
