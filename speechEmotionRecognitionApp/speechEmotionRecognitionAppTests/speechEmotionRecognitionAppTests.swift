//
//  speechEmotionRecognitionAppTests.swift
//  speechEmotionRecognitionAppTests
//
//  Created by Simran Dhillon on 8/15/18.
//  Copyright © 2018 Simran Dhillon. All rights reserved.
//

import XCTest
@testable import speechEmotionRecognitionApp

class speechEmotionRecognitionAppTests: XCTestCase {
    
    let results = AnalyzedResults()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /*  Tests the SVM classifier for emotion recognition
        by providing statements
     */
    func testAnalzyedResults() {
       
    }
    
    func testHappyStatement() {
        let text = "Happy happy happy"
        results.transcribedText = text
        do {
            try results.detectEmotions()
        } catch {
            print("some error")
        }
        let analysis = results.analysisResults
        print("Sentiment for transcribed text:: "+results.sentiment)
        XCTAssert(results.sentiment == "happiness")
    }
    
    func testSadStatement() {
        let text = "Sad Sad Sad"
        results.transcribedText = text
        do {
            try results.detectEmotions()
        } catch {
            print("some error")
        }
        let analysis = results.analysisResults
        print("Sentiment for transcribed text:: "+results.sentiment)
        XCTAssert(results.sentiment == "sadness")
    }
    
    func testNeutralStatement() {
        let text = "this is a statement"
        results.transcribedText = text
        do {
            try results.detectEmotions()
        } catch {
            print("some error")
        }
        let analysis = results.analysisResults
        print("Sentiment for transcribed text:: "+results.sentiment)
        XCTAssert(results.sentiment == "worry")
    }
    
}
