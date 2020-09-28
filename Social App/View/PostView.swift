import SwiftUI

struct PostView: View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var postData = PostViewModel()
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("Posts")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
                
                Button(action: {postData.newPost.toggle()}) {
                    
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                        .foregroundColor(Color("title"))
                }
            }
            .padding()
            .padding(.top,edges!.top)
            .background(Color("bg"))
            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
            
            if postData.posts.isEmpty {
                
                Spacer(minLength: 0)
                
                if postData.noPosts {
                    Text("No Posts !!!")
                } else {
                    ProgressView()
                }
                
                Spacer(minLength: 0)
                
            } else{
    
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(postData.posts){ post in
                            PostRow(post: post,postData: postData)
                        }
                    }
                    .padding()
                    .padding(.bottom,55)
                }
            }
        }
        .modifier(DarkModeViewModifier())
        .fullScreenCover(isPresented: $postData.newPost) {
            NewPost(updateId : $postData.updateId)
        }
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
#endif
