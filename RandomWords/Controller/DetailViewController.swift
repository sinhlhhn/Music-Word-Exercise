//
//  DetailViewController.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 7/22/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblEng: UILabel!
    @IBOutlet weak var imgWord: UIImageView!
    @IBOutlet weak var lblVn: UILabel!
    @IBOutlet weak var btnHome: UIButton!
    
    var img = String()
    var Eng = String()
    var Vn = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblVn.text = Vn
        lblEng.text = Eng
        SetUpHomeBtn()
        SetUpImg()
        // Do any additional setup after loading the view.
    }
    func SetUpHomeBtn(){
        btnHome.layer.cornerRadius = 10
        btnHome.layer.borderWidth = 1
        btnHome.layer.borderColor = UIColor.white.cgColor
    }
    func SetUpImg(){
        imgWord.image = UIImage(named: img)
    }
    @IBAction func btnHomeTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
