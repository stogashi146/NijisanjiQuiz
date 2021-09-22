//
//  SelectLevelViewController.swift
//  SampleQuiz
//
//  Created by 富樫駿 on 2021/09/19.
//

import UIKit

class SelectLevelViewController: UIViewController {
    @IBOutlet weak var level1Button: UIButton!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var level3Button: UIButton!
    var selectTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        level1Button.layer.borderWidth = 2
        level1Button.layer.borderColor = UIColor.black.cgColor
        

        level2Button.layer.borderWidth = 2
        level2Button.layer.borderColor = UIColor.black.cgColor
        
        level3Button.layer.borderWidth = 2
        level3Button.layer.borderColor = UIColor.black.cgColor
        level3Button.isHidden = true
        
        levelHidden()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        levelHidden()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectLevel = selectTag
    }
    // むずかしいの解禁
    @IBAction func levelHidden() {
        if UserDefaults.standard.integer(forKey: "highScoreLeve1") < 30 {
            level2Button.isEnabled = false
            level2Button.titleLabel?.adjustsFontSizeToFitWidth = true
            level2Button.setTitle("ふつうを30問正解で解禁", for: .normal)
        } else {
            level2Button.isEnabled = true
            level2Button.titleLabel?.adjustsFontSizeToFitWidth = true
            level2Button.setTitle("むずかしい", for: .normal)
        }
    }
    
    @IBAction func leveButtonAction(sender: UIButton) {
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
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
