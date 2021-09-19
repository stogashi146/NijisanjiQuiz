//
//  QuizViewController.swift
//  SampleQuiz
//
//  Created by 富樫駿 on 2021/09/18.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    
    //問題を格納する配列を宣言
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("選択したのはレベル\(selectLevel)")

        csvArray = loadCSV(fileName: "quiz\(selectLevel)")
        csvArray.shuffle()
        quizNumberLabel.text = "第１問"
        // 1問目を代入
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    //　正解数correctCountをScoreVCでしようできるようにする
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    // ボタンを押下したとき呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]){
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        print("スコア：\(correctCount)")
        judgeImageView.isHidden = false // 次回以降も○×表示できるようにする
        // 選択肢のダブルタップを防止
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        // ○×を0.5秒後に非表示
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
        }
    }
    //　次の問題を読み込む
    func nextQuiz() {
        quizCount += 1
        //現在の問題数が、問題数より小さい場合、スコア画面に遷移
        if quizCount < csvArray.count{
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    //CSVを読み込む関数
    func loadCSV(fileName: String) -> [String]{
        //引数の名前からCSVを読み込む、Bundleはプロジェクトに追加したファイルが配置される場所
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
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
