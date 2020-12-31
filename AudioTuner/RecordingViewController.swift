//
//  RecordingViewController.swift
//  AudioTuner
//
//  Created by Eric Castronovo on 12/6/20.
//

import UIKit
import AVFoundation

class RecordingViewController: UIViewController, AVAudioRecorderDelegate{
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    // MARK: PlayingState (raw values correspond to sender tags)
    
    enum RecordingState { case recording, notRecording }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
    }

    @IBAction func record(_ sender: Any) {
        configureUI(.recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath as Any)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.delegate = self
        audioRecorder.stop()
        configureUI(.notRecording)
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording not successful")
        }
        
    }
    
    func configureUI(_ recordState: RecordingState) {
        switch(recordState) {
        case .recording:
            recordingLabel.text = "Recording in progress..."
            recordButton.isEnabled = false
            stopRecordingButton.isEnabled = true
            
            
        case .notRecording:
            recordingLabel.text = "Tap to record"
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsViewController = segue.destination as! PlaySoundsViewController
            let recordAudioURL = sender as! URL
            playSoundsViewController.recordedAudioURL = recordAudioURL
        }
    }
}

