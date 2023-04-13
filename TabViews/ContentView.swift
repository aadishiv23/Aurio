//
//  ContentView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 6/18/22.
//

import SwiftUI
import Firebase
import AVKit

// Hashable for hash value (ref: 281 hash lecture)
// DONT CHANGE THIS NO MATTER WHAT AADI PLS DONT TRY
// is good for speed    
struct Album : Hashable {
    var id = UUID()
    var name : String
    var image : String
    var songs : [Song]
}

// think if any other data is needed
// time as Double or CGTime would be good for the future
// better slider
struct Song : Hashable {
    var id = UUID()
    var name : String
    var time : String
    var file : String
}
struct ContentView: View {
    @ObservedObject var data : internalData
    @State var isPlayerViewPresented: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView() {
                UploadedMusicView(data: data).tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                        .accessibilityLabel("Streamed music window")
                        .accessibilityHint("By pressing the home icon, you will be able to access the Uploaded Music page and be able to browse and stream music")
                }
                LocalMusicView().tabItem() {
                    Image(systemName: "folder")
                    Text("Files")
                        .accessibilityLabel("Local files window")
                        .accessibilityHint("By pressing the files icon, you will be able to import local files and be able to upload them to the cloud. From there, you will then be able to listen to your songs through the Uploaded Music page")
                }
            }
            .navigationBarHidden(true)
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)

            TestView()
                //.background(Color.white)
                .offset(y: -48) // replace `TabViewHeight` with the height of the TabView
        }
    }
}


/*struct ContentView: View {
    @ObservedObject var data : internalData
    @State var isPlayerViewPresented: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView() {
                UploadedMusicView(data: data).tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                        .accessibilityLabel("Streamed music window")
                        .accessibilityHint("By pressing the home icon, you will be able to access the Uploaded Music page and be able to browse and stream music")
                }
                LocalMusicView().tabItem() {
                    Image(systemName: "folder")
                    Text("Files")
                        .accessibilityLabel("Local files window")
                        .accessibilityHint("By pressing the files icon, you will be able to import local files and be able to upload them to the cloud. From there, you will then be able to listen to your songs through the Uploaded Music page")
                }
            }
            .navigationBarHidden(true)
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)

            TestView()
                .background(Color.white)
        }
    }
}*/

/*struct ContentView: View {
    @ObservedObject var data : internalData
    @State var isPlayerViewPresented: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
           // TestView()
            ZStack {
                TabView() {
                    UploadedMusicView(data: data).tabItem() {
                        Image(systemName: "house")
                        Text("Home")
                            .accessibilityLabel("Streamed music window")
                            .accessibilityHint("By pressing the home icon, you will be able to access the Uploaded Music page and be able to browse and stream music")
                    }
                    LocalMusicView().tabItem() {
                        Image(systemName: "folder")
                        Text("Files")
                            .accessibilityLabel("Local files window")
                            .accessibilityHint("By pressing the files icon, you will be able to import local files and be able to upload them to the cloud. From there, you will then be able to listen to your songs through the Uploaded Music page")
                    }
                }
                .zIndex(0) // set the z-index of the TabView to 0
                .navigationBarHidden(true) // hide navigation bar to occupy full screen
                .background(Color.white) // set the background color of the TabView to white
                .edgesIgnoringSafeArea(.bottom) // ignore bottom safe area to occupy full screen
                .padding(.bottom, 50) // Add padding to the bottom of the TabView to make space for the TestView
                //Spacer()
                TestView()
                    .zIndex(1) // set the z-index of the TestView to 1 to display it above the TabView
                    .background(Color.white) // add a white background to the TestView

            }

        }
    }
}*/



struct ContentView_Provider: PreviewProvider {
    static var previews: some View {
        Text("hello word!")
    }
}



