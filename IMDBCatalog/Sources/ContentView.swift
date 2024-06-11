//
//  ContentView.swift
//  IMDBCatalog
//
//  Created by Ewerton Pereira on 11/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            
            SeriesView()
                .tabItem {
                    Label("Series", systemImage: "tv")
                }
        }
    }
}