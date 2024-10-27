//
//  ContentView.swift
//  RealSpotify
//
//  Created by 龙龙 on 2024/8/17.
//

import SwiftUI
import CoreData
import BetterSafariView
import SpotifyWebAPI
import Combine


struct LoginView: View {
    @EnvironmentObject var spotify: Spotify
    
    
    
    var body: some View {
        HStack{
            spotifybutton
        }
        
    }
    
    var spotifybutton: some View {
        ButtonView(text: "登录", image: "star")
    }
}

#Preview {
    LoginView()
}
