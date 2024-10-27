//
//  test2.swift
//  RealSpotify
//
//  Created by 龙龙 on 2024/10/25.
//

import SpotifyWebAPI
import Foundation
import UIKit
import Logging
import Combine


class Spotify: ObservableObject {
    let api = SpotifyAPI(
    authorizationManager: AuthorizationCodeFlowManager(clientId: ProcessInfo.processInfo.environment["CLIENT_ID"] ?? "",
                                                       clientSecret: ProcessInfo.processInfo.environment["CLIENT_SECRET"] ?? "")
) 
    let loginCallbackURL = URL(string: "spotify-api-example-app://login-callback")!

    var cancellables: Set<AnyCancellable> = []
    
    @Published var isAuthorized = false

    init() {
        // 打日志，.trace详细级别
        self.api.apiRequestLogger.logLevel = .trace
        
        self.api.authorizationManagerDidChange
            .receive(on: RunLoop.main)
            .sink(receiveValue: authorizationManagerDidChange)
            .store(in: &cancellables)
    }
    
    func authorize() {
        let url = self.api.authorizationManager.makeAuthorizationURL(
            redirectURI: self.loginCallbackURL,
            showDialog: true,
            // 记录下下一步迭代是否使用state
            // state: <#T##String?#>
            scopes: [
                .playlistModifyPrivate,
                .userModifyPlaybackState,
                .playlistReadCollaborative,
                .userReadPlaybackPosition,
                .userLibraryRead
            ]
        )!
        
        UIApplication.shared.open(url)
    }
    
    func authorizationManagerDidChange() {
        print(
            "Spotify.authorizationManagerDidChange: isAuthorized:",
            self.api.authorizationManager.isAuthorized()
        )
    }
}


enum SpotifyAuthorizationError: Error{
    case invalidURL
    case missingClientCredentials
}
