//
//  ViewController.swift
//  ywamconnect
//
//  Created by Woowon Kang on 4/17/17.
//  Copyright © 2017 Woowon Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var labelDay: UILabel!
    
    var mealschedules: [MealSchedule]? = []
    var day = "today"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 240
        //labelDay.text = ""
        
        fetchMenus(selectedDay: day)
        
    }

    func fetchMenus(selectedDay whichday: String){
        let urlRequest = URLRequest(url: URL(string:"https://ywamconnectkona.net/Main/API/calendar.cfc?method=getMealSchedule&Day=\(whichday)")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            
            if error != nil {
                print(error!)
                return
            }
    
            self.mealschedules = [MealSchedule]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                let txtDay = json["selectedday"] as? String
                
                if let mealschedulesFromJson = json["mealschedule"] as? [[String: AnyObject]] {
                    for mealscheduleFromJson in mealschedulesFromJson {
                        let mealschedule = MealSchedule()
                        if let mealtype = mealscheduleFromJson["type"] as? String, let postedby = mealscheduleFromJson["postedby"] as? String, let mealmenu = mealscheduleFromJson["menu"] as? String {
                            
                            mealschedule.postedby = postedby
                            mealschedule.mealmenu = mealmenu
                            mealschedule.mealtype = mealtype
                            
                        }
                        self.mealschedules?.append(mealschedule)
                    }
                }
                DispatchQueue.main.async {
                    self.labelDay.text = txtDay
                    self.tableview.reloadData()
                }
                
                
            } catch let error {
                print(error)
            }
        }
        
        task.resume()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealscheduleCell", for: indexPath) as! MealScheduleCell
        
        cell.mealtype.text = self.mealschedules?[indexPath.item].mealtype
        cell.mealmenu.text = self.mealschedules?[indexPath.item].mealmenu
        cell.postedby.text = self.mealschedules?[indexPath.item].postedby
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealschedules?.count ?? 0
    }
    
    @IBAction func todayTomorrow(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            fetchMenus(selectedDay: "today")
        case 1:
            fetchMenus(selectedDay: "tomorrow")
        default :
            fetchMenus(selectedDay: "today")
        }
    }
    

}

