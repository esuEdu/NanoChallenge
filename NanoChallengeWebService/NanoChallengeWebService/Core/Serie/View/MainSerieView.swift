import SwiftUI

struct MainSerieView: View {
    @StateObject var seriesVM = SeriesViewModel()
    @State var searchText: String = ""
    var body: some View {
        NavigationStack{
            GeometryReader { geo in
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            HStack {
                                Text("Populares")
                                    .font(.title)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                                Spacer()
                                NavigationLink {
                                    AllSeries()
                                } label: {
                                    Text("Ver todas")
                                        .font(.title2)
                                        .padding(.horizontal)
                                        .foregroundColor(Color("GreenCyan"))
                                }
                            }
                            // Função para listar e fazer a scroll
                            ScrollCardsView(arraySeries: seriesVM.popularSeries)
                            // Puxa todas as series da array (paginação)
                            //  ScrollCardsView(arraySeries: seriesVM.tvSeriesArray)
                            
                            //Puxa apenas series de Action
                            ListGenreSerie(genreID: 10759, genreName: "Ação e aventura", serieArray: seriesVM.tvSeriesArray)
                            //Puxa apenas series de Drama
                            ListGenreSerie(genreID: 18, genreName: "Drama", serieArray: seriesVM.tvSeriesArray)
                            //Puxa apenas series de Minstério
                            ListGenreSerie(genreID: 9648, genreName: "Mistério", serieArray: seriesVM.tvSeriesArray)
                            
                            Text("\(seriesVM.count2)")
                                .foregroundColor(.white)
                        } // MARK: VSTACK SERIES
                        .navigationTitle("Series")
                    }
                    .background(Image("RectangleBG")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all))
                    .searchable(text: $searchText)
                }
            }
        }
        .task {
            // Limit para limitar o nunero de requisicoes na view
            await seriesVM.fetchAllTVSeries(limit: 200)
        }
        //.ignoresSafeArea()
    }
}

struct MainSerieView_Preview: PreviewProvider {
    static var previews: some View {
        MainSerieView()
    }
}
