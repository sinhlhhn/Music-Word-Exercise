//
//  ViewController.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 7/22/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit
import AVFoundation
import Gifu


class ViewController: UIViewController {
    
    //MARK: -var
    
    /*`findSong` và `findWord` dùng để tìm kiếm các từ trùng với tên bài hát */
    var findWord = [WordModel]()
    var findSong = [SongModel]()
    var isAdd = 0
    
    var songs = [SongModel]() // chứa mảng các bài hát
    var exercises = [ExerciseModel]() // chứa mảng các bài tập
    var words = [WordModel]()// chứa mảng các từ
    /*`numbers` và `numbers2` dùng để lưu các giá trị ngẫu nhiên đã lấy ra nhằm tránh bị lặp lại `Word` và `Exercise` */
    
    var position = 0 // lưu vị trí của bài hát muốn phát
    var player:AVAudioPlayer? // biến đối tươngj phát nhạc
    var isPause = true // kiểm tra xem bài có đang phát nhạc hay không
    var skip:Float? // biến để kiểm tra xem bài hát đã kết thúc hay chưa
    
    // MARK: -IBOutlet
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var str3: UIButton!
    @IBOutlet weak var str2: UIButton!
    @IBOutlet weak var str1: UIButton!
    @IBOutlet weak var exe1: UIButton!
    @IBOutlet weak var exe2: UIButton!
    @IBOutlet weak var exe3: UIButton!
    
    
    
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var AddView: UIView!
    @IBOutlet weak var txtEng: UITextField!
    @IBOutlet weak var txtVn: UITextField!
    @IBOutlet weak var txtSong: UITextField!
    
    @IBOutlet weak var txtSongName: UITextField!
    
    @IBOutlet weak var txtExerciseName: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtExerciseLink: UITextField!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnAddSong: UIButton!
    
    @IBOutlet weak var btnAddWord: UIButton!
    
