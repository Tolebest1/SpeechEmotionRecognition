//
//  analyzedResults.swift
//  speechEmotionRecognitionApp
//  Copyright © 2018 Simran Dhillon. All rights reserved.
//

//analyzedResults is used after a prerecorded audio file or recorded speech is analyzed for sentiment
//This class contains transcribed text and classification results

import Foundation
import CoreML

class AnalyzedResults {
    
    //transcribedText is the user's speech transcribed into text
    var transcribedText: String = ""
    //All results of analysis, i.e. probabilities for all emotion categories
    var analysisResults: String = ""
    //sentiment, i.e. highest probabilitiy emotion category
    var sentiment: String = ""
    //emotion dector converts the words_array into tf-idf form
    var emotionDetected: emotionDetector = emotionDetector()
    //SVM that takes the tf-idf corpus
    let model: tfidf_svm_crowdflower = tfidf_svm_crowdflower()
    var notificationCenter: NotificationCenter
    
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    func detectEmotions() throws {
        print("Detecting emotions")
        //the transcribed text has features extracted from it using tf-idf
        let vector = emotionDetected.tfidf(sentence: self.transcribedText)
        print(vector.capacity)
        //convert above vector into multiarray to use as a input for the model
        let mlarray = emotionDetected.multiarray(vector)
        
        do {
            print(self.transcribedText)
            //print(mlarray.count)
            let res = try model.prediction(content: mlarray)
            self.sentiment = res.sentiment
            print(res.sentiment)
            print(res.classProbability)
            print("\tSentiment: " + self.sentiment)
            self.analysisResults = "\nEmotion: " + res.sentiment + " \n\nEmotion Probabilities: \n"+" "+res.classProbability.description
            self.notificationCenter.post(name: .analyzingNow, object: nil)
        }  catch   {
            print("There was a problem")
        }
        self.notificationCenter.post(name: .analysisDone, object: nil)
    }
}

extension Notification.Name {
    static let analyzingNow = Notification.Name("analyzingNow")
    static let analysisDone = Notification.Name("analysisDone")
}
