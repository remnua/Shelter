import SwiftUI
struct NewPostView: View {
    
    @State private var dogName:String = ""
    @State private var dogHeight:String = ""
    
    @State private var dogWeight:String = ""
    @State private var selectedBreed:String = ""
    @State private var age:String = ""
    
    @State private var isAvailableForAdoption = false
    @State private var ownerEmail:String = ""
    @State private var city:String = ""
    @State private var description:String = ""
    @State private var selectedImage:UIImage?
    
    
    @State private var isImagePickerPresented = false
    @Binding var isPresented:Bool
    
    
    var dogImage:Image {
        if let image = selectedImage
        {
            return Image(uiImage: image)
        }else{
            return Image("Placeholder")
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Фото собаки")) {
                    Button(action: {
                        self.isImagePickerPresented = true
                    }) {
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                dogImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(idealHeight: self.selectedImage == nil ? 200.0 : nil)
                                    .padding()
                                    .foregroundColor(Color(.systemFill))
                                Text("Вибрати фото")
                                    .fontWeight(.bold)
                                    .padding(.bottom)
                                    .foregroundColor(Color(.systemBlue))
                            }
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(.init())
                }
                
                Section(header: Text("Риси")) {
                    HStack {
                        Text("Зріст в см")
                        TextField("см", text: $dogHeight)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Вага в кг")
                        TextField("кг", text: $dogWeight)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Вік в місяцях")
                        TextField("Місяці", text: $age)
                            .multilineTextAlignment(.trailing).keyboardType(.numberPad)
                    }
                    
                    Picker("Порода", selection: $selectedBreed) {
                        ForEach(dogBreeds, id:\.self){ breedName in
                            Text(breedName)
                        }
                    }
                    
                }
                Section(header: Text("Приручення")) {
                    Toggle(isOn: $isAvailableForAdoption) {
                        Text("Придатний до приручення")
                    }
                    
                    if isAvailableForAdoption {
                        HStack {
                            Text("Контактна пошта")
                            TextField("appaccelerator@apple.com", text: $ownerEmail)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.emailAddress)
                        }
                        HStack {
                            Text("Місто")
                            TextField("напр. Київ", text: $city)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                }
                Section {
                    HStack {
                        Text("Кличка")
                        TextField("Кличка собаки", text: $dogName)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    TextField("Напишіть про свою собаку", text: $description)
                    
                }
                
            }
            .modifier(KeyboardHeight())
            .navigationBarTitle(Text("Нове оголошення"),displayMode:.inline)
            .navigationBarItems(leading: Button(action: {
                self.isPresented = false
            }, label: {
                Text ("Відміна")
            }), trailing: Button(action: {
                self.isPresented = false
                self.addNewPost()
                
            }, label: {
                Text ("Готово").fontWeight(.bold)
            }))
            
        }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$isImagePickerPresented, onDismiss: {
            }, content: {
                ImagePicker(originalImage: self.$selectedImage,presentationMode: self.$isImagePickerPresented)
            })
        
    }
    
    
    func addNewPost(){
        
        let dogPost = DogPost(breedName: selectedBreed,dogName:dogName, ageInMonths: Int(age) ?? 0, city: city, isAvailableForAdoption: isAvailableForAdoption, isFavorite: false, ownersEmail: ownerEmail, bodyMeasurements: BodyMeasurement(height: Double(dogHeight) ?? 0.0, weight: Double(dogWeight) ?? 0.0), imageName: nil, description: description, postImage: self.selectedImage)
        
        DogPostsManager.shared.add(post: dogPost)
    }
    
    
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(isPresented: .constant(true))
    }
}
