//
//  LocalMusicView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 11/4/22.
//

import SwiftUI
import AVKit
import UIKit

/*struct LocalMuscView : View {
    
    var body : some View {
        
    }
}*/
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
}

struct LocalMusicView: View {

    @State var audioPlayer: AVAudioPlayer!
    @State var selection: URL?
    @State var progress: Double = 0
    @State var isPlaying = false
    @State var volume: Float = 0.5
    
    var body: some View {
        VStack {
            Spacer()
            if selection == nil {
                Button(action: {
                    let scene = UIApplication.shared.connectedScenes.first
                    if let windowScene = scene as? UIWindowScene {
                        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.audio])
                        picker.delegate = makeCoordinator()
                        windowScene.windows.first?.rootViewController?.present(picker, animated: true, completion: nil)
                    }
                }) {
                    Text("Select Audio File")
                }
            } else {
                Group {
                    if isPlaying {
                        Button(action: {
                            audioPlayer.pause()
                            isPlaying = false
                        }) {
                            Image(systemName: "pause.circle.fill")
                                .font(.largeTitle)
                        }
                    } else {
                        Button(action: {
                            audioPlayer.play()
                            isPlaying = true
                        }) {
                            Image(systemName: "play.circle.fill")
                                .font(.largeTitle)
                        }
                    }
                    Slider(value: $progress, in: 0...audioPlayer.duration, onEditingChanged: { _ in
                        audioPlayer.currentTime = progress
                    })
                    HStack {
                        Image(systemName: "speaker.fill")
                            .font(.title)
                        Slider(value: $volume, in: 0...1, onEditingChanged: { _ in
                            audioPlayer.volume = volume
                        })
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        isPlaying = audioPlayer.isPlaying
                        progress = audioPlayer.currentTime
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
                if let url = selection {
                    let success = url.startAccessingSecurityScopedResource()
                    defer {
                        url.stopAccessingSecurityScopedResource()
                    }
                    if success {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayer.delegate = makeCoordinator()
                        audioPlayer.prepareToPlay()
                        audioPlayer.volume = volume
                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                            progress = audioPlayer.currentTime
                        }
                    } else {
                        print("Failed to access the file.")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }

    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate, AVAudioPlayerDelegate {
        var parent: LocalMusicView
        
        init(_ parent: LocalMusicView) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                url.startAccessingSecurityScopedResource()
                defer { url.stopAccessingSecurityScopedResource() }
                parent.selection = url
                do {
                    parent.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    parent.audioPlayer.delegate = self
                    parent.audioPlayer.prepareToPlay()
                    parent.isPlaying = true
                } catch {
                    print("Error: \(error.localizedDescription)")
                    return
                }
            }
            controller.dismiss(animated: true, completion: nil)
        }


        
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            parent.isPlaying = false
        }
    }
    
}

 

