//
//  ViewController.swift
//  speechEmotionRecognitionApp
//  Copyright © 2018 Simran Dhillon. All rights reserved.


/* Main View Controller
   Application starts at this page
   User can start their interaction at this page
 */

import UIKit
import Speech

class ViewController: UIViewController  {
    
    //selectionButton is used to select a clip for transcription and analysis
    //Pressing the select button leads to the resultsViewControllerPage
    @IBOutlet weak var selectionButton: UIButton!
    //recordButton is used to record user input from mic
    @IBOutlet weak var recordButton: UIButton!
    //stopRecordButton is used to stop user recording
    @IBOutlet weak var stopRecordButton: UIButton!
    //textbox to show what user is currently recording
    @IBOutlet weak var userRecordedText: UITextView!
    
    //current recording object
    var currentRecording: Recording = Recording()
    //update function is called when notifications are posted from the speechToText Model
    //Views are updated
    @objc func update() {
        print("Receiving notification from Model")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get authorization for speech
        self.authorizeSpeechRecognition()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeRecordingToBusy), name: .recordingNow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeRecordingToDone), name: .recordingFinished, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func authorizeSpeechRecognition() {
        SFSpeechRecognizer.requestAuthorization { authStatus in OperationQueue.main.addOperation {
            switch authStatus {
            case .authorized:
                self.selectionButton.isEnabled = true
            case .denied:
                self.selectionButton.isEnabled = false
                self.selectionButton.setTitle("User has denied access to speech recognition.", for: .disabled)
            case .restricted:
                self.selectionButton.isEnabled = false
                self.selectionButton.setTitle("Speech recognition restricted on this device.", for: .disabled)
            case .notDetermined:
                self.selectionButton.isEnabled = false
                self.selectionButton.setTitle("Speech recognition not authorized.", for: .disabled)
            }
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Sending clip info to results VC")
        if segue.destination is ResultsViewController {
            let vc = segue.destination as? ResultsViewController
            let resultObject: AnalyzedResults = AnalyzedResults()
            resultObject.transcribedText = currentRecording.userTranscription
            vc?.results = resultObject
            vc?.currentClip = currentRecording.userTranscription
            vc?.transcriptionType = "Record"
            
        }
    } 
    
    @IBAction func startRecordingPressed(_ sender: UIButton) {
        print("Start button pressed")
        //create new recording object
        let alert = UIAlertController(title: "Recording Started", message: "Click stop when finished.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        self.currentRecording = Recording()
        do {
            try self.currentRecording.startRecording()
        }  catch   {
            print("There was a problem starting recording")
        }
    }
    
    @IBAction func stopRecordingPressed(_ sender: UIButton) {
        self.currentRecording.stopRecording()
        let alert = UIAlertController(title: "Recording Done", message: "Click analyze to see results.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func changeRecordingToBusy(){
        userRecordedText.text = currentRecording.userTranscription
        print("Recording now")
    }
    
    @objc func changeRecordingToDone() {
        print("Recording Finished")
    }
    
    //func to show alert if recording is currently occuring
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("Segue Performing")
        var toReturn = true
        if (currentRecording.getIsRecording()) {
            toReturn  = false
            let alert = UIAlertController(title: "Recording Now", message: "Currently recording in progress", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            toReturn = true
        }
        return toReturn
    }
    
}


