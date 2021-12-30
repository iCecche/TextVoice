//
//  TextVoiceIOSApp.swift
//  TextVoiceIOS
//
//  Created by amministratore on 30/04/2021.
//

import SwiftUI

@main
struct TextVoiceIOSApp: App {
    @StateObject var audio = audioTranscribe()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audio)
        }
    }
}
