//
//  HomeViewController.swift
//  Learn IOS AM
//
//  Created by IT-Mobile-Dev on 02/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var txtScore: UILabel!
    @IBOutlet weak var txtQuestion: UILabel!
    @IBOutlet weak var btn1Choice: UIButton!
    @IBOutlet weak var labelChoice1: UILabel!
    @IBOutlet weak var btn2Choice: UIButton!
    @IBOutlet weak var labelChoice2: UILabel!
    
    @IBOutlet weak var btn3Choice: UIButton!
    @IBOutlet weak var btn4Choice: UIButton!
    var question = ResponseDetail()
    let viewModel = HomeViewModel()
    let loadRelay = BehaviorRelay<Void>(value: ())
    let disposeBag = DisposeBag()
    var correctAnswer = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trivia"
        
        self.loadQuestion()

        // Do any additional setup after loading the view.
    }
    
    func loadQuestion(){
        let output = viewModel.getNextQuestion(input: HomeViewModel.Input(loadRelay: self.loadRelay.asDriver()
        ))
        
        output.data.drive(onNext: { [weak self] data in
            let encodedString = data.question ?? ""

            guard let str = encodedString.data(using: .utf8) else {
                return
            }

            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]

            guard let attributedString = try? NSAttributedString(data: str, options: options, documentAttributes: nil) else {
                return
            }

            // The Weeknd ‘King Of The Fall’
            let decodedString = attributedString.string
            self?.txtQuestion.text = decodedString
            var choice: [String?] = []
            choice.append(data.correctChoice)
            choice.append(contentsOf: data.wrongChoice ?? ["","",""])
            choice.shuffle()
            self?.labelChoice1.text = choice[0]
            self?.labelChoice2.text = choice[1]
            self?.btn3Choice.setTitle( choice[2], for: .normal)
            self?.btn4Choice.setTitle( choice[3], for: .normal)
            for (i,x) in choice.enumerated(){
                if(x == data.correctChoice){
                    self?.correctAnswer = i+1
                }
            }
        }).disposed(by: self.disposeBag)
        loadRelay.accept(())
    }

    @IBAction func btn1OnClick(_ sender: Any) {
        if(correctAnswer == 1){
            score+=1
        }else{
            score-=1
        }
        self.txtScore.text = "Score: \(score)"
        loadRelay.accept(())
    }
    
    @IBAction func btn2OnClick(_ sender: Any) {
        if(correctAnswer == 2){
            score+=1
        }else{
            score-=1
        }
        self.txtScore.text = "Score: \(score)"
        loadRelay.accept(())
    }
    
    @IBAction func btn3OnClick(_ sender: Any) {
        if(correctAnswer == 3){
            score+=1
        }else{
            score-=1
        }
        self.txtScore.text = "Score: \(score)"
        loadRelay.accept(())
    }
    
    @IBAction func btn4OnClick(_ sender: Any) {
        if(correctAnswer == 4){
            score+=1
        }else{
            score-=1
        }
        self.txtScore.text = "Score: \(score)"
        loadRelay.accept(())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
