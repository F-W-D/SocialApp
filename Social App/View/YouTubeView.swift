import SwiftUI
import UIKit
import YouTubePlayer

final class YouTubeView: UIViewRepresentable {
    
    typealias UIViewType = YouTubePlayerView
    
    @ObservedObject var playerState: YouTubeControlState
    
    init(playerState: YouTubeControlState) {
        self.playerState = playerState
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(playerState: playerState)
    }
                
    func makeUIView(context: Context) -> UIViewType {
        let playerVars = [
            "controls": "1",
            "playsinline": "0",
            "autohide": "0",
            "autoplay": "0",
            "fs": "1",
            "rel": "0",
            "loop": "0",
            "enablejsapi": "1",
            "modestbranding": "1"
        ]
        
        let ytVideo = YouTubePlayerView()
        
        ytVideo.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        ytVideo.delegate = context.coordinator
        
        return ytVideo
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        guard let videoID = playerState.videoID else { return }
        
        if !(playerState.executeCommand == .idle) && uiView.ready {
            switch playerState.executeCommand {
            case .loadNewVideo:
                playerState.executeCommand = .idle
                uiView.loadVideoID(videoID)
            case .play:
                playerState.executeCommand = .idle
                uiView.play()
            case .pause:
                playerState.executeCommand = .idle
                uiView.pause()
            case .forward:
            playerState.executeCommand = .idle
                uiView.getCurrentTime { (time) in
                    guard let time = time else {return}
                    uiView.seekTo(Float(time) + 10, seekAhead: true)
                }
            case .backward:
                playerState.executeCommand = .idle
                uiView.getCurrentTime { (time) in
                    guard let time = time else {return}
                    uiView.seekTo(Float(time) - 10, seekAhead: true)
                }
            default:
                playerState.executeCommand = .idle
                print("\(playerState.executeCommand) not yet implemented")
            }
        } else if !uiView.ready {
            uiView.loadVideoID(videoID)
        }
        
    }
    
    class Coordinator: YouTubePlayerDelegate {
        @ObservedObject var playerState: YouTubeControlState
        
        init(playerState: YouTubeControlState) {
            self.playerState = playerState
        }
        
        func playerReady(_ videoPlayer: YouTubePlayerView) {
            videoPlayer.play()
            playerState.videoState = .play
        }
        
        func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
            
            switch playerState {
            case .Playing:
                self.playerState.videoState = .play
            case .Paused, .Buffering, .Unstarted:
                self.playerState.videoState = .pause
            case .Ended:
                self.playerState.videoState = .stop
                //TODO: self.playerState.videoID = loadNextVideo()
            default:
                print("\(playerState) not implemented")
            }
        }
    }
}

#if DEBUG
struct YouTubeView_Previews: PreviewProvider {
    static var previews: some View {
        let control = YouTubeControlState.init()
        return YouTubeView(playerState: control)
    }
}
#endif
