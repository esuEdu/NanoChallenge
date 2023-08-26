import SwiftUI

enum Strings: String {
    case imageError = "Image Error"
    case titleError = "Title Error"
}

struct MovieHomeView: View {
    
    @State var responseMovieDiscover: responceDiscoverMovies?
    @State var movieService: MovieService = MovieService()
    
    /*
     struct PopularTeste: View {
         @StateObject var seriesVM = SeriesViewModel()
         var body: some View {
             VStack {
                 NavigationStack{
                     ScrollView {
                         VStack {
                             HStack {
                                 Text("Series")
                                     .font(.title)
                                     .padding(.horizontal)
                                 Spacer()
                                 Text("Ver todas")
                                     .font(.title2)
                                     .padding(.horizontal)
                             }
                             ScrollView(.horizontal, showsIndicators: false){
                                 LazyHStack {
                                     ForEach(0 ..< seriesVM.tvSeriesArray.count, id: \.self){ index in
                                         NavigationLink {
                                             TVSerieDetail(series: seriesVM.tvSeriesArray[index])
                                             
                                         } label: {
                                             VStack {
                                                 // if let para pegar o complemento da imagem do link
                                                 if let backDropPath = seriesVM.tvSeriesArray[index].backdrop_path {
                                                     AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backDropPath)")) {
                                                         image in
                                                         image
                                                             .resizable()
                                                             .scaledToFill()
                                                             .backgroundStyle(.white)
                                                             .frame(maxWidth: 185,maxHeight: 230)
                                                             .cornerRadius(16)
                                                             .shadow(radius: 8, x: 5, y: 5)
                                                             .overlay {
                                                                 RoundedRectangle(cornerRadius: 16)
                                                                     .stroke(.gray.opacity(0.5), lineWidth: 1)
                                                             }
                                                     } placeholder: {
                                                         RoundedRectangle(cornerRadius: 16)
                                                             .stroke(.gray.opacity(0.5), lineWidth: 1)
                                                             .frame(width: 160, height: 230)
                                                             .overlay {
                                                                 ProgressView()
                                                                     .scaleEffect(4)
                                                                     .frame(maxHeight: 96)
                                                                     .padding()
                                                             }
                                                     }
                                                     
                                                 }
                                                 Text("\(seriesVM.tvSeriesArray[index].name.capitalized)")
                                                     .font(.title2)
                                                     .foregroundColor(.black)
                                                 Text("\(seriesVM.count2)")
                                                 
                                             }
                                             .padding()
                                             
                                         } // MARK: LABEL
                                         
                                     }
                                 }
                             }
                             
                         } // MARK: VSTACK SERIES
                         .navigationTitle("Series")
                     }
                     
                 }
                 
                 .task {
                     await seriesVM.fetchAllTVSeries()
                 }
                 .ignoresSafeArea()
             } // MARK: Primeira VSTACK
             .ignoresSafeArea()
             
         }
     }
     */
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Movies")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                        Text("View All")
                            .font(.title2)
                            .padding(.horizontal)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            if let responseMovieDiscover = responseMovieDiscover {
                                ForEach(responseMovieDiscover.results ?? [], id: \.id) { movie in
                                    NavigationLink(destination: MovieItem(idMovie: movie.id)) {
                                        VStack {
                                            if let backdropPath = movie.backdropPath {
                                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .background(Color.white)
                                                        .frame(maxWidth: 185, maxHeight: 230)
                                                        .cornerRadius(16)
                                                        .shadow(radius: 8, x: 5, y: 5)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                        }
                                                } placeholder: {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                        .frame(width: 160, height: 230)
                                                        .overlay {
                                                            ProgressView()
                                                                .scaleEffect(4)
                                                                .frame(maxHeight: 96)
                                                                .padding()
                                                        }
                                                }
                                            } else {
                                                Text(Strings.imageError.rawValue)
                                            }
                                            
                                            if let title = movie.title {
                                                Text(title)
                                            } else {
                                                Text(Strings.titleError.rawValue)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Movies")
                .task {
                    do {
                        responseMovieDiscover = try await movieService.getDiscoverMovies()
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}

struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
