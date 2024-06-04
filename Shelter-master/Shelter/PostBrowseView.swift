
import SwiftUI

struct PostBrowseView: View {
    @ObservedObject var postManager = DogPostsManager.shared
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List(postManager.dogPosts) { dogPost in
                NavigationLink(destination: PostDetailView(dogPost: dogPost)){
                    DogCardView(dogPost: dogPost)
                        .contextMenu {
                            self.favoriteMenuButton(for: dogPost)
                            self.deleteMenuButton(for: dogPost)
                    }
                }
            }
            .navigationBarTitle("Пошук")
            .navigationBarItems(trailing: addButton())
            .sheet(isPresented: $isPresented) {
                NewPostView(isPresented: self.$isPresented)
            }
        }
    }
    
    func addButton()-> some View {
        Button(action: {
            self.isPresented = true
        }){
            
            Image(systemName: "plus")
                .font(.title)
            
        }
    }
    
    func favoriteMenuButton(for dogPost:DogPost) -> some View {
        Button(action: {
            if dogPost.isFavorite {
                self.postManager.removeFromFavorites(post: dogPost)
            }else {
                self.postManager.addToFavorites(post: dogPost)
            }
        }) {
            Text(dogPost.isFavorite ? "Видалити з улюблених":"Додати до улюблених")
            Image(systemName:dogPost.isFavorite ? "heart.slash" : "heart")
        }
    }
    
    func deleteMenuButton(for dogPost:DogPost) -> some View {
        Button(action: {
            self.postManager.delete(post: dogPost)
            
        }) {
            Text("Видалити оголошення").foregroundColor(.red)
            Image(systemName:"trash")
        }
    }
}

struct DogCardView: View {
    let dogPost:DogPost
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0){
            dogPost.image
                .resizable()
                .scaledToFit()
            
            HStack {
                Text(dogPost.dogName.capitalized)
                    .font(.headline)
                    .padding([.leading])
                
                if dogPost.isFavorite {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color(UIColor.systemPink))
                        .padding([.trailing])
                }
            }
            
            Text(dogPost.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding([.leading,.bottom,.trailing])
            
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
        .shadow(radius: 10.0)
        .padding([.top,.bottom])
    }
}

struct DogBrowseView_Previews: PreviewProvider {
    static var previews: some View {
        PostBrowseView()
    }
}
