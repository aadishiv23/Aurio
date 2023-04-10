//
//  NowPlayingView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 4/10/23.
//

import Foundation
import SwiftUI
import AVKit

struct NowPlayingBar: View {
    @Binding var isPlayerViewPresented: Bool // boolean to keep track of whether player view is present or not
    //let nowPlaying: (album: Album, song: Song)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .opacity(0.7) // set the background color and opacity of the bar
                HStack {
                    Image(systemName: "music.note")
                    Text("Now Playing")
                    Spacer()
                    /*NavigationLink(destination: PlayerView(isPlayerViewPresented: self.$isPlayerViewPresented)) {
                        Image(systemName: "play.circle")
                    }*/
                    /*NavigationLink(destination: PlayerView(album: , song: Song, data: internalData)) {
                        Image(systemName: "play.circle")
                    }*/
                }
                .foregroundColor(.white)
                .padding()
            }
            .frame(width: geometry.size.width, height: 50)
            .offset(y: self.isPlayerViewPresented ? 0 : geometry.size.height) // offset the bar to bottom when not presented
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        self.isPlayerViewPresented = true // set boolean to true when the bar is tapped
                    }
            )
        }
    }
}
