//
//  Movie.swift
//  IMDBCatalog
//
//  Created by Ewerton Pereira on 11/06/24.
//

import SwiftUI

struct Movie: Identifiable {
    var id = UUID()
    var title: String
    var coverImageName: String
}
