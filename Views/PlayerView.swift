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
    @State var player = AVAudioPlayer()
    @State var volume : CGFloat = 0
    @State var position : CGFloat = 0
    @State var width : CGFloat = 0
    @State var isPlaying : Bool = false
    // @Obs var playingOrNo : PlayingStatus
    @State var songLength = 0
    @State var clickCount = 0
    @State private var albumArtSize: CGFloat = 100 // default size
    // var slider : UISlider!
    
    /*var nowPlaying: (album: Album, song: Song) {
        return (album, song)
    }*/
    
    @ObservedObject var data : internalData
    var body: some View {
        ZStack {
            Image(album.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .systemChromeMaterialDark).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                DynAlbumObj(album: album, isWithText: false, inputWidth: 250, inputHeight: 250, data: data)
                //AlbumObj(album: album, isWithText: false, data: data)
                    //.scaledToFit()
                    //.frame(width: albumArtSize, height: albumArtSize)
                    //.animation(.easeInOut, value: 0.5)
                //Image(album.image).scaledToFit().frame(width: albumArtSize, height: albumArtSize).animation(.easeInOut(duration: 0.8), value: 0.5)
                Spacer()
                Text(song.name).font(.title).fontWeight(.bold).foregroundColor(.white).padding(5)
                Spacer().padding(10)
                ZStack {
                    Color.white.cornerRadius(20).shadow(radius: 10).edgesIgnoringSafeArea(.bottom).opacity(0.8)
                    
                    
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
                        HStack(spacing: 5) {
                            Spacer().frame(width: 40) // Add a fixed-size spacer before the backward button
                            Button(action: self.previous, label: { Image(systemName: "backward.fill").resizable()
                            }).frame(width: 35, height: 25, alignment: .center).foregroundColor(Color.black.opacity(0.6)).padding(5)
                            Spacer()
                            Button(action: self.playPause, label: { Image(systemName: isPlaying ? "pause.fill" : "play.fill").resizable()
                            }).frame(width: 60, height: 60, alignment: .center).foregroundColor(Color.black.opacity(0.6)).padding(5)
                            Spacer()
                            Button(action: self.next, label: { Image(systemName: "forward.fill").resizable()
                            }).frame(width: 35, height: 25, alignment: .center).foregroundColor(Color.black.opacity(0.6)).padding(5)
                            Spacer().frame(width: 40) // Add a fixed-size spacer before the backward button

                        }
                        HStack(spacing: 22) {
                            /*Image(systemName: "speaker.fill")
                            Slider(value: $volume)
                            Image(systemName: "speaker.wave.2.fill")*/
                            VolumeSlider().padding()
                            
                        }
                    }
                    .padding()
                }.edgesIgnoringSafeArea(.bottom).frame( height: 250, alignment: .center)
            }
        }.onAppear() {
            self.playSong()
            //self.playPause()
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
                do {
                    player = try AVAudioPlayer(contentsOf: url!)
                } catch let error {
                    print(error)
                } 
                // player = AVPlayer(url: url!)
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
    /*func playSong() {
        let storage = Storage.storage().reference(forURL: self.song.file)
        
        storage.downloadURL { result in
            switch result {
            case .success(let url):
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                } catch {
                    // report for error
                }
                songLength = Int(song.time) ?? 0
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                } catch let error {
                    print(error)
                }                //player = AVPlayer(url: url!)
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
            case .failure(let error):
                print(error)
            }
        }
    }*/

    
    func changeAudioTime() {
        player.pause()
       //  player.
        
    }
    
    /*func controlPos() {
        player.stop()
        player.currentTime() = TimeInterval(slider.value)
        player.play()
    }*/
    
    func playPause() {
        self.isPlaying.toggle()
        if isPlaying == false {
            albumArtSize = 250
            player.pause()
        }
        else {
            player.play()
            albumArtSize = 280
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

struct PlayingStatus {
     var status = false
}

//struct PlayerView_Preview: PreviewProvider {
    /*static let album = Album(name: "AlbumName", image: <#T##String#>, songs: <#T##[Song]#>)
    static let album = Album(name: "Album name", artist: "Artist name", image: "albumImage", songs: [])
    static let song = Song(name: "Song name", file: "https://www.example.com/song.mp3", time: "3:45")
    static let data = internalData()

    static var previews: some View {
        PlayerView(album: album, song: song, data: data)
    }*/

//}


