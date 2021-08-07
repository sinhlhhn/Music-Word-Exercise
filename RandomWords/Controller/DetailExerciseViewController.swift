//
//  DetailExerciseViewController.swift
//  RandomWords
//
//  Created by Lê Hoàng Sinh on 7/23/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit
import Gifu
import Charts
class DetailExerciseViewController: UIViewController,ChartViewDelegate {
    
    @IBOutlet var view1: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var chartsView: UIView!
    @IBOutlet weak var btnComplete: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTimes: UILabel!
    @IBOutlet weak var txtFinishTimes: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnHomeAlert: UIButton!
    var txtName = String()
    var txtLink = String()
    var times = Int()
    var finishTimes = Int()
    var exercise = ExerciseModel()
    var findExercise = [Exercise]()
    var findExerciseLog = [ExerciseLog]()
    var count = 0
    let barChart = BarChartView()
    var dates = [String]()
    @IBOutlet weak var lblAlert: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.hidesWhenStopped = true
        lblName.text = txtName
        txtFinishTimes.text = String(finishTimes)
        lblTimes.text = String(times)
        compareExercise()
        loadGif()
        setUpHomButton(btn: btnHome)
        
        // Do any additional setup after loading the view.
    }
    func setUpHomButton(btn:UIButton){
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.alpha = 0
    }
    func loadGif() {
        indicator.startAnimating()
        let gifView:GIFImageView = {
            let img = GIFImageView()
            img.contentMode = .scaleAspectFit
            img.animate(withGIFURL:URL(string: self.txtLink)!)
            return img
        }()
        self.imgView.addSubview(gifView)
        
        gifView.translatesAutoresizingMaskIntoConstraints = false
        gifView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        gifView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        gifView.topAnchor.constraint(equalTo: self.imgView.topAnchor,constant: 0).isActive = true
        gifView.centerXAnchor.constraint(equalTo: self.imgView.centerXAnchor).isActive = true
    }
    func SetUpAlertView(){
        view.addSubview(parentView)
        view.addSubview(alertView)
        
        alertView.layer.cornerRadius = 10
        alertView.bounds = CGRect(x: 0, y: 0, width: view.bounds.width * 0.8, height: view.bounds.height * 0.4)
        parentView.bounds = view.bounds
        parentView.alpha = 0
        alertView.alpha = 0
        alertView.center = view.center
        parentView.center = view.center
        
    }
    func compareExercise() {
        if Int(String(txtFinishTimes.text!))! >= times {
            times = Int(String(txtFinishTimes.text!))! + 5
            lblTimes.text = String(times)
        }
        
    }
    func setUpCharts() {
        
                
        
        chartsView.addSubview(barChart)
        
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.widthAnchor.constraint(equalTo: self.chartsView.widthAnchor, constant: 0).isActive = true
        barChart.heightAnchor.constraint(equalToConstant: chartsView.bounds.height * 0.5).isActive = true
        barChart.topAnchor.constraint(equalTo: self.chartsView.topAnchor,constant: 0).isActive = true
        barChart.centerXAnchor.constraint(equalTo: self.chartsView.centerXAnchor).isActive = true
        
        let format = NumberFormatter()
        format.maximumFractionDigits = 0
        format.numberStyle = .none
        barChart.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: format)
        barChart.xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: format)
        barChart.noDataText = "No Data " // thông báo khi ko có dữ liêuh
        barChart.rightAxis.enabled = false // ẩn thanh giá trị bên phải
        barChart.leftAxis.axisMinimum = 0 // đưa cột phải về vị trí cuối cùng
        barChart.xAxis.drawGridLinesEnabled = false // xoá line trong biểu đồ
        barChart.leftAxis.drawAxisLineEnabled = false // xoá cột phải
        fetchData(exerciseName: lblName.text!, forCharts: true)
        getDateForCharts()
        var entries = [BarChartDataEntry]() // tạo mảng giá trị của biểu đồ
        var items = [Double]()
        var months = [String]()

        for i in 0..<findExerciseLog.count {
            items.append(Double(findExerciseLog[i].finishedTimes))
            months.append(dates[i])
        }
        for i in 0..<findExerciseLog.count {
            entries.append(BarChartDataEntry( x:Double(i),y: items[i]))
            /**
             khởi taọ các giá trị
             x: giá trị của các dòng
             y: giá trị của các cột
             */
        }
        
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months) // thay các giá trị index mặc định thành kiểu String
        
        barChart.xAxis.granularity = 1 // giá trị hiển thị giữa các dòng
        barChart.xAxis.labelPosition = .bottom // hiển thị giá trị ở phía dưới
        barChart.xAxis.granularityEnabled = true // kích hoạt granularity
        barChart.xAxis.labelCount = findExerciseLog.count // số giá trị hiển thị của dòng
        
        let set = BarChartDataSet(entries: entries,label: "Rep") // các giá trị cần hiển thị
        set.colors = [NSUIColor.red]
        
        let data = BarChartData(dataSet: set) // chuyển thành dữ liệu
        data.barWidth = 0.3
        data.setValueFormatter(DigitValueFormatter())
        barChart.data = data // hiển thị dữ liệu
    }
    
    func fetchData(exerciseName: String,forCharts: Bool){
        if forCharts {
            findExercise = Exercise.fetchExerciseWithName(name: exerciseName)
            findExerciseLog = ExerciseLog.fetchObjectForCharts(exercise: findExercise[0])

        }else {
            findExercise = Exercise.fetchExerciseWithName(name: exerciseName)
            findExerciseLog = ExerciseLog.fetchObjectWithExerciseId(exercise: findExercise[0])

        }
                
    }
    func getDateForCharts(){
        let items = findExerciseLog
        
        let end = items[0].date!.index(items[0].date!.endIndex, offsetBy: -5)
        let start = items[0].date!.index(items[0].date!.startIndex, offsetBy: 0)
        for i in items{
            print(i.date!)
            dates.append(String(i.date![start..<end]))
        }
    }
    func convertDate() -> String{
        var result = String()
        let date = Date()
        let calendar = NSCalendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        result = "\(day)/\(month)/\(year)"
        
        
        return result
    }
    func getID(){
        let items = ExerciseLog.showObject()
        count = items.count
    }
    
    
    @IBAction func btnHomeAlertTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.parentView.alpha = 0
            self.alertView.alpha = 0
            
        }, completion: nil)
        UIView.animate(withDuration: 1, delay: 5, options: .curveEaseInOut, animations: {
            self.parentView.alpha = 0
            self.alertView.alpha = 0
            
        }, completion: nil)
        
    }
    @IBAction func btnFinishTapped(_ sender: Any) {
        compareExercise()
        let date = convertDate()

        findExercise = Exercise.fetchExerciseWithName(name: lblName.text!)
        findExerciseLog = ExerciseLog.fetchObjectWithDate(exercise: findExercise[0], date: date)
        _ = ExerciseModel.updateObject(exercise: exercise, requiredTimes: times)
        getID()
        var count1 = 0
        for i in findExerciseLog {
            if date == i.date {
                count1 += 1
            }
        }
        if count1 > 0{
            _ = ExerciseLog.updateObject(exerciseLog: findExerciseLog[0], finishedTimes: Int(txtFinishTimes.text!)!)
        }else {
            let item = ExerciseLogModel(id: count, date: convertDate(), finishedTimes: Int(txtFinishTimes.text!)!, exercise: findExercise[0])
            let ex = ExerciseLog.insertObject(exerciseLog: item)
            findExercise[0].addToExerciseLog(ex)
        }
        
        SetUpAlertView()
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.parentView.alpha = 0.5
            self.alertView.alpha = 1
        }){ (_) in
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.parentView.alpha = 0
                self.alertView.alpha = 0
            }){(_) in
                self.parentView.removeFromSuperview()
                self.alertView.removeFromSuperview()
            }
        }
        barChart.removeFromSuperview()
        setUpCharts()
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
