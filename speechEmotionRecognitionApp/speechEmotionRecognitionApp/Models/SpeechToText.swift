//
//  speechToText.swift
//  speechEmotionRecognitionApp
//  Copyright © 2018 Simran Dhillon. All rights reserved.
//

/*  SpeechToText transcribes "clips", i.e. mp3 audio files to be transcribed
 */

import Foundation
import Speech

class SpeechToText {
    
    var speechRecognizer: SFSpeechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    
    var fileName: String = ""
    var clipURL: URL? = nil
    var transcribedClip: String = ""
    
    //notificationCenter is used to inform the controller about any state changes, i.e. clip transcribed or not
    let notificationCenter: NotificationCenter
    
    init(notificationCenter: NotificationCenter = .default){
        self.notificationCenter = notificationCenter
    }

    func transcribe(_ fileToLoad: String) {
        print("TRANSCRIBING FILE: ")
        print(fileToLoad)
        //var transcriptionToReturn: SFTranscription? = nil
        self.clipURL = Bundle.main.url(forResource: fileToLoad, withExtension: .none)!
        let request = SFSpeechURLRecognitionRequest(url: clipURL!)
        
        self.speechRecognizer.recognitionTask(with: request) {
            (result, _) in if let transcription = result?.bestTranscription {
                print(transcription.formattedString)
                self.transcribedClip = transcription.formattedString
                self.notificationCenter.post(name: .transcribingNow, object: nil)
            }
            
        }
    }
    
}

// The speechToText object has multiple states:
// (1): transcribing: app is currently transcribing a clip
// (2): Finished transcribing

extension Notification.Name {
    static let transcriptionFinished = Notification.Name("transcriptionFinished")
    static let transcribingNow = Notification.Name("transcribingNow")

}
