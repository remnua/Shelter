import SwiftUI

struct ContentView: View {
  
    @State private var selection = 0
    let viewModel: DogBreedViewModel = DogBreedViewModel()
    
    var body: some View {
        TabView(selection:$selection) {
            PostBrowseView()
                .tabItem {
                    Image("Browse Icon")
                    Text("Пошук")
            }
            .tag(0)
            
            DogBreedView(model: viewModel)
                .tabItem {
                    Image(systemName:"rectangle.stack.fill")
                        .font(.system(size: 22.0))
                    Text("Порода")
                }
            .tag(1)
            .onAppear() {
                self.viewModel.fetchImages()
            }
            
        }.edgesIgnoringSafeArea(.top)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}


