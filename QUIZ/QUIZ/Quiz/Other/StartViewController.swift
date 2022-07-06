//
//  StartViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 19.03.2022.
//

import UIKit
import AVFoundation
import AVKit
import Vision
import Firebase

enum RemoteCommand: String {
    case none
    case open = "FIVE-UB-RHand"
    case fist = "fist-UB-RHand"
}

class StartViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var TodayQuizButton: UIButton!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var TitleName: UILabel!
    
    // камера
    let captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice!
    var devicePosition: AVCaptureDevice.Position = .front
    
    // видинье
    var requests = [VNRequest]()
    
    
    let bufferSize = 3
    var commandBuffer = [RemoteCommand]()
    var currentCommand: RemoteCommand = .none {
        didSet {
            commandBuffer.append(currentCommand)
            if commandBuffer.count == bufferSize {
                if commandBuffer.filter({$0 == currentCommand}).count == bufferSize {
                    //showAndSendCommand(currentCommand)
                    
                }
                commandBuffer.removeAll()
            }
        }
    }
    
//    func setupPlayer() {
//        playerView.setPlayerURL(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
//        //playerView.player.play()
//    }
    
//    func showAndSendCommand(_ command: RemoteCommand) {
//
//        DispatchQueue.main.async {
//            if command == .open {
//
//            } else if command == .fist {
//           
//            }
//
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupVision()
        //setupPlayer()
        
        StartButton.layer.cornerRadius = StartButton.frame.size.width / 10
        StartButton.clipsToBounds = true
        StartButton.flash()
        
        StartButton.layer.borderWidth = 2
        StartButton.layer.borderColor = UIColor.black.cgColor
        
        TodayQuizButton.layer.cornerRadius = TodayQuizButton.frame.size.width / 10
        TodayQuizButton.clipsToBounds = true
        
        TodayQuizButton.layer.borderWidth = 2
        TodayQuizButton.layer.borderColor = UIColor.black.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GoToQuizApp))
        self.StartButton.isUserInteractionEnabled = true
        self.StartButton.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(GoToRandomQuiz))
        self.TodayQuizButton.isUserInteractionEnabled = true
        self.TodayQuizButton.addGestureRecognizer(tap2)
    }
    
    
    var quizes = [QuizPlanets(), QuizHistory(), QuizAnatomy(), QuizSport(), QuizGames(), QuizIQ(), QuizEconomy(), QuizGeography(), QuizEconomy(), QuizPhysics(), QuizChemistry(), QuizInformatics()]
    
    
    @objc func GoToRandomQuiz() {
        var randomindex = Int.random(in: 0..<quizes.count)
        var c = quizes[randomindex]
        goToQuize(quiz: c)
    }
    
    
    func goToQuize(quiz: QuizBase) {
       DispatchQueue.main.async {
           guard let vc = self.storyboard?.instantiateViewController(identifier: "BaseQuizViewController") else {return}
           (vc as? BaseQuizViewController)?.setQuizeModel(quiz: quiz)
           guard let window = self.view.window else {return}
           window.rootViewController = vc
          }
     }
    
    
    @objc func GoToQuizApp() {
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") else {return}
            guard let window = self.view.window else {return}
            window.rootViewController = vc
       }
    }

}

extension StartViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func setupVision() {
        guard let visionModel = try? VNCoreMLModel(for: example_5s0_hand_model().model) else {fatalError("не работает ml")}
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification)
        classificationRequest.imageCropAndScaleOption = .centerCrop
        
        self.requests = [classificationRequest]
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        let exifOrientation = self.exitOrientationFromDeviceOrientation()
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    func prepareCamera() {
        let avaliableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices
        captureDevice = avaliableDevices.first
        beginSession()
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print("Could not create video device input")
            return
        }
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .vga640x480
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCGImagePropertyDNGBlackLevelDeltaH as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        
        captureSession.startRunning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareCamera()
    }
    
    func handleClassification (request: VNRequest, error: Error?) {
        guard let observations = request.results else {print("no results"); return}
        
        let classifications = observations
            .compactMap({$0 as? VNClassificationObservation})
            .filter({$0.confidence > 0.5})
            .map({$0.identifier})
        
        print(classifications)
        
        switch classifications.first {
            
        case "None":
            currentCommand = .none
        
        case "FIVE-UB-RHand":
            currentCommand = .open
            
            DispatchQueue.main.async {
                self.LoadInfo()
               }
            
//        case "fist-UB-RHand":
//            currentCommand = .fist
//
//            DispatchQueue.main.async {
//                self.StartButton.sendActions(for: .touchUpInside)
//                self.GoToRandomQuiz()
//            }
            
        default:
            currentCommand = .none
        }
    }
    
    
    func LoadInfo() {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(Auth.auth().currentUser?.email ?? "mystery123@gmail.com")
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            }
            else {
                if let document = document {
                    let data = document.data()
                    //let email = data?["email"] as? String ?? ""
                    //let password = data?["password"] as? String ?? ""
                    let image = data?["image"] as? String ?? ""
                    let name = data?["name"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        let imageURL = URL(string: image ?? "")
                        self.Image.sd_setImage(with: imageURL)
                        self.TitleName.text = ("Здравствуйте \(name)!")
                        self.TitleName.font = UIFont(name: "System Bold", size: 13)
                        print("Фотка \(image)")
                    }
                }
            }
        }
    }
    
    func exitOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        
        case UIDeviceOrientation.portraitUpsideDown:
            exifOrientation = .left
        
        case UIDeviceOrientation.landscapeLeft:
            exifOrientation = .upMirrored
            
        case UIDeviceOrientation.landscapeRight:
            exifOrientation = .down
            
        case UIDeviceOrientation.portrait:
            exifOrientation = .up
        
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
    
}
