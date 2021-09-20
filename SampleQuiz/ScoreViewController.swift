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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if lifeRemaing == 0 {
            scoreLabel.text = "ゲームオーバー！\nスコアは\(correct)問正解！"
        } else {
            scoreLabel.text = "クリア！おめでとう！\n\(correct)問正解！"
        }
        
        shareButton.layer.borderWidth = 2
        shareButton.layer.borderColor = UIColor.black.cgColor
        returnTopButton.layer.borderWidth = 2
        returnTopButton.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    //　シェアボタン、正解数をシェアする
    @IBAction func shareButtonAction(_ sender: Any) {
        let activityItems = ["にじさんじクイズアプリで\(correct)問正解しました。","#にじさんじクイズアプリ"]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    // 2つ前の画面に戻る
    @IBAction func toTopButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
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
