//
//  ExerciseViewController.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 8/11/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var ChartsView: UIView!
    @IBOutlet weak var lblRequired: UILabel!
    @IBOutlet weak var txtFinishedTimes: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTapped(_ sender: Any) {
        
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
