
import SwiftUI

struct DogBreedView: View {
    
    @ObservedObject var model: DogBreedViewModel
    
    var body: some View {
        NavigationView {
            List(model.breeds,id: \.self) { dogBreed in
                DogBreedPhotosView(dogBreed: dogBreed)
                
            } .navigationBarTitle("Породи")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DogBreedPhotosView: View {
    
    let dogBreed: DogBreed
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(dogBreed.name.capitalized).font(.title)
            
            if dogBreed.error.count > 0 {
                Text(dogBreed.error)
            }
            else {
                if dogBreed.images.count > 0 {
                    HStack {
                        ForEach(dogBreed.images,id: \.self) { image in
                            Image(uiImage: image).resizable()
                                .scaledToFit().cornerRadius(6.0)
                        }
                    }
                }
                else {
                    Text("Фото не доступне")
                }
            }
        }.padding(.all)
    }
}

struct DogBreedView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedView(model: DogBreedViewModel())
    }
}
