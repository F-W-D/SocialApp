import SwiftUI

struct ContentView: View {
    
    @State var showSplash = true
    @AppStorage("current_status") var status = false
    
    var body: some View {

        NavigationView{
            
            VStack{
                
                if showSplash {
                    SplashScreen()
                      .opacity(showSplash ? 1 : 0)
                      .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                          SplashScreen.shouldAnimate = false
                          withAnimation() {
                            self.showSplash = false
                          }
                        }
                      }
                } else {
                    if status{Home().transition(.fade(duration: 1.5))}
                    else{Login().transition(.fade(duration: 1.5))}
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
