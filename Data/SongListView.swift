//
//  SongListView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 7/22/22.
//

import Foundation
import SwiftUI

struct RoundedCorners: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct SongListView : View {
    var album : Album
    //var song : Album
    @ObservedObject var data : internalData
    @State private var currentAlbum : Album?
    
    var body: some View {
        ZStack {
            Image(album.image).resizable().opacity(0.5)
            Blur(style: .prominent).edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    //Spacer()
                    AlbumObj(album: album, isWithText: false, data: data)
                    Text(album.name).font(.title).fontWeight(.bold).foregroundColor(.black)
                    Spacer().padding(40)
                    ScrollView {
                        ZStack {
                            
                            // Color.white.cornerRadius(20).shadow(radius: 10).edgesIgnoringSafeArea(.bottom)
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(radius: 10)
                                .clipShape(RoundedCorners(radius: 20, corners: [.topLeft, .topRight]))
                                .edgesIgnoringSafeArea(.bottom)
                            VStack {
                                if self.data.albums.first == nil {
                                    EmptyView()
                                }
                                // displays the songs in the form of songCell obj for each album in a list format below the album once clicked on
                                else {
                                    ForEach((album.songs) ,
                                            
                                            id: \.self, content: {
                                        song in
                                        SongCell(album : currentAlbum ?? album , song: song, data: data).accessibilityLabel("The song \(song.name) which has a length of \(song.time)")
                                    })
                                }
                            }.edgesIgnoringSafeArea(.bottom)
                            Spacer()
                        }
                        Spacer()
                    }/*.edgesIgnoringSafeArea(.bottom).frame( height: 200, alignment: .center)*/
                }
            }
        }
    }
}

