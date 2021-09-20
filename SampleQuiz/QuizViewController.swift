//
//  QuizViewController.swift
//  SampleQuiz
//
//  Created by 富樫駿 on 2021/09/18.
//

import UIKit
import GoogleMobileAds

class QuizViewController: UIViewController {
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var lifeImage1: UIImageView!
    @IBOutlet weak var lifeImage2: UIImageView!
    @IBOutlet weak var lifeImage3: UIImageView!
    
    
    //問題を格納する配列を宣言
    var bannerView: GADBannerView!
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectLevel = 0
    var secondsRemaing = 10
    var timer = Timer()
    var life = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //　AdMob
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
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
        
        // ボタンの枠線
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor
        
        // カウントダウン
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        secondsLabel.text = String(secondsRemaing)
        
        // ライフゲージ
        lifeImage1.image = UIImage(named: "life")
        lifeImage2.image = UIImage(named: "life")
        lifeImage3.image = UIImage(named: "life")
        
        // Do any additional setup after loading the view.
    }
    
    // カウントダウン
    @IBAction func updateCounter() {
        secondsRemaing -= 1
        secondsLabel.text = String(secondsRemaing)
        if secondsRemaing < 4 {
            secondsLabel.textColor = UIColor.red
        }
        print(secondsRemaing)
        if secondsRemaing == 0 {
            timer.invalidate()
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
            lifeDestroy()
            btnHidden()
        }
    }
    
    // ライフ削除
    @IBAction func lifeDestroy() {
        life -= 1
        switch life {
        case 2:
            lifeImage3.isHidden = true
        case 1:
            lifeImage2.isHidden = true
        case 0:
            lifeImage1.isHidden = true
        default:
            return
        }
    }
    
    //　正解数correctCountをScoreVCで使用できるようにする
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
        scoreVC.lifeRemaing = life
    }
    
    // ボタンを押下したとき呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]){
            correctCount += 1
            print("正解")
            timer.invalidate()
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            timer.invalidate()
            judgeImageView.image = UIImage(named: "incorrect")
            lifeDestroy()
        }
        print("スコア：\(correctCount)")
        btnHidden()
    }
    
    @IBAction func btnHidden() {
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
            self.secondsRemaing = 10
            self.secondsLabel.text = String(self.secondsRemaing)
            self.nextQuiz()
        }
    }
    
    //　次の問題を読み込む
    func nextQuiz() {
        quizCount += 1
        //現在の問題数が、問題数より小さい場合、スコア画面に遷移
        if life == 0 {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        } else if quizCount < csvArray.count {
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
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
    
    //GoogleAdMob
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
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
