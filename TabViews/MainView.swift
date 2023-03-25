//
//  MainView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 8/14/22.
//

import Foundation
import SwiftUI
import AVFoundation

struct MainView : View {
    @ObservedObject var data : internalData
    //@State var audioPlayer: AVAudioPlayer
    var body: some View {
        TabView {
            ContentView(data: data)
                .tabItem {
                    Label("Home", systemImage: "person.crop.circle.fill")
                }
        }
    }
}




