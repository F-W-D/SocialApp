import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var settingsData = SettingsViewModel()
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
                
            }
            .padding()
            .padding(.top,edges!.top)
            .background(Color("bg"))
            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)

            if settingsData.userInfo.pic != ""{
                
                ZStack{
                    
                    WebImage(url: URL(string: settingsData.userInfo.pic)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                        .shadow(color: Color.black, radius: 3, x: 3, y: 3)
                    
                    if settingsData.isLoading{
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("title")))
                    }
                }
                .padding(.top,25)
                .onTapGesture {
                    settingsData.picker.toggle()
                }
            }
            
            HStack(spacing: 15){
                
                Text(settingsData.userInfo.username)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                
                // Edit Button...
                
                Button(action: {settingsData.updateDetails(field: "Name")}) {
                    
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }
            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
            .padding()
            
            HStack(spacing: 15){
                
                Text(settingsData.userInfo.bio)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                
                // Edit Button...
                
                Button(action: {settingsData.updateDetails(field: "Bio")}) {
                    
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }
            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)

            Spacer(minLength: 0)
            
            Button(action: settingsData.logOut, label: {
                
                HStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill.badge.xmark")
                        .foregroundColor(Color.white)
                        .font(.title)
                    Text("Logout")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical)
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                .background(Color.red)
                .clipShape(Capsule())
            })
            .padding()
            .padding(.top,10)
            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
            
            Spacer(minLength: 10)
            
        }
        .sheet(isPresented: $settingsData.picker) {
         
            ImagePicker(picker: $settingsData.picker, img_Data: $settingsData.img_data)
        }
        .onChange(of: settingsData.img_data) { (newData) in
            // whenever image is selected update image in Firebase...
            settingsData.updateImage()
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
#endif
