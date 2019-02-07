//
//  resultsViewController.swift
//  speechEmotionRecognitionApp
//  Copyright © 2018 Simran Dhillon. All rights reserved.
//

/*  Results screen shows final analysis results
 */

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    
    var currentClip: String = ""
    var results: AnalyzedResults = AnalyzedResults()
    var transcription: SpeechToText = SpeechToText()
    
    //transcription type is either recorded or prerecorded
    var transcriptionType: String = ""
    
    @IBOutlet weak var resultAnalysisTextBox: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(updateAnalysisBox), name: .analyzingNow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAnalysisBox), name: .analysisDone, object: nil)
        print(" Transcription Type: \(self.transcriptionType)")
        do {
            try results.detectEmotions()
        } catch {
            print("some error")
        }
    }
    
    @objc func updateAnalysisBox(){
        print("updating view")
        self.resultAnalysisTextBox.text = results.analysisResults
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
