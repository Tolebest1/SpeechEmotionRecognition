  //
//  recording.swift
//  speechEmotionRecognitionApp
//  Copyright © 2018 Simran Dhillon. All rights reserved.
//

import Foundation
import AVFoundation
import Speech
import CoreData

/* The recording class is used when user's record their own audio clips via mic
   The recorded file's string transcription is used for analysis
*/
  
class Recording {

    var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))  
    var task: SFSpeechRecognitionTask? = SFSpeechRecognitionTask()
    var audioEngine = AVAudioEngine()
    var request: SFSpeechAudioBufferRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var mostRecentSegment: TimeInterval = 0
    var userTranscription: String = ""
    let notificationCenter: NotificationCenter
    var isRecording: Bool = false
    
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
  
    //starts recording user input
    func startRecording() throws {
        isRecording = true
        let input = audioEngine.inputNode
        let format = input.outputFormat(forBus: 0)
        input.installTap(onBus: 0, bufferSize: 1024, format: format) {
            [unowned self] (buffer, _) in self.request.append(buffer)
        }
        audioEngine.prepare()
        try! audioEngine.start()
        
        task = speechRecognizer?.recognitionTask(with: request) {
            (result, _) in if let transcription = result?.bestTranscription {
                self.userTranscription = transcription.formattedString
                print(self.userTranscription)
                self.notificationCenter.post(name: .recordingNow, object: nil)
            }
        }
    }
    
    //stops recording user input
    func stopRecording() {
        audioEngine.stop()
        request.endAudio()
        task?.cancel()
        notificationCenter.post(name: .recordingFinished, object: nil)
        isRecording = false
    }
    
    func getIsRecording() -> Bool {
        return isRecording
    }
    
}
//Notification Extensions
extension Notification.Name {
    static let recordingNow = Notification.Name("recordingNow")
    static let recordingFinished = Notification.Name("recordingFinished")
}
