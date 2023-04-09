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


// UIKit based Volume slider from high schol stil works!!!!
struct VolumeSlider: UIViewRepresentable {
   func makeUIView(context: Context) -> MPVolumeView {
      MPVolumeView(frame: .zero)
   }

   func updateUIView(_ view: MPVolumeView, context: Context) {}
}



struct PlayerView : View {
    @State var album : Album
    @State var song : Song
    @State var player = AVPlayer()
    @State var volume : CGFloat = 0
    @State var position : CGFloat = 0
    @State var width : CGFloat = 0
    @State var isPlaying : Bool = false
    @State var songLength = 0
    @State var clickCount = 0
    // var slider : UISlider!
    
    @ObservedObject var data : internalData
    var body: some View {
        ZStack {
            Image(album.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .systemChromeMaterialDark).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                AlbumObj(album: album, isWithText: false, data: data).accessibilityLabel("The album art for \(album.name)")
                Text(song.name).font(.title).fontWeight(.bold).foregroundColor(.white)
                Spacer().padding(20)
                ZStack {
                    Color.gray.cornerRadius(20).shadow(radius: 10).edgesIgnoringSafeArea(.bottom)
                    
                    
                    VStack {
                        HStack(spacing: 20) {
                            Text(position.description).foregroundColor(.white)
                            //slider.maximumValue = Float(player.)
                            Slider (
                                value: $position,
                                in: 0...CGFloat(songLength)
                            )
                            Text(song.time).foregroundColor(.white)
                            //Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                            //Capsule().fill(Color.blue).frame(width: self.width, height: 8)
                            
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
            self.playPause()
        }
    }
    // Designates a storage constant obj (FirebaseStorage by getting the url for a song from Firebase)
    func playSong() {
        let storage = Storage.storage().reference(forURL: self.song.file)
        storage.downloadURL { (url, error) in
            if error != nil {
                print(error!)
            }
            else {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                }
                catch {
                    // report for error
                }
                
                songLength = Int(song.time) ?? 0
                player = AVPlayer(url: url!)
                player.play()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    if isPlaying {
                        // test  print(self.player.currentTime())
                        position += 1
                        var cgFloat: CGFloat?
                        let screen = UIScreen.main.bounds.width - 30
                        let doubleValue = Double(song.time)
                        cgFloat = CGFloat(doubleValue ?? 50)
                        /*if let doubleValue = Double(song.time) {
                            cgFloat = CGFloat(doubleValue)
                        }*/
                        let value = position / cgFloat!
                        self.width = screen * (doubleValue ?? 120)
                        //player.seek(to: position)
                    }
                }
            }
        }
    }
    
    func changeAudioTime() {
        player.pause()
        player.currentTime()
        
    }
    
    /*func controlPos() {
        player.stop()
        player.currentTime() = TimeInterval(slider.value)
        player.play()
    }*/
    
    func playPause() {
        self.isPlaying.toggle()
        if isPlaying == false {
            player.pause()
        }
        else {
            player.play()
        }
    }
    
    /*func next() {
        position = 0
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == album.songs.count - 1 {
                song = album.songs[0]
            }
            else {
                song = album.songs[currentIndex + 1]
            }
            restartPlayback()
        }
    }
    
    func previous() {
        position = 0
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == 0 {
                song = album.songs[album.songs.count - 1]
            }
            else {
                song = album.songs[currentIndex - 1]
            }
            restartPlayback()
        }
    }
    


    
    func restartPlayback() {
        if isPlaying {
            player.pause()
            player.seek(to: CMTime.zero)
            player.play()
        }
    }*/
    
    func next() {
        position = 0
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == album.songs.count - 1 {
                song = album.songs[0]
                player.pause()
                self.playSong()
            }
            else {
                player.pause()
                song = album.songs[currentIndex + 1]
                self.playSong()
            }
        }
    }
    
    func previous() {
        position = 0
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == 0 {
                song = album.songs[0]
                player.pause()
                self.playSong()
            }
            else {
                player.pause()
                song = album.songs[currentIndex - 1]
                self.playSong()
            }
        }
    }
}

struct Previews_PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}


