//
//  SendMusicView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 2/19/23.
//

import Foundation
import SwiftUI
import FirebaseStorage
import MobileCoreServices
import UIKit
import UniformTypeIdentifiers


struct SendMusicView: View {
    @State private var showingFilePicker = false
    @State private var selectedFile: URL?
    @ObservedObject var data: internalData
    
    var body: some View {
        VStack {
            Spacer()
            if let fileName = selectedFile?.lastPathComponent {
                Text("Selected file: \(fileName)")
                    .font(.headline)
                    .padding()
            }
            Button(action: {
                self.showingFilePicker = true
            }) {
                Text("Pick a file to upload")
            }.padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $showingFilePicker) {
                DocumentPickerView(showPicker: self.$showingFilePicker, selectedFile: self.$selectedFile)
            }
            Spacer()
        }
        .navigationTitle("Send Music")
        .navigationBarItems(trailing: Button(action: {
            if let url = selectedFile {
                uploadFileToFirebaseStorage(url: url, data: data)
            }
        }) {
            Image(systemName: "paperplane.fill")
                .font(.title)
        })
    }
    
    func uploadFileToFirebaseStorage(url: URL, data: internalData) {
        // Get a reference to the Firebase Storage bucket
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let fileName = url.lastPathComponent
        let fileRef = storageRef.child("uploads/\(fileName)")
        
        // Upload the file to the Firebase Storage bucket
        let uploadTask = fileRef.putFile(from: url, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading file: \(error.localizedDescription)")
            } else {
                print("File uploaded successfully!")
               // Song
                let song = Song(name: fileName, time: "0:00", file: "\(String(describing: metadata!.path))")
                // let downloadURL = metadata?.downloadURL()?.absoluteString ?? ""
                // song.url = downloadURL
                data.albums[0].songs.append(song)
            }
        }
    }

}

struct DocumentPickerView: UIViewControllerRepresentable {
    @Binding var showPicker: Bool
    @Binding var selectedFile: URL?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(showPicker: $showPicker, selectedFile: $selectedFile)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        
        let supportedTypes: [UTType] = [UTType.audio]
        let vc = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        vc.allowsMultipleSelection = false
        vc.delegate = context.coordinator
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
        // nothing to do here
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        @Binding var showPicker: Bool
        @Binding var selectedFile: URL?
        
        init(showPicker: Binding<Bool>, selectedFile: Binding<URL?>) {
            _showPicker = showPicker
            _selectedFile = selectedFile
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            selectedFile = urls.first
            showPicker = false
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            showPicker = false
        }
    }
}

