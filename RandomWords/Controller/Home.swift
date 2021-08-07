//
//  Home.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 8/11/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var btnLearnAndEx: UIButton!
    @IBOutlet weak var btnMute: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var musicView: UIView!
    
    
    var isMute = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        designSlider(slider: slider)
        musicView.layer.cornerRadius = 17
        // Do any additional setup after loading the view.
    }
    func designButton(btn:UIButton){
        btn.layer.cornerRadius  = 16
    }
    func setUpButton(){
        designButton(btn: btnLearnAndEx)
        designButton(btn: btnMute)
    }
    func designSlider(slider:UISlider) {
        slider.setThumbImage(UIImage(named: "Button-Blank-Gray-icon"), for:  .normal)
        slider.setThumbImage(UIImage(named: "Button-Blank-Gray-icon"), for:  .highlighted)
    }
    
    @IBAction func btnLearnAndExTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "list") as! List
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnMuteTapped(_ sender: Any) {
        if isMute {
            btnMute.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
            isMute = false
        }else {
            btnMute.setImage(UIImage(systemName: "speaker.2.fill"), for: .normal)
            isMute = true
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
