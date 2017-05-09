//
//  ScheduleViewController.swift
//  ywamconnect
//
//  Created by Woowon Kang on 5/3/17.
//  Copyright © 2017 Woowon Kang. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var scheduleView: UITableView!
    @IBOutlet weak var weekSelector: UISegmentedControl!
    
    var schedules: [Schedule]? = []
    var week = "thisweek"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchSchedules(selectedWeek: week)
    }
    
    func fetchSchedules(selectedWeek weektype: String){
        let urlRequest = URLRequest(url: URL(string:"https://ywamconnectkona.net/Main/API/calendar.cfc?method=getSchedule&CalendarType=Corporate&weektype=\(weektype)")!)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            self.schedules = [Schedule]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                if let schedulesFromJson = json["schedule"] as? [[String:AnyObject]] {
                    for scheduleFromJson in schedulesFromJson {
                        let schedule = Schedule()
                        if let daystring = scheduleFromJson["DayString"] as? String, let dateinfo = scheduleFromJson["DateInfo"] as? String, let timeinfo = scheduleFromJson["TimeInfo"] as? String, let daytitle = scheduleFromJson["DayTitle"] as? String, let istoday = scheduleFromJson["isToday"] as? Bool{
                                schedule.daystring = daystring
                                schedule.dateinfo = dateinfo
                                schedule.timeinfo = timeinfo
                                schedule.daytitle = daytitle
                                schedule.istoday = istoday
                        }
                        self.schedules?.append(schedule)
                    }
                }
                
                DispatchQueue.main.async {
                    self.scheduleView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        
        cell.daystring.text = self.schedules?[indexPath.item].daystring
        cell.dateinfo.text = self.schedules?[indexPath.item].dateinfo
        cell.timeinfo.text = self.schedules?[indexPath.item].timeinfo
        cell.activity.text = self.schedules?[indexPath.item].daytitle
        if (self.schedules?[indexPath.item].istoday)!{
            cell.backgroundColor = UIColor(red: 208/255, green: 219/255, blue: 242/255, alpha: 1.0) /* #d0dbf2 */
        } else {
            cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */

        }
        
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schedules?.count ?? 0
    }
    
    @IBAction func weekSelected(_ sender: Any) {
        switch weekSelector.selectedSegmentIndex {
        case 0:
            fetchSchedules(selectedWeek: "thisweek")
        case 1:
            fetchSchedules(selectedWeek: "nextweek")
        default :
            fetchSchedules(selectedWeek: "thisweek")
        }
    }
    
    
    
}
