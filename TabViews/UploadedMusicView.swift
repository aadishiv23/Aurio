//
//  UploadedMusicView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 11/4/22.
//

import Foundation
import SwiftUI

struct UploadedMusicView: View {
    // Helpful Hacking With Swift article
    // https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-observedobject-property-wrapper
    // Essentially this property wrapper makes it so that view can "watch" the state of an external object
    // and be notified when something important has changed
    // similar to @stateobject, but must not be used to create objects
    // can only be used by objects created elsewhere - good we created object in Data file
    @ObservedObject var data : internalData
    
    // Leave Album optional
    // State property wrapper is used to modify values inside structs
    // storage of curralbum moved out of struct and into shared storage managed by swiftui
    @State private var currentAlbum : Album?
    
    var animationAmt = 2
    @State var isPlayerViewPresented = false // boolean to keep track of whether player view is present or not
    // creates the order/position of column (modify spacing if needed) 4 lazyvgrid
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.data.albums, id: \.self) { album in
                        AlbumArt(album: album, isWithText: true, data: data)
                            .onTapGesture {
                                self.currentAlbum = album
                            }
                            .accessibilityLabel("The album \(album.name)")
                            .accessibilityHint("By pressing this album, you will be able to see the songs in it")
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Uploaded Music")
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: SendMusicView(data: data),
                    label: {
                        Image(systemName: "arrow.up.doc")
                    }
                )
            )
        }
        .overlay(
                NowPlayingBar(isPlayerViewPresented: self.$isPlayerViewPresented)
                    .animation(.default, value: animationAmt)
                        // .animation(.default) // add animation to the bar when it appears or disappears
        )
        .onDisappear {
                self.isPlayerViewPresented = false // set boolean to false when leaving the view
        }
    }
}

// static album cover object only used for display purposes
struct AlbumObj : View {
    var album : Album
    var isWithText : Bool
    @ObservedObject var data : internalData
    var body: some View {
         ZStack(alignment: .bottom, content:  {
             Image(album.image)
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(width: 250, height: 250, alignment: .center)
        
             if isWithText == true {
                 ZStack {
                     Blur(style: .prominent)
                     Text(album.name).foregroundColor(.white)
                 }.frame(height: 60, alignment: .center)
             }
         }).frame(width: 250, height: 250, alignment: .center).clipped().cornerRadius(15).shadow(radius: 20).padding(20)
    }
}


// Interactible Album cover object
struct AlbumArt : View {
    var album : Album
    var isWithText : Bool
    @ObservedObject var data : internalData
    var body: some View {
       NavigationLink(
        destination: SongListView(album: album, data: data),
        label: {
            ZStack(alignment: .bottom, content:  {
                Image(album.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 170, alignment: .center)
                
                /*if isWithText == true {
                    ZStack {
                        Blur(style: .dark)
                        Text(album.name).foregroundColor(.white)
                    }.frame(height: 30, alignment: .center)
                } */
            }).frame(width: 170, height: 170, alignment: .center).clipped().cornerRadius(15).shadow(radius: 20).padding(20)
        }).buttonStyle(PlainButtonStyle())
            .animation(.easeInOut, value: 2)
    }
}

struct SongCell : View {
    var album : Album
    var song : Song
    @ObservedObject var data : internalData
    var body: some View {
        NavigationLink(
            destination: PlayerView(album: album, song: song, data: data),
            label:  {
                ZStack {
                    //Color.white.opacity(0.2).cornerRadius(20).shadow(radius: 10).padding(2)
                    HStack {
                        ZStack {
                            Image(systemName: "play.fill").frame(width: 60, height: 60, alignment: .center).foregroundColor(.blue)
                            /*Circle().frame(width: 45, height: 45, alignment: .center).foregroundColor(.blue)
                            Circle().frame(width: 15, height: 15, alignment: .center).foregroundColor(.white)*/
                        }
                        Text(song.name).bold().foregroundColor(.black)
                        Spacer()
                        Text(song.time).bold().foregroundColor(.black)
                    }.padding(20)
                }
            }).buttonStyle(PlainButtonStyle())
    }
}
