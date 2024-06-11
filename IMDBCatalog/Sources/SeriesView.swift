//
//  SeriesView.swift
//  IMDBCatalog
//
//  Created by Ewerton Pereira on 11/06/24.
//

import SwiftUI

struct SeriesView: View {
    var body: some View {
        NavigationView {
            List {
                // Aqui você pode adicionar a lógica para listar as séries
                Text("Series 1")
                Text("Series 2")
                Text("Series 3")
            }
            .navigationTitle("Series")
        }
    }
}
