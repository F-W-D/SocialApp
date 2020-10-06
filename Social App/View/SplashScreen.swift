import SwiftUI

struct SplashScreen: View {
    
    static var shouldAnimate = true
    
    let background = Color("bg")
    let title = Color("title")
    let uLineWidth: CGFloat = 2
    let uZoomFactor: CGFloat = 1.4
    let lineWidth:  CGFloat = 4
    let lineHeight: CGFloat = 28
    let uSquareLength: CGFloat = 12
    
    @State var percent = 0.0
    @State var uScale: CGFloat = 1
    @State var squareColor = Color.white
    @State var squareScale: CGFloat = 1
    @State var lineScale: CGFloat = 1
    @State var textAlpha = 0.0
    @State var textScale: CGFloat = 1
    @State var coverCircleScale: CGFloat = 1
    @State var coverCircleAlpha = 0.0
    
    var body: some View {
        ZStack {
            Image("launchBG")
                .resizable(resizingMode: .tile)
                .opacity(textAlpha)
                .foregroundColor(Color("title"))
                .scaleEffect(textScale)
            
            Circle()
                .fill(background)
                .frame(width: 1, height: 1,
                       alignment: .center)
                .scaleEffect(coverCircleScale)
                .opacity(coverCircleAlpha)
            
            Text("fwd:")
                .font(.title)
                .foregroundColor(.white)
                .offset(x: -55, y: -1.5)
                .opacity(textAlpha)
                .scaleEffect(textScale)
                .shadow(color: Color.black, radius: 1)
            
            CircleAnimation(percent: percent)
                .stroke(Color.white, lineWidth: uLineWidth)
                .shadow(color: .gray, radius: 1)
                .rotationEffect(.degrees(-90))
                .aspectRatio(1, contentMode: .fit)
                .padding(20)
                .onAppear() {
                    self.handleAnimations()
                }
                .scaleEffect(uScale * uZoomFactor)
                .frame(width: 55, height: 55,
                       alignment: .center)
            
            Image(systemName: "forward")
                .foregroundColor(squareColor)
                .font(.title)
                .scaleEffect(squareScale * uZoomFactor)
                .frame(width: uSquareLength, height: uSquareLength, alignment: .center)
                .offset(x: 2, y: 0)
                .shadow(color: Color.black, radius: 1)
                .onAppear() {
                    self.squareColor = background
                }
        }
        .background(background)
        .edgesIgnoringSafeArea(.all)
    }
}

extension SplashScreen {
    
    var uAnimationDuration: Double { return 1.0 }
    var uAnimationDelay: Double { return  0.2 }
    var uExitAnimationDuration: Double { return 0.3 }
    var finalAnimationDuration: Double { return 0.5 }
    var minAnimationInterval: Double { return 0.1 }
    var fadeAnimationDuration: Double { return 0.5 }
    
    func handleAnimations() {
        runAnimationPart1()
        //runAnimationPart2()
        runAnimationPart3()
        if SplashScreen.shouldAnimate {
            restartAnimation()
        }
    }
    
    func runAnimationPart1() {
        withAnimation(.easeIn(duration: uAnimationDuration)) {
            percent = 1
            uScale = 5
            lineScale = 1
        }
        
        withAnimation(Animation.easeIn(duration: uAnimationDuration).delay(0.85)) {
            textAlpha = 1.0
        }
        
        let deadline: DispatchTime = .now() + uAnimationDuration + uAnimationDelay
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeOut(duration: self.uExitAnimationDuration)) {
                self.uScale = 0
                self.lineScale = 0
            }
            withAnimation(.easeOut(duration: self.minAnimationInterval)) {
                self.squareScale = 0
            }
            
            withAnimation(Animation.spring()) {
                self.textScale = self.uZoomFactor
            }
        }
    }
    
    func runAnimationPart2() {
        let deadline: DispatchTime = .now() + uAnimationDuration + uAnimationDelay + minAnimationInterval
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.squareColor = Color.white
            self.squareScale = 1
            withAnimation(.easeOut(duration: self.fadeAnimationDuration)) {
                self.coverCircleAlpha = 1
                self.coverCircleScale = 1000
            }
        }
    }
    
    func runAnimationPart3() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2*uAnimationDuration) {
            withAnimation(.easeIn(duration: self.finalAnimationDuration)) {
                self.textAlpha = 0
                self.squareColor = self.background
            }
        }
    }
    
    func restartAnimation() {
        let deadline: DispatchTime = .now() + 2*uAnimationDuration + finalAnimationDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.percent = 0
            self.textScale = 1
            self.coverCircleAlpha = 0
            self.coverCircleScale = 1
            self.handleAnimations()
        }
    }
}

struct CircleAnimation: Shape {
    
    var percent: Double
    
    var animatableData: Double {
        get { return percent }
        set { percent = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let end = percent * 360
        var p = Path()
        
        p.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
                 radius: rect.size.width/2,
                 startAngle: Angle(degrees: 0),
                 endAngle: Angle(degrees: end),
                 clockwise: false)
        
        return p
    }

}

#if DEBUG
struct SplashScreen_Previews : PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .preferredColorScheme(.light)
            
    }
}
#endif
