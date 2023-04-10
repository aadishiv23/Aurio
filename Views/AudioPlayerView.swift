//
//  AudioPlayerView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 11/5/22.
//

import Foundation
import AVKit
import SwiftUI

struct AudioPlayerView: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var progress: CGFloat = 0.0
    @State private var playing: Bool = false
    @State var duration: Double = 0.0
    @State var formattedDuration: String = ""
    @State var formattedProgress: String = "00:00"
    var body: some View {
        HStack {
                Text(formattedProgress)
                    .font(.caption.monospacedDigit())

                // this is a dynamic length progress bar
                GeometryReader { gr in
                    Capsule()
                        .stroke(Color.blue, lineWidth: 2)
                        .background(
                            Capsule()
                                .foregroundColor(Color.blue)
                                .frame(width: gr.size.width * progress,
                                          height: 8), alignment: .leading)
                }
                .frame( height: 8)

                Text(formattedDuration)
                    .font(.caption.monospacedDigit())
        }
        .padding()
        .frame(height: 50, alignment: .center)
        
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView()
            .previewLayout(
                   PreviewLayout.fixed(width: 400, height: 300))
            .previewDisplayName("Default preview")
        AudioPlayerView()
            .previewLayout(
                    PreviewLayout.fixed(width: 400, height: 300))
            .environment(\.sizeCategory, .accessibilityExtraLarge)
    }
}
