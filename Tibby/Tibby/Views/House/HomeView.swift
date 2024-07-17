//
//  HomeView.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 15/07/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            //HomeView
            NavigationLink {
                NavigationTabbarView()
            } label: {
                Text("House")
            }
        }
    }
}
