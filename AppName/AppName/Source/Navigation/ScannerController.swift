//
//  NavigationController.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import AVFoundation
import UIKit

class ScannerController : UIViewController, AVCaptureMetadataOutputObjectsDelegate {
	
	var captureSession: AVCaptureSession?
	var cameraFeedLayer: AVCaptureVideoPreviewLayer?
	var barcodeFrame: UIView?
	
	@IBOutlet var scannerFrameView: ScannerView!
	@IBOutlet var statusMessage: UILabel!
	
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		statusMessage.isHidden = true
		
		let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
		
		guard let camera = discoverySession.devices.first else {
			print("The camera is not available")
			return
		}
		
		do {
			let input = try AVCaptureDeviceInput(device: camera)
			
			captureSession = AVCaptureSession()
			captureSession!.addInput(input)
			
			let captureMetadataOutput = AVCaptureMetadataOutput()
			captureSession!.addOutput(captureMetadataOutput)
			
			captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
			//set the barcode types we want to scan
			captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean13]
			
			cameraFeedLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
			cameraFeedLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
			cameraFeedLayer?.frame = view.layer.bounds
			view.layer.addSublayer(cameraFeedLayer!)
			
			captureSession?.startRunning()
			
			barcodeFrame = UIView()
			if let barcodeFrame = barcodeFrame{
				barcodeFrame.layer.borderColor = UIColor.blue.cgColor
				barcodeFrame.layer.borderWidth = 2
				view.addSubview(barcodeFrame)
				view.bringSubview(toFront: barcodeFrame)
			}
			
			
		} catch {
			
			print(error)
			return
		}
		
	}
	
	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		
		if metadataObjects.count == 0 {
			barcodeFrame?.frame = CGRect.zero
			statusMessage.text = "Detecing code, hold steady..."
			 return
			
		}
		
		let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
		
		if metadataObj.type == AVMetadataObject.ObjectType.ean13 {
			
			let barcodeObject = cameraFeedLayer?.transformedMetadataObject(for: metadataObj)
			barcodeFrame?.frame = barcodeObject!.bounds
			
			if metadataObj.stringValue != nil {
				statusMessage.text = " Scan completed, loading patient's order status.."
				statusMessage.backgroundColor = UIColor.green
				
				//TODO: pass scanned value to presented search controller
				//let latestScannedID = metadataObj.stringValue
				//let searchController: SearchViewController
				
				//we probably want to send an ID that is related to the barcode rather than a barcode directly, but for now we search the raw barcode and present the search view
				//searchController.searchInputText = metadataObj.stringValue!
				performSegue(withIdentifier: "searchScannedId", sender: self)
			}
			
		}
		
	}

}