    @IBOutlet weak var btnAddExercise: UIButton!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                //deleteObject()
                //setupEx()
        songs = SongModel.showObject() // lấy các bài hát trong CSDL
        exercises = ExerciseModel.showObject()// lấy các bài tập trong CSDL
        words = WordModel.showObject()// lấy các từ trong CSDL
        lblSongName.text = songs[position].name //hiển thị tên bài hát
        FindWordAndSong() // tìm kiếm các từ theo tên bài hát đang hiển thị
        RandomAndCheck() // gán và kiểm tra các giá trị rd
        //insert()
        SetUpSong() // chuẩn bị thiết bị phát nhạc
        SetTitleButton() // hiển thị giá trị các nút
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        // thiết lập làm cho slider chạy theo thời gian
        textDelegate()
        
    }
    @objc func updateSlider(){
        slider.value = Float(player!.currentTime) // gán giá trị hiện tại của slider = thời gian hiện tại của trình phát nhạc
        /*thiết lập lại các giá trị khi mà bài hát kết thúc
         -tự động chuyển bài tiếp theo
         -thiết lập lại các giá trị của button
         */
        if slider.value > skip! {
            position += 1
            if position > songs.count - 1 {
                position = 0
            }
            lblSongName.text = songs[position].name
            FindWordAndSong()
            SetTitleButton()
            SetUpSong()
        }
    }
    // MARK: -func FindWordAndSong: hiển thị các từ theo bài hát
    func FindWordAndSong(){
        findSong = SongModel.findSong(name: lblSongName.text ?? "")//tìm bài hát trong CSDL với tên bài hát là tên hiển thị trên label
        findWord = WordModel.findWord(song: findSong[0])// tìm các từ trong bài hát ở trên
    }
    // MARK: -func SetUpButton: thiết kế lại các button
    func SetUpButton(btn:UIButton){
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = .none
        
        
    }
    //MARK: -func Button: hiển thị lại giá trị cho từng button
    func Button(){
        SetUpButton(btn: str1)
        SetUpButton(btn: str2)
        SetUpButton(btn: str3)
        SetUpButton(btn: exe1)
        SetUpButton(btn: exe2)
        SetUpButton(btn: exe3)
        SetUpButton(btn: btnAdd)
        SetUpButton(btn: btnCancel)
        SetUpButton(btn: btnAddSong)
        SetUpButton(btn: btnAddWord)
        SetUpButton(btn: btnAddExercise)
    }
    //MARK: -func SetUpSong: thiết lập trình phát nhạc
    func  SetUpSong() {
        let song = songs[position].name //lấy tên bài hát muốn phát
        let urlString = Bundle.main.path(forResource: song, ofType: "mp3")// thiết lập đường dẫn
        do {
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!) // tạo đối tượng phát nhạc
            guard let player = player else {
                return
            }
            player.prepareToPlay()
            checkPause() // kiểm tra đang phát hay không
            slider.maximumValue = Float(player.duration) // thiết lập giá trị lớn nhất của Slider = giá trị lớn nhất của trình phát nhạc
            skip = slider.maximumValue - 0.5 // gán giá trị skip = giá trị lớn nhất của slider
        } catch  {
            print("Error")
        }
    }
    //MARK: -checkPause: kiểm tra xem có đang phát nhạc hay không
    func checkPause() {
        if !isPause {
            player?.play()
        }
    }
    //MARK: -SetWordButton: gán giữ liệu hiển thị các nút
    func SetWordButton(){
        if findWord.count > 2 {
            str1.setTitle(words[0].eng, for: .normal)
            str2.setTitle(words[1].eng, for: .normal)
            str3.setTitle(words[2].eng, for: .normal)
        }
    }
    //MARK: -SetExerciseButton: gán giữ liệu hiển thị các nút
    func SetExerciseButton(){
        exe1.setTitle(exercises[0].name, for: .normal)
        exe2.setTitle(exercises[1].name, for: .normal)
        exe3.setTitle(exercises[2].name, for: .normal)
    }
    //MARK: -SetTitleButton: Hiển thị các nút
    func SetTitleButton() {
        Button()
        SetWordButton()
        SetExerciseButton()
    }
    //MARK: -checkWord -checkEx: lấy ra các giá trị không trùng nhau để hiển thị
    func checkWord(){
        words.removeAll()
        FindWordAndSong()
        if findWord.count < 3{
            for _ in 0..<3 {
                str1.setTitle("Insert at least 3 Word for the Song", for: .normal)
                str2.setTitle("Insert at least 3 Word for the Song", for: .normal)
                str3.setTitle("Insert at least 3 Word for the Song", for: .normal)
            }
        }else{
            for i in findWord{
                let item = WordModel(eng: i.eng, vn: i.vn, img: i.img, song: i.song)
                words.append(item)
            }
            var n = words.count
            var k = 0
            while true {
                let rd = Int.random(in: 0..<n)
                words[rd].eng = words[n - 1].eng
                words[rd].vn = words[n - 1].vn
                words[rd].img = words[n - 1].img
                words[rd].song = words[n - 1].song
                k += 1
                n -= 1
                
                if k == 3 || n == 0 {
                    break
                }
            }
        }
        
    }
    func checkExercise(){
        exercises.removeAll()
        exercises = ExerciseModel.showObject()
        var n = exercises.count
        var k = 0
        while true {
            let rd = Int.random(in: 0..<n)
            exercises[rd].name = exercises[n - 1].name
            exercises[rd].link = exercises[n - 1].link
            exercises[rd].requiredTimes = exercises[n - 1].requiredTimes
            //            exercises[rd].finishedTimes = exercises[n - 1].finishedTimes
            k += 1
            n -= 1
            
            if k == 3 || n == 0 {
                break
            }
        }
        
    }
    //MARK: -RandomAndCheck: gán các giá trị ngẫu nhiên cho button
    func RandomAndCheck(){
        checkWord()
        checkExercise()
    }
    
    @IBAction func NewListTapped(_ sender: Any) {
        RandomAndCheck()
        SetTitleButton()
    }
    func setUpPopView(){
        AddView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: 130)
        AddView.center = self.view.center
        AddView.layer.cornerRadius = 10
        blurView.bounds = view.bounds
        blurView.center = view.center
        
        hideBtn(hidden: 0)
        hideAll()
    }
    func animatedIn(popUp:UIView){
        self.view.addSubview(popUp)
        popUp.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        popUp.alpha = 0
        UIView.animate(withDuration: 0.3) {
            popUp.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            popUp.alpha = 1
        }
    }
    func animatedOut(popUp:UIView) {
        UIView.animate(withDuration: 0.3,animations: {
            popUp.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            popUp.alpha = 0
        },completion: { _ in
            popUp.removeFromSuperview()
        })
        songs = SongModel.showObject()
    }
    func hideAll(){
        txtVn.alpha = 0
        txtEng.alpha = 0
        txtSong.alpha = 0
        txtSongName.alpha = 0
        txtExerciseLink.alpha = 0
        txtExerciseName.alpha = 0
    }
    func hideBtn(hidden: CGFloat){
        btnAdd.alpha = hidden
        btnCancel.alpha = hidden
    }
    func hide(hidden: CGFloat) {
        hideAll()
        if isAdd == 1 {
            txtSongName.alpha = 1
        }
        if isAdd == 2 {
            txtVn.alpha = 1
            txtEng.alpha = 1
            txtSong.alpha = 1
        }
        if isAdd == 3 {
            txtExerciseName.alpha = 1
            txtExerciseLink.alpha = 1
        }
    }
    func highlight(){
        btnAddExercise.isHighlighted = false
        btnAddWord.isHighlighted = false
        btnAddSong.isHighlighted = false
        
    }
    func setUpAlert(message: String) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        let icon = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(icon)
        present(alert,animated: true,completion: nil)
    }
    func validateSongName() {
        if txtSongName.text!.isEmpty {
            setUpAlert(message: "Please type Song name")
        }else{
            if Song.isExisting(name: txtSongName.text!) {
                setUpAlert(message: "The name already exists")
            }else {
                setUpAlert(message: "Successful")
            }
        }
    }
    
        @IBAction func btnExeTapped(_ sender: UIButton) {
        let detail = storyboard?.instantiateViewController(identifier: "test") as! DetailExerciseViewController
        if sender.tag == 0 {
            let exerciseLog = ExerciseLogModel.findExercise(exercise: exercises[0])
            detail.txtName = exercises[0].name
            detail.txtLink = exercises[0].link
            detail.times = Int(exercises[0].requiredTimes)
            if exerciseLog.count == 0 {
                detail.finishTimes = 0
            }else {
                detail.finishTimes = Int(exerciseLog[0].finishedTimes)
            }
            detail.exercise = exercises[0]
        }
        if sender.tag == 1 {
            let exerciseLog = ExerciseLogModel.findExercise(exercise: exercises[1])
            detail.txtName = exercises[1].name
            detail.txtLink = exercises[1].link
            detail.times = Int(exercises[1].requiredTimes)
            if exerciseLog.count == 0 {
                detail.finishTimes = 0
            }else {
                detail.finishTimes = Int(exerciseLog[0].finishedTimes)
            }
            detail.exercise = exercises[1]
        }
        if sender.tag == 2 {
            let exerciseLog = ExerciseLogModel.findExercise(exercise: exercises[2])
            detail.txtName = exercises[2].name
            detail.txtLink = exercises[2].link
            detail.times = Int(exercises[2].requiredTimes)
            if exerciseLog.count == 0 {
                detail.finishTimes = 0
            }else {
                detail.finishTimes = Int(exerciseLog[0].finishedTimes)
            }
            detail.exercise = exercises[2]
        }
        
        
        navigationController?.pushViewController(detail, animated: true)
    }
    @IBAction func btnNameTapped(_ sender: UIButton) {
        let detail = storyboard?.instantiateViewController(identifier: "list") as! DetailViewController
        if findWord.count > 2 {
            if sender.tag == 0 {
                detail.Eng = words[0].eng
                detail.Vn = words[0].vn
                detail.img = words[0].img
            }
            if sender.tag == 1 {
                detail.Eng = words[1].eng
                detail.Vn = words[1].vn
                detail.img = words[1].img
            }
            if sender.tag == 2 {
                detail.Eng = words[2].eng
                detail.Vn = words[2].vn
                detail.img = words[2].img
            }
            navigationController?.pushViewController(detail, animated: true)
            
        }
    }
    
    
    @IBAction func btnBackWardTapped(_ sender: Any) {
        player?.stop()
        position -= 1
        if position < 0 {
            position = songs.count - 1
        }
        lblSongName.text = songs[position].name
        FindWordAndSong()
        RandomAndCheck()
        SetTitleButton()
        SetUpSong()
    }
    @IBAction func btnForWardTapped(_ sender: Any) {
        player?.stop()
        position += 1
        if position > songs.count - 1 {
            position = 0
        }
        lblSongName.text = songs[position].name
        FindWordAndSong()
        RandomAndCheck()
        SetTitleButton()
        SetUpSong()
        
    }
    @IBAction func btnPauseTapped(_ sender: Any) {
        if isPause {
            btnPause.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            isPause = false
            player?.play()
        }else {
            btnPause.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
            isPause = true
            player?.pause()
        }
    }
    
    @IBAction func SliderChange(_ sender: Any) {
        player?.currentTime = TimeInterval(slider.value)
        player?.prepareToPlay()
        checkPause()
    }
    @IBAction func AddTapped(_ sender: Any) {
        setUpPopView()
        animatedIn(popUp: blurView)
        animatedIn(popUp: AddView)
        
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        validateSongName()
        if isAdd == 2 {
            var song = [Song]()
            song = Song.fetchSongWithSongName(key:txtSong.text!)
            let wordNeedInsert = WordModel(eng: txtEng.text!, vn: txtVn.text! , img: "0", song: song[0])
            let newWord = Word.insertObject2(word: wordNeedInsert)
            song[0].addToWord(newWord)
            
            
        }
        if isAdd == 1 {
            let songNeedInsert = SongModel(name: txtSongName.text!)
            _ = Song.insertObject(songModel: songNeedInsert)
            
        }
        
        if isAdd == 3 {
            let exNeedInsert = ExerciseModel(name: txtExerciseName.text!, link: txtExerciseLink.text!, requiredTimes: 0)
            _ = Exercise.insertObject(exerciseModel: exNeedInsert)
        }
        
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        animatedOut(popUp: AddView)
        animatedOut(popUp: blurView)
    }
    
    @IBAction func btnReloadTapped(_ sender: Any) {
        RandomAndCheck()
        SetTitleButton()
    }
    
    @IBAction func btnReloadChangedPosition(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        guard let gestureView = panGesture.view else {
            return
        }
        gestureView.center = CGPoint(x: gestureView.center.x , y: gestureView.center.y + translation.y)
        
        panGesture.setTranslation(.zero, in: view)
    }
    
    @IBAction func btnAddWordTapped(_ sender: Any) {
        isAdd = 2
        hideBtn(hidden: 0)
        highlight()
        btnAddWord.isHighlighted = true
        UIView.animate(withDuration: 0.5, animations: {
            self.AddView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: self.view.bounds.height * 0.6)
            self.AddView.center = self.view.center
            self.hide(hidden: 1)
            
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseInOut, animations: {
                self.hideBtn(hidden: 1)
            }, completion: nil)
            
        }
        clearText()
        
        
    }
    
    @IBAction func btnAddSongTapped(_ sender: Any) {
        isAdd = 1
        hideBtn(hidden: 0)
        highlight()
        btnAddSong.isHighlighted = true
        UIView.animate(withDuration: 0.5, animations: {
            self.AddView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: self.view.bounds.height * 0.4)
            self.AddView.center = self.view.center
            self.hide(hidden: 1)
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseInOut, animations: {
                self.hideBtn(hidden: 1)
            }, completion: nil)
            
            
        }
        clearText()
        
    }
    
    @IBAction func btnAddExerciseTapped(_ sender: Any) {
        isAdd = 3
        hideBtn(hidden: 0)
        highlight()
        btnAddExercise.isHighlighted = true
        
        UIView.animate(withDuration: 0.5, animations: {
            self.AddView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: self.view.bounds.height * 0.4)
            self.AddView.center = self.view.center
            self.hide(hidden: 1)
            
        }) { (_) in
            UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveEaseInOut, animations: {
                self.hideBtn(hidden: 1)
            }, completion: nil)
        }
        clearText()
        
    }
    
    
    
    
    
    
    
    
    
    
    func setupEx() {
        let arrExerciseName = ["Pushup","Air swimming","Superman punch","Bulgarian split squat","Bulgarian split squat to decline push up2","Bulgarian split squat to decline push up","Single leg tricep up","Glute bridge","Runner’s crunch","Burpee with Mountain Climbers"]
        let arrExerciseLink = ["https://media.self.com/photos/5b58b2adf658c67200f6a75e/master/w_1600%2Cc_limit/130_cc.gif","https://media.self.com/photos/5b58b2ab543a222fb4e503ba/master/w_1600%2Cc_limit/129_cc.gif","https://media.self.com/photos/5b58b2afc8678833138b0c56/master/w_1600%2Cc_limit/135_cc.gif","https://media.self.com/photos/5b58b2b0543a222fb4e503bc/master/w_1600%2Cc_limit/136_cc.gif","https://media.self.com/photos/5b59d906f658c67200f6a769/master/w_1600%2Cc_limit/131_cc.gif","https://media.self.com/photos/5b58b2ad4e998014a491318c/master/w_1600%2Cc_limit/132_cc.gif","https://media.self.com/photos/5b58b2ac4e998014a491318a/master/w_1600%2Cc_limit/133_cc.gif","https://media.self.com/photos/5b58b2ae4e998014a491318e/master/w_1600%2Cc_limit/134_cc.gif","https://media.self.com/photos/5b58b2b1f658c67200f6a760/master/w_1600%2Cc_limit/138_cc.gif","https://media.self.com/photos/5b58b2b2c8678833138b0c58/master/w_1600%2Cc_limit/139_cc.gif"]
        var arrExercise = [Exercise]()
        for i in 0..<arrExerciseName.count {
            let exNeedInsert = ExerciseModel(name: arrExerciseName[i], link: arrExerciseLink[i], requiredTimes: 10)
            let ex = Exercise.insertObject(exerciseModel: exNeedInsert)
            arrExercise.append(ex)
        }
        
        let finishTimes = [10,5,20,8,10,30,25,12,10,5]
        let date = ["12/6/2020","13/6/2020","14/6/2020","15/6/2020","16/6/2020","17/6/2020","18/7/2020","19/7/2020","20/7/2020","21/7/2020"]
        for i in 0..<date.count {
            let logNeedInsert = ExerciseLogModel(id: i, date: date[i], finishedTimes: finishTimes[i], exercise: arrExercise[0])
            let logNeedInsert1 = ExerciseLogModel(id:10 + i, date: date[i], finishedTimes: finishTimes[i], exercise: arrExercise[1])
            let ex1 = ExerciseLog.insertObject(exerciseLog: logNeedInsert)
            arrExercise[0].addToExerciseLog(ex1)
            let ex2 = ExerciseLog.insertObject(exerciseLog: logNeedInsert1)
            arrExercise[1].addToExerciseLog(ex2)
        }
        
        let numb = ["Pressure","Walk in one’s shoes","Undertow","Mistake","Aware","Smother","Afraid","Control"]
        let vns1 = ["áp lực/tạo áp lực","nhìn từ góc độ người khác","dòng nước ngầm ","sai lầm","nhận ra","làm chết ngạt","sợ","kiểm soát"]
        let deathBed = ["Fall asleep","Pass away","Deserve","Pray","Forgiveness","Blessing","Tear up","Bark"]
        let vn2 = ["ngã vào giấc ngủ","qua đời","xứng đáng","cầu nguyện","sự tha thứ","điều an lành","khóc","tiếng sủa"]
        let badLiar = ["Innocent","Victims","Loveless","Fear","Integrity","Faith","crocodile tear"]
        let vn3 = ["vô tội","nạn nhân","thất tình","nỗi sợ","liêm khiết","trung thành","nước mắt cá sấu"]
        let apolozige = ["Make a sound","Turn around","Take another chance","Ground","Angel","Afraid","Rope","Beat"]
        let vn4 = ["nói thành lời","quay lại","cơ hội mới","mặt đất","thiên thần","e rằng","dây thừng","nhịp đập"]
        let inTheEnd = ["Design","Rhyme","Due time","Pendulum","Eventually/eventual","Matter"]
        let vn5 = ["thiết kế","vần","thời hạn","con lắc","cuối cùng","vấn đề"]
        let songs1 = ["Numb","Death-Bed","Bad-Liar","Apologize","In-The-End"]
        
        var arrSongs = [Song]()
        for i in songs1 {
            let songNeedInsert = SongModel(name: i)
            let s1 = Song.insertObject(songModel: songNeedInsert)
            arrSongs.append(s1)
        }
        for j in 0..<numb.count{
            let song0 = arrSongs[0]
            
            let wordNeedInsert = WordModel(eng: numb[j], vn: vns1[j], img: "cat", song: song0)
            let word = Word.insertObject2(word: wordNeedInsert)
            song0.addToWord(word)
        }
        for j in 0..<deathBed.count{
            let wordNeedInsert = WordModel(eng: deathBed[j], vn: vn2[j], img: "cat", song: arrSongs[1])
            let word = Word.insertObject2(word: wordNeedInsert)
            arrSongs[1].addToWord(word)
        }
        for j in 0..<badLiar.count{
            let wordNeedInsert = WordModel(eng: badLiar[j], vn: vn3[j], img: "cat", song: arrSongs[2])
            let word = Word.insertObject2(word: wordNeedInsert)
            arrSongs[2].addToWord(word)
        }
        for j in 0..<apolozige.count{
            let wordNeedInsert = WordModel(eng: apolozige[j], vn: vn4[j], img: "cat", song: arrSongs[3])
            let word = Word.insertObject2(word: wordNeedInsert)
            arrSongs[3].addToWord(word)
        }
        for j in 0..<inTheEnd.count{
            let wordNeedInsert = WordModel(eng: inTheEnd[j], vn: vn5[j], img: "cat", song: arrSongs[4])
            let word = Word.insertObject2(word: wordNeedInsert)
            arrSongs[4].addToWord(word)
            
        }
    }
    
    func deleteObject() {
        Song.deleteObject()
        Word.deleteObject()
        Exercise.deleteObject()
        ExerciseLog.deleteObject()
    }
    
    
}
extension ViewController:UITextFieldDelegate {
    func textDelegate() {
        txtVn.delegate = self
        txtEng.delegate = self
        txtSong.delegate = self
        txtSongName.delegate = self
        txtExerciseLink.delegate = self
        txtExerciseName.delegate = self
    }
    func clearText() {
        txtExerciseName.text?.removeAll()
        txtExerciseLink.text?.removeAll()
        txtSongName.text?.removeAll()
        txtSong.text?.removeAll()
        txtEng.text?.removeAll()
        txtVn.text?.removeAll()
    }
}








