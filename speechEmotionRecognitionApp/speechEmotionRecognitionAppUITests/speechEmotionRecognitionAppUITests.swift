//
//  speechEmotionRecognitionAppUITests.swift
//  speechEmotionRecognitionAppUITests
//
//  Created by Simran Dhillon on 8/15/18.
//  Copyright © 2018 Simran Dhillon. All rights reserved.
//

import XCTest

class speechEmotionRecognitionAppUITests: XCTestCase {
    
    let application = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        startApp()
    }
 
    
    //main test calls other stuff
    func startApp() {
        /*  Press Record Button, then press stop button, and go to results
         */
        pressRecordButton()
        pressStopRecordingButton()
        pressAnalyzeAfterRecordingFinished()
        
        pressRecordButton()
        pressAnalyzeDuringRecording()
        pressStopRecordingButton()
        
    }
    
    func pressRecordButton() {
        let recordButton = application.buttons["recordButton"]
        recordButton.tap()
        print("pressed record button")
        XCTAssert(application.staticTexts["Recording Started"].exists)
    }
    
    func pressAnalyzeButton() {
        let analyzeButton = application.buttons["selectionButton"]
        analyzeButton.tap()
    }
    
    func pressAnalyzeDuringRecording() {
        pressRecordButton()
        pressAnalyzeButton()
        XCTAssert(application.staticTexts["Recording Now"].exists)
    }
    
    func pressAnalyzeAfterRecordingFinished() {
        pressRecordButton()
        pressStopRecordingButton()
        //close the alert box
        XCTAssert(application.staticTexts["Recording Done"].exists)
    }
    
    func pressStopRecordingButton() {
        let stopButton = application.buttons["stopButton"]
        stopButton.tap()
    }

    
    
    
}
