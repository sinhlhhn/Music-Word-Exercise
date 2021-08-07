//
//  List.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 8/11/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit

class List: UIViewController {

    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        // Do any additional setup after loading the view.
    }
    
    func designButton(btn:UIButton) {
        btn.titleEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: 19, right: 40)
        btn.imageEdgeInsets = UIEdgeInsets(top: 27, left: 318, bottom: 26, right: 19)
        btn.setImage(UIImage(named: "Arrows-Forward-icon"), for: .normal)
        btn.setTitle("123", for: .normal)
    }
    func setUpButton() {
        designButton(btn: btn1)
        designButton(btn: btn2)
        designButton(btn: btn3)
    }
    
    
    
    
    
    @IBAction func NewListTapped(_ sender: Any) {
    }
    @IBAction func btnTapped(_ sender: UIButton) {
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
