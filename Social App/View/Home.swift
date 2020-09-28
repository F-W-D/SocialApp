import SwiftUI

struct Home: View {
    
    @State var selectedTab = "Posts"

    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            // Custom Tab Bar....
            ZStack{
                
                PostView()
                    .opacity(selectedTab == "Posts" ? 1 : 0)
                
                ProfileView()
                    .opacity(selectedTab == "Profile" ? 1 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            CustomTabbar(selectedTab: $selectedTab)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("bg"), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
       Home()
    }
}
