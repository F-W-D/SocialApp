import SwiftUI

struct Login: View {
    
    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        VStack{
            
            Spacer()
            
            HStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("title"))
                    .multilineTextAlignment(.center)
            }
            .padding()
            
            HStack(spacing: 15){
                
                Image(systemName: "phone")
                    .font(.title)
                    .foregroundColor(Color("title"))
                    

                TextField("+1-385-439-4920", text: $loginData.number)
                    .padding()
                    .accentColor(Color("title"))
                    .foregroundColor(.black)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("title"), lineWidth: 2)
                    )
                    .keyboardType(.numberPad)
                    .modifier(TextFieldClearButton(text: $loginData.number))
                    .multilineTextAlignment(.leading)
                    .onChange(of: loginData.number, perform: { value in
                        loginData.number = value.phoneFormat()
                    })
            }
            .padding()
            .padding(.top,10)
            
            if loginData.isLoading {
                ProgressView()
                    .padding()
            } else{
                Button(action: loginData.verifyUser, label: {
                    Text("Verify")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("title"))
                        .clipShape(Capsule())
                })
                .disabled(loginData.number.count != 17 ? true : false)
                .opacity(loginData.number.count != 17 ? 0.5 : 1)
            }
            
            Spacer()
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("bg"), Color.white]), startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea(.all, edges: .all))
        .onTapGesture(count: 1, perform: {
            UIApplication.shared.endEditing()
        })
        
        // Displaying Alert...
        .alert(isPresented: $loginData.error, content: {
            
            Alert(title: Text("Uh-oh!"), message: Text(loginData.errorMsg), dismissButton: .default(Text("👍")))
        })
        .fullScreenCover(isPresented: $loginData.registerUser, content: {
            
            Register()
        })
    }
}

#if DEBUG
struct Login_Previews: PreviewProvider {
    static var previews: some View {
        return Login()
    }
}
#endif
