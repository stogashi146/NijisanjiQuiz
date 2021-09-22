//
//  ScoreViewController.swift
//  SampleQuiz
//
//  Created by 富樫駿 on 2021/09/18.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var returnTopButton: UIButton!
    var correct = 0
    var lifeRemaing = 0
    var selectLevel = 0
    var highScoreLeve1 = 0
    var highScoreLeve2 = 0
    var userScoreLevel1 = UserDefaults.standard
    var userScoreLevel2 = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScoreSave(correct, selectLevel)

        shareButton.layer.borderWidth = 2
        shareButton.layer.borderColor = UIColor.black.cgColor
        returnTopButton.layer.borderWidth = 2
        returnTopButton.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    //　シェアボタン、正解数をシェアする
    @IBAction func shareButtonAction(_ sender: Any) {
        let activityItems = ["にじさんじクイズアプリで\(correct)問正解しました。","#クイズにじさんじ"]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    // 2つ前の画面に戻る
    @IBAction func toTopButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    // 最高スコアを保存
    @IBAction func highScoreSave(_ correct:Int ,_ level:Int) {
        print(level)
        switch level {
        case 1:
            if userScoreLevel1.integer(forKey: "highScoreLeve1") < correct{
                userScoreLevel1.set(correct, forKey: "highScoreLeve1")
            }
            highScoreLeve1 = userScoreLevel1.integer(forKey: "highScoreLeve1")
            if correct >= 30 {
                scoreLabel.text = "クリア！おめでとう！\n\(correct)問正解！\n最高スコアは\(highScoreLeve1)"
            } else if lifeRemaing == 0 {
                scoreLabel.text = "ゲームオーバー！\nスコアは\(correct)問正解！\n最高スコアは\(highScoreLeve1)"
            }
        case 2:
            if userScoreLevel2.integer(forKey: "highScoreLeve2") < correct{
                userScoreLevel2.set(correct, forKey: "highScoreLeve2")
            }
            highScoreLeve2 = userScoreLevel1.integer(forKey: "highScoreLeve2")
            if correct >= 30 {
                scoreLabel.text = "クリア！おめでとう！\n\(correct)問正解！\n最高スコアは\(highScoreLeve2)"
            } else if lifeRemaing == 0 {
                scoreLabel.text = "ゲームオーバー！\nスコアは\(correct)問正解！\n最高スコアは\(highScoreLeve2)"
            }
        default:
            return
        }
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
