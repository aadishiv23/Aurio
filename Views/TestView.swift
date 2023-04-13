//
//  TestView.swift
//  FilePlay
//
//  Created by Aadi Shiv Malhotra on 4/13/23.
//

import Foundation
import SwiftUI

struct TestView: View{
    var body : some View {
        ZStack {
            Rectangle().foregroundColor(Color.white).frame(width: UIScreen.main.bounds.size.width, height: 65).opacity(0.95)
            //Blur(style: .systemChromeMaterialDark).edgesIgnoringSafeArea(.all)
            HStack {
                Button(action: {}) {
                    HStack {
                        Image("album1").resizable().frame(width: 45, height: 45).shadow(radius: 6, x: 0, y: 3).padding(.leading)
                        Text("After Hours").padding(.leading, 10)
                        Spacer()
                    }
                }.buttonStyle(PlainButtonStyle())
                Button(action: {}) {
                    Image(systemName: "play.fill").font(.title3)
                }.buttonStyle(PlainButtonStyle()).padding(.horizontal)
                Button(action: {}) {
                    Image(systemName: "forward.fill").font(.title3)
                }.buttonStyle(PlainButtonStyle()).padding(.trailing, 30)
            }
        }
    }
}


/*struct TestView: View{
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white.opacity(0.7))
                .frame(width: UIScreen.main.bounds.size.width, height: 65)
                .overlay(
                    HStack {
                        Button(action: {}) {
                            HStack {
                                Image("album1").resizable().frame(width: 45, height: 45).shadow(radius: 6, x: 0, y: 3).padding(.leading)
                                Text("After Hours").padding(.leading, 10)
                                Spacer()
                            }
                        }.buttonStyle(PlainButtonStyle())
                        Button(action: {}) {
                            Image(systemName: "play.fill").font(.title3)
                        }.buttonStyle(PlainButtonStyle()).padding(.horizontal)
                        Button(action: {}) {
                            Image(systemName: "forward.fill").font(.title3)
                        }.buttonStyle(PlainButtonStyle()).padding(.trailing, 30)
                    }
                )
        }
        .padding(.bottom, UIWindowScene.windows.first?.safeAreaInsets.bottom ?? 0)
        //.padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
    }
}*/



/*struct TestView: View{
    var body : some View {
        ZStack {
            Rectangle().foregroundColor(Color.white.opacity(0.0)).frame(width: UIScreen.main.bounds.size.width, height: 65)
            //Blur(style: .systemChromeMaterialDark).edgesIgnoringSafeArea(.all)
            HStack {
                Button(action: {}) {
                    HStack {
                        Image("album1").resizable().frame(width: 45, height: 45).shadow(radius: 6, x: 0, y: 3).padding(.leading)
                        Text("After Hours").padding(.leading, 10)
                        Spacer()
                    }
                }.buttonStyle(PlainButtonStyle())
                Button(action: {}) {
                    Image(systemName: "play.fill").font(.title3)
                }.buttonStyle(PlainButtonStyle()).padding(.horizontal)
                Button(action: {}) {
                    Image(systemName: "forward.fill").font(.title3)
                }.buttonStyle(PlainButtonStyle()).padding(.trailing, 30)
            }
        }
    }
}
*/
