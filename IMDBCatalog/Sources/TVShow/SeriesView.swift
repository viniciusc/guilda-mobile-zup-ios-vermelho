import SwiftUI

struct SeriesView: View {
    @StateObject private var viewModel = SeriesViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.series) { serie in
                        SeriesListItemView(serie: serie)
                    }
                }
                .padding()
            }
            .background(Color.black) // Set background to black
            .navigationTitle("Series")
            .onAppear {
                viewModel.fetchSeries()
            }
        }
    }
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesView()
    }
}
