//
//  RandomViewController.swift
//  QUIZ
//
//  Created by Марк Киричко on 20.02.2022.
//

import UIKit

class BaseQuizViewController: UIViewController {
    
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var Choice1: UIButton!
    @IBOutlet weak var Choice2: UIButton!
    @IBOutlet weak var Choice3: UIButton!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Attempts: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var RecordVideoLabeL: UILabel!
    @IBOutlet weak var PauseButton: UIButton!
    @IBOutlet weak var AnswersButton: UIButton!
    @IBOutlet weak var MusicButton: UIButton!
    
    var quiz: QuizBaseViewModel?
    var category: QuizModel?
    
    func BindViewModel() {
        quiz?.setQuizeModel(base: quiz ?? QuizPlanets())
        
        // Labels
        quiz?.questionTextStatus.bind({(questionTextStatus) in
            DispatchQueue.main.async {
                self.questionText.text = questionTextStatus
            }
        })
        
        quiz?.Score.value = self.Score
        
        quiz?.ScoreStatus.bind({(ScoreStatus) in
            DispatchQueue.main.async {
                self.Score.text = ScoreStatus
            }
        })
        
        quiz?.Time.value = self.Time
        
        quiz?.TimeStatus.bind({(TimeStatus) in
            DispatchQueue.main.async {
                self.Time.text = TimeStatus
            }
        })
        
        quiz?.TimeStatusColor.bind({(TimeStatusColor) in
            DispatchQueue.main.async {
                self.Time.textColor = TimeStatusColor
            }
        })
        
        quiz?.AttemptsStatusColor.bind({(AttemptsStatusColor) in
            DispatchQueue.main.async {
                self.Attempts.textColor = AttemptsStatusColor
            }
        })
        
        quiz?.Attempts.value = self.Attempts
        
        quiz?.AttemptsCountStatus.bind({(AttemptsCountStatus) in
            DispatchQueue.main.async {
                self.Attempts.text = AttemptsCountStatus
            }
        })
        
        quiz?.RecordVideoLabel.bind({(RecordVideoLabel) in
            DispatchQueue.main.async {
                self.RecordVideoLabeL = RecordVideoLabel
            }
        })
        
        quiz?.RecordVideoStatusColor.bind({RecordVideoStatusColor in
            DispatchQueue.main.async {
                self.RecordVideoLabeL.textColor = RecordVideoStatusColor
            }
        })
        
        // view
        quiz?.view = self.view
        quiz?.storyboard = self.storyboard
        quiz?.viewController = self
        
        // Choice 1,2,3 text
        quiz?.Choice1Status.bind({(Choice1Status) in
            DispatchQueue.main.async {
                self.Choice1.setTitle(Choice1Status, for: .normal)
            }
        })
        
        quiz?.Choice2Status.bind({(Choice2Status) in
            DispatchQueue.main.async {
                self.Choice2.setTitle(Choice2Status, for: .normal)
            }
        })
        
        quiz?.Choice3Status.bind({(Choice3Status) in
            DispatchQueue.main.async {
                self.Choice3.setTitle(Choice3Status, for: .normal)
            }
        })
        
        // Choice 1,2,3 color
        quiz?.Choice1StatusColor.bind({(Choice1StatusColor) in
            DispatchQueue.main.async {
                self.Choice1.backgroundColor = Choice1StatusColor
            }
        })
        
        quiz?.Choice2StatusColor.bind({(Choice2StatusColor) in
            DispatchQueue.main.async {
                self.Choice2.backgroundColor = Choice2StatusColor
            }
        })
        
        quiz?.Choice3StatusColor.bind({(Choice3StatusColor) in
            DispatchQueue.main.async {
                self.Choice3.backgroundColor = Choice3StatusColor
            }
        })
        
        quiz?.OnOffButtonStatusTitle.bind({OnOffButtonStatusTitle in
            DispatchQueue.main.async {
                self.MusicButton.setTitle(OnOffButtonStatusTitle, for: .normal)
            }
        })
        
        quiz?.AnswersButtonStatus.bind({(AnswersButtonStatus) in
            DispatchQueue.main.async {
                if self.AnswersButton != nil {
                    self.AnswersButton.setTitle(AnswersButtonStatus, for: .normal)
                }
            }
        })
        
        quiz?.OnOffButton.value = self.MusicButton
        
        quiz?.OnOffButtonStatus.bind({OnOffButtonStatus in
            DispatchQueue.main.async {
                self.MusicButton.setImage(UIImage(named: OnOffButtonStatus), for: .normal)
            }
        })
        
        // Image
        
        quiz?.ImageStatus.bind({(ImageStatus) in
            DispatchQueue.main.async {
                self.Image.image = UIImage(named: ImageStatus)
            }
        })
        
        // Gesture recognition
        
        quiz?.RecordVideoStatus.bind({(RecordVideoStatus) in
            DispatchQueue.main.async {
                self.RecordVideoLabeL.text = RecordVideoStatus
            }
        })
        
        quiz?.viewStatus.bind({(viewStatus) in
            DispatchQueue.main.async {
                self.view.backgroundColor = viewStatus
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BindViewModel()
        self.quiz?.quiz = category
        self.quiz?.SetQuizTheme()
        self.quiz?.checkHintsSetting(sender: AnswersButton)
        self.quiz?.checkGestureSetting()
        self.quiz?.checkSpeachSetting()
        self.quiz?.configureAudioSession()
        self.quiz?.checkAudioSetting()
        self.quiz?.checkTimerSetting()
        self.quiz?.checkAttemptsSetting()
        self.quiz?.isRecordingNow()
        self.quiz?.setupVision()
        self.quiz?.startTimer()
        self.quiz?.updateUI()
        self.quiz?.level()
        Image.layer.cornerRadius = Image.frame.size.width / 20
        Image.clipsToBounds = true
        PauseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        questionText.font = UIFont.boldSystemFont(ofSize: 20)
        Time.font = UIFont.boldSystemFont(ofSize: 15)
        Attempts.font = UIFont.boldSystemFont(ofSize: 15)
        Score.font = UIFont.boldSystemFont(ofSize: 15)
        AnswersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        Choice1.layer.cornerRadius = Choice1.frame.size.width / 10
        Choice1.clipsToBounds = true
        Choice1.layer.borderWidth = 5
        Choice1.layer.borderColor = UIColor.black.cgColor
        
        Choice2.layer.cornerRadius = Choice2.frame.size.width / 10
        Choice2.clipsToBounds = true
        Choice2.layer.borderWidth = 5
        Choice2.layer.borderColor = UIColor.black.cgColor
        
        Choice3.layer.cornerRadius = Choice3.frame.size.width / 10
        Choice3.clipsToBounds = true
        Choice3.layer.borderWidth = 5
        Choice3.layer.borderColor = UIColor.black.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quiz?.prepareCamera()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        quiz?.captureSession.stopRunning()
        quiz?.stopSpeechRecognition()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PauseTableViewController
        vc.currentcategory = category
        vc.currentquiz = quiz
        vc.score = quiz?.score ?? 100
        vc.questionNumber = (quiz?.questionNumber ?? 0) + 1
    }
    
    @IBAction func OpenCamera() {
        quiz?.OpenCamera()
    }
    
    @IBAction func SkipQuestion() {
        quiz?.SkipQuestion()
    }
    
    @IBAction func OnOffSound() {
        self.quiz?.OnOffSound()
    }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        self.quiz?.answerSelected(sender: sender)
    }
    
    @IBAction func PresentСategoryScreen() {
        performSegue(withIdentifier: "segue", sender: self)
        quiz?.player.Sound(resource: "pause_sound.mp3")
    }
    
    @IBAction func showAnswer() {
        quiz?.ShowAnswer()
    }
}

extension BaseQuizViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.quiz?.startRecognition()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as?
        UIImage else {
            return
        }
        quiz?.recognizeText(image: image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            picker.dismiss(animated: true, completion: nil)
            self.quiz?.startRecognition()
        }
    }
}
