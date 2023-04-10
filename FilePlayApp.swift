//
//  FilePlayApp.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 6/18/22.
//


import SwiftUI
import Firebase
import AVKit



@main
struct FilePlayApp: App {
    // configures the firebase database and loads the data from the internaldata
    // object
   // @Binding var isPlayerViewPresented: Bool = projectedValue

    let data = internalData()
    init() {
        FirebaseApp.configure()
        
        // loads albums in once at the start of the application
        data.loadAlbums()
        // self.isPlayerViewPresented = false
        // Firestore.enableLogging(true)
    }
    
    var body: some Scene {
        
        WindowGroup {
           // ContentView(data: data, isPlayerViewPresented: $isPlayerViewPresented)
            //ContentView(data: <#T##internalData#>, isPlayerViewPresented: <#T##Bool#>)
            ContentView(data: data)
        }
    }
}


