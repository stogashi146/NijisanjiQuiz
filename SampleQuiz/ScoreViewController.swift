//
//  ScoreViewController.swift
//  SampleQuiz
//
//  Created by 富樫駿 on 2021/09/18.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    var correct = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "\(correct)問正解！"
        // Do any additional setup after loading the view.
    }
    // 2つ前の画面に戻る
    @IBAction func toTopButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
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
