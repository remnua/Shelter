
import SwiftUI

struct PostDetailView: View {
    var dogPost:DogPost
    
    var body: some View {
        Form {
            
            dogPost.image
            .resizable()
            .scaledToFit()
            .listRowInsets(.init())
            
            Section(header:Text("Опис")){
                HStack {
                    Text("Кличка")
                    Spacer()
                    Text(dogPost.dogName).foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Порода")
                    Spacer()
                    Text(dogPost.breedName).foregroundColor(.secondary)
                }
                
                
                HStack {
                    Text("Вік")
                    Spacer()
                    Text(formatted(ageInMonths: dogPost.ageInMonths)).foregroundColor(.secondary)
                }
            }
            Section(header:Text("Виміри")){
                HStack {
                    Text("Зріст")
                    Spacer()
                    Text("\(dogPost.bodyMeasurements.height,specifier:"%.2f") см").foregroundColor(.secondary)
                }
                HStack {
                    Text("Вага")
                    Spacer()
                    Text("\(dogPost.bodyMeasurements.weight,specifier:"%.2f") кг").foregroundColor(.secondary)
                }
            }
            if dogPost.isAvailableForAdoption {
                Section(header:Text("Приручення")){
                    HStack {
                        Text("Пошта власника")
                        Spacer()
                        Text(dogPost.ownersEmail).foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Місто")
                        Spacer()
                        Text(dogPost.city).foregroundColor(.secondary)
                    }
                }
                
            }
            
        }.navigationBarTitle(Text(dogPost.breedName), displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(dogPost: DogPost(breedName: "Pug",dogName: "Casper", ageInMonths: 6, city: "Bangalore", isAvailableForAdoption: true, isFavorite: true, ownersEmail: "abc@b.com", bodyMeasurements: BodyMeasurement(height: 15, weight: 20), imageName: nil, description: "Cute Dog", postImage: nil))
    }
}
