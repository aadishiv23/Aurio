//
//  PlayerView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 7/20/22.
//

import Foundation
import SwiftUI
import UIKit
import Firebase
import AVFoundation
import SwiftAudioPlayer
import MediaPlayer



struct LocalPlayerView : View {
    /*@State var album : Album
    @State var song : Song*/
    @State private var player = AVPlayer()
    @State private var volume : CGFloat = 0
    @State private var position : CGFloat = 0
    @State private var isPlaying : Bool = false
    var url : URL
    @State var fileName = ""
    //@ObservedObject var data : internalData
    var body: some View {
        ZStack {
            Image("leakcoverart").resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .systemChromeMaterialDark).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Image("leakcoverart").resizable().edgesIgnoringSafeArea(.all)
                Text(fileName).font(.title).fontWeight(.bold).foregroundColor(.white)
                Spacer().padding(20)
                ZStack {
                    Color.gray.cornerRadius(20).shadow(radius: 10).edgesIgnoringSafeArea(.bottom)
                    
                    
                    VStack {
                        HStack(spacing: 20) {
                            Text(position.description).foregroundColor(.white)
                            Slider(value: $position)
                            Text(position.description).foregroundColor(.white)
                            
                        }.padding()
                        HStack {
                            Button(action: self.previous, label: { Image(systemName: "backward.fill").resizable()
                            }).frame(width: 35, height: 25, alignment: .center).foregroundColor(Color.black.opacity(0.6))
                            Button(action: self.playPause, label: { Image(systemName: isPlaying ? "pause.fill" : "play.fill").resizable().padding()
                            }).frame(width: 80, height: 80, alignment: .center).foregroundColor(Color.black.opacity(0.6))
                            Button(action: self.next, label: { Image(systemName: "forward.fill").resizable()
                            }).frame(width: 35, height: 25, alignment: .center).foregroundColor(Color.black.opacity(0.6))
                        }
                        HStack(spacing: 22) {
                            /*Image(systemName: "speaker.fill")
                            Slider(value: $volume)
                            Image(systemName: "speaker.wave.2.fill")*/
                            VolumeSlider().padding()
        
                        }.padding()
                    }
                }.edgesIgnoringSafeArea(.bottom).frame( height: 250, alignment: .center)
            }
        }.onAppear() {
            self.playSong()
        }
    }
    // Designates a storage constant obj (FirebaseStorage by getting the url for a song from Firebase)
    func playSong() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }
        catch {
            // report for error
        }
        player = AVPlayer(url: url)
        player.play()
            
    }
    
    func changeAudioTime() {
        player.pause()
        player.currentTime()
    }
    
    func playPause() {
        self.isPlaying.toggle()
        if isPlaying == false {
            player.pause()
        }
        else {
            player.play()
        }
    }
    
    func next() {
    }
    
    func previous() {
        
    }
}

struct Previews_LocalPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}


