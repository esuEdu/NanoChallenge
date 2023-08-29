//
//  MovieItem.swift
//  NanoChallengeWebService
//
//  Created by Thiago Pereira de Menezes on 21/08/23.
//

import SwiftUI

struct MovieItem: View {
    
    @StateObject var mv:MovieItemVM
    var dataController = CoreDataController()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            //MARK: - IMAGEM
            GeometryReader { reader in
                if (mv.movieItem.backdropPath) != nil {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(mv.movieItem.backdropPath ?? "")")) { image in image
                        
                        //MARK: Estilização do banner (imagem) do filme
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                        
                        //MARK: Estilização placeholder (enquanto não carrega a imagem)
                    } placeholder: {
                        ProgressView()
                        ProgressView()
                            .scaleEffect(4)
                            .frame(maxHeight: 96)
                            .foregroundColor(.white)
                            .offset(y: -reader.frame(in: .global).minY)
                            .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).minY + 480)
                    }
                }
            }
            .frame(height: 480)
            VStack(alignment: .leading, spacing: 15){
                Text(mv.movieItem.title ?? "")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.white)
                
                
                //MARK: - Todos os gêneros
                HStack {
                    if let genres = mv.movieItem.genres {
                        ForEach(genres, id: \.id){
                            genre in
                            GenresDesign(name: genre.name ?? "") //Esta struct define o visual de todos os gêneros
                        }
                    }
                }
                
                
                
                //MARK: Descrição do filme
                if mv.movieItem.overview == ""{
                    Text("Description not found")
                        .padding(.top)
                        .foregroundColor(Color.white)
                } else {
                    Text(mv.movieItem.overview ?? "Sem overview")
                        .padding(.top)
                        .foregroundColor(Color.white)
                }
                
                VStack(alignment: .leading, spacing: 15){
                    
                    //MARK: - Nota do filme (estrelas)
                    HStack {
                        if let voteAverage = mv.movieItem.voteAverage {
                            
                            let average = voteAverage / 2
                            let fullStars = Int(average)
                            let hasHalfStar = (average - Double(fullStars)) >= 0.5
                            
                            ForEach(0..<5) { index in
                                if index < fullStars {
                                    //Estrelas preenchidas
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                                } else if index == fullStars && hasHalfStar {
                                    //Estrelas semi-preenchidas
                                    Image(systemName: "star.leadinghalf.fill")
                                        .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                                } else {
                                    //Estrelas vazias
                                    Image(systemName: "star")
                                        .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                                }
                            }
                            
                        }
                        Spacer()
                        
                        //MARK: - Botão de favoritos
                        Button {
                            let test = Favorito(context: dataController.container.viewContext)
                            test.id = String(mv.movieItem.id)
                            test.type = "filme"
                            if !dataController.favoritos.contains(where:{ i in
                                i.id == String(mv.movieItem.id)
                            }){
                                dataController.addFavorite(id: String(mv.movieItem.id), type: "filme")
                                mv.isFavorite = true
                            } else{
                                dataController.delete(id: String(mv.movieItem.id), type: "filme")
                                mv.isFavorite = false
                            }
                        } label: {                 //MARK: Estilização do button
                            if dataController.favoritos.contains(where: { i in
                                i.id == String(mv.movieItem.id)
                            }) || mv.isFavorite == true{
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                            }else{
                                Image(systemName: "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(Color(red: 0.97, green: 0.48, blue: 0.33))
                            }
                        }
                    }
                    
                    //MARK: - Atores:
                    //Título da sessão de atores
                    Text("Creditos")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                    //ScrollView que contém todos os atores
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            if let casts = mv.castResponce?.cast {
                                ForEach(casts) { cast in
                                    //Design da imagem dos atores
                                    VStack {
                                        if let profilePath = cast.profilePath {
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(profilePath)")) { phase in
                                                if let image = phase.image {
                                                    image //Design da imagem dos atores
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 96, height: 144)
                                                        .cornerRadius(10)
                                                } else if phase.error != nil {
                                                    Color.red // Mostrar algo em caso de erro
                                                } else {
                                                    ProgressView()
                                                }
                                            }
                                            .frame(width: 96, height: 144)
                                            .clipShape(Rectangle())
                                            
                                            
                                        }
                                        
                                        Text(cast.name)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 96)
                                }
                            }
                        }
                    }
                }
                
            } // MARK: VStack principal
            .padding(.top, 25)
            .padding(.horizontal)
            .background(.black)
            .cornerRadius(20)
            .offset(y: -35)
        }
        .edgesIgnoringSafeArea(.all)
        .background(.black)
        .task {
            do {
                try? await mv.getMovie()
                try? await mv.getCasts()
                
            }
        }
    }
}
