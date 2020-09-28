import SwiftUI

struct CustomTabbar: View {
    
    @Binding var selectedTab : String
    @State var showPopUp = false

    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Spacer()
                Spacer()
                ZStack {
                    if self.showPopUp {
                       PlusMenu().offset(y: -geometry.size.height/6)
                    }
                    
                    HStack(spacing: 65){
                        
                        TabButton(title: "Posts", selectedTab: $selectedTab)
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: 75, height: 75)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75)
                                .foregroundColor(Color("title"))
                                .shadow(color: Color.black, radius: 0.5, x: 0.5, y: 0.5)
                                .rotationEffect(Angle(degrees: self.showPopUp ? 90 : 0))
                        }
                        .offset(y: -geometry.size.height/10/2)
                        .onTapGesture {
                            withAnimation {
                               self.showPopUp.toggle()
                            }
                        }
                        TabButton(title: "Profile", selectedTab: $selectedTab)
                    }
                    .padding(.horizontal, 30.0)
                    .padding(.bottom, 15.0)
                    .background(Color.white)
                    .frame(width: geometry.size.width, height: (geometry.size.height/10))
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct PlusMenu: View {
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .foregroundColor(Color("title"))
                    .frame(width: 70, height: 70)
                Image(systemName: "camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                    .shadow(color: Color.black, radius: 0.5, x: 0.5, y: 0.5)
            }
            ZStack {
                Circle()
                    .foregroundColor(Color("title"))
                    .frame(width: 70, height: 70)
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                    .shadow(color: Color.black, radius: 0.5, x: 0.5, y: 0.5)
            }
        }
            .transition(.scale)
    }
}

struct TabButton : View {
    
    var title : String
    @Binding var selectedTab : String
    
    var body: some View{
        
        Button(action: {selectedTab = title}) {
            
            VStack(spacing: 5){
                
                let name = title == "Posts" ? "doc.richtext" : "rectangle.stack.person.crop"
                Image(systemName: name)
                    .renderingMode(.template)
                    .font(.headline)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .foregroundColor(selectedTab == title ? Color.black : .gray)
            .padding(.horizontal)
            .padding(.vertical,10)
        }
    }
}


