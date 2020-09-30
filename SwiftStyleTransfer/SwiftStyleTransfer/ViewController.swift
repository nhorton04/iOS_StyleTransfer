//
//  ViewController.swift
//  SwiftStyleTransfer
//
//  Created by Nick Horton on 9/30/20.
//

import UIKit
import AVFoundation
import CoreML

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    var model: FNS_Mosaic_1!
    
    var captureSession: AVCcaptureSession?
    var rearCamera: AVCaptureDevice?
    var rearCameraInput: AVCaptureDeviceInput?
    var videoOutput: AVCaptureVideoDataOutput?
    
    var latestImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = FNS_Mosaic_1()
        
        self.captureSession = AVCaptureSession()
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        self.rearCamera = session.devices.first
        
        if let rearCamera = self.rearCamera {
            try? rearCamera.lockForConfiguration()
            rearCamera.focusMode = .autoFocus
            rearCamera.unlockForConfiguration()
        }
        
        if let rearCamera = self.rearCamera {
            self.rearCameraInput = try? AVCaptureDeviceInput(device: rearCamera)
            if let rearCameraInput = rearCameraInput {
                if captureSession!.canAddInput(rearCameraInput) {
                    captureSession?.addInput(rearCameraInput)
                }
            }
        }
        
        self.videoOutput = AVCaptureVideoDataOutput()
        self.videoOutput!.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer"))
        
        if captureSession!.canAddOutput(self.videoOutput!) {
            captureSession?.addOutput(self.videoOutput!)
        }
    
        self.captureSession?.startRunning()
        
        showStylized()
        }
        
        }
    }




