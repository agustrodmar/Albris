//
//  AudioManager.swift
//  Albris
//
//  Created by Agustín Rodríguez Márquez on 27/7/24.
//

import AVFoundation

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    
    private var player: AVAudioPlayer?
    @Published var isPlaying = false
    
    private init() {
        guard let url = Bundle.main.url(forResource: "tetris", withExtension: "mp3") else {
            print("Error: Could not find tetris.mp3")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Loop indefinitely
        } catch {
            print("Error: Could not initialize AVAudioPlayer: \(error)")
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
}

