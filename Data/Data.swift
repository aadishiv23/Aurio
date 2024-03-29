//
//  Data.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 8/10/22.
//

import Foundation
import SwiftUI
import Firebase

// Reread observableobject protocol documentation
// https://developer.apple.com/documentation/combine/observableobject
class internalData : ObservableObject {
    // any view inside our application can read this data (think kinda like
    // if a class has public data
    @Published public var albums = [Album]()
    
    
    func loadAlbums() {
            Firestore.firestore().collection("albums").getDocuments { (snapshot, error) in
            
            if error == nil {
                for document in snapshot!.documents {
                    let name = document.data()["name"] as? String ?? "error"
                    let image  = document.data()["image"] as? String ?? "1"
                    print(image)
                    print(document.data())
                    let songs = document.data()["songs"] as? [String: [String: Any]]
                    
                    var songsArray = [Song]()
                    if let songs = songs {
                        for song in songs {
                            let songName = song.value["name"] as? String ?? "error"
                            let songTime = song.value["time"] as? String ?? "error"
                            let songFile = song.value["file"] as? String ?? "error"
                            songsArray.append(Song(name: songName, time: songTime, file: songFile))
                        }
                    }
                    self.albums.append(Album(name: name, image: image, songs: songsArray))
                }
            }
            else {
                print(error)
            }
        }
    }
}
