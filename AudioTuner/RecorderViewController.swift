//
//  RecorderViewController.swift
//  AudioTuner
//
//  Created by Eric Castronovo on 12/6/20.
//

import UIKit

class RecorderViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View Will Appear")
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
    }

    @IBAction func record(_ sender: Any) {
        print("Record")
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        recordingLabel.text = "Recording in progress..."
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop Recording")
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        recordingLabel.text = "Tap to record"
    }
}

