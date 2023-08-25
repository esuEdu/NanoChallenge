import SwiftUI

struct MainSerieView: View {
    @StateObject var seriesVM = SeriesViewModel()
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    HStack {
                        Text("Populares")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                        NavigationLink {
                     
                        } label: {
                            Text("Ver todas")
                                .font(.title2)
                            .padding(.horizontal)
                            .foregroundColor(.green)
                        }
                    }
                    // Função para listar e fazer a scroll
                    ScrollCardsView(arraySeries: seriesVM.popularSeries)
                    // Puxa todas as series da array (paginação)
                    ScrollCardsView(arraySeries: seriesVM.tvSeriesArray)
                    
                    Text("\(seriesVM.count2)")
                } // MARK: VSTACK SERIES
                .navigationTitle("Series")
            }
        }
        .task {
            await seriesVM.fetchAllTVSeries()
        }
        .ignoresSafeArea()
    }
}

struct MainSerieView_Preview: PreviewProvider {
    static var previews: some View {
        MainSerieView()
    }
}
