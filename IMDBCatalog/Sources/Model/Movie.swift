//
//  Movie.swift
//  IMDBCatalog
//
//  Created by Ewerton Pereira on 11/06/24.
//

import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let coverImageName: String
    let releaseDate: String
    let overview: String
    let popularity: Double // New property
}
