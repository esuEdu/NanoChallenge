import SwiftUI

struct GenresDesign: View {
    var name: String
    var body: some View {
        Text(name)
            .lineLimit(1)
            .padding(.horizontal)
            .padding(.vertical, 3)
            .foregroundColor(Color("GenreColor"))
            .overlay{
                RoundedRectangle(cornerRadius: 24)
                    .stroke(style: .init(lineWidth: 1))
                    .foregroundColor(Color("GenreColor"))
                   
            }
    }
}

struct GenresDesign_Previews: PreviewProvider {
    static var previews: some View {
        GenresDesign(name: "Action")
    }
}
