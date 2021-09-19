//
//  SelectLevelViewController.swift
//  SampleQuiz
//
//  Created by 富樫駿 on 2021/09/19.
//

import UIKit

class SelectLevelViewController: UIViewController {
    
    var selectTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectLevel = selectTag
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
