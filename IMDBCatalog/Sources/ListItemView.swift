//
//  ListItem.swift
//  IMDBCatalog
//
//  Created by Ewerton Pereira on 11/06/24.
//

import SwiftUI

struct ListItemView: View {
    var movie: Movie

    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: movie.coverImageName)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                Group {
                    Rectangle()
                        .fill(Color.black.opacity(0.7))
                        .frame(height: 20)
                    Text(movie.title)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .cornerRadius(4)
                        .padding([.leading, .trailing, .bottom], 0)
                        .frame(maxWidth: .infinity)
                }
            }.frame(width: 100, height: 150)
             .cornerRadius(8)
            Spacer()
        }
        .padding(.vertical, 0)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(movie: Movie(title: "Sample Movie", coverImageName: "moviecover"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
