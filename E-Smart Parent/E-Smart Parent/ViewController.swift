//
//  ViewController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 07/01/17.
//
//

import UIKit
import Firebase
import FontAwesome_swift

//let attendanceHistoryURL : URL = URL(string: "http://test.nowskitchen.com/api/Student/GetStudentAttendanceHistory/ST000001")!
var attendanceHistoryURL = "http://cluster.nowskitchen.com/api/Student/GetStudentAttendanceHistory/"

class ViewController: UIViewController {
    var dashboardItems : NSArray = []
    
    @IBOutlet var dashboardCollectionview : UICollectionView?
    var conversationArray = [ConversationList]()
    var loginDetails : LoginDetails = LoginDetails()
    let identifier = "dashboardCell"
     let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    var selectedFeature = ""
    @IBOutlet var activityView : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let metaDataManager = MetaDataManager()
        dashboardItems = metaDataManager.getDashboardItems()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conversationList" {
            let conversationList = self.storyBoard.instantiateViewController(withIdentifier: "conversationList") as! ConversationListViewcontroller
            conversationList.conversationLists = self.conversationArray
            self.navigationController?.pushViewController(conversationList, animated: true)

            
        }
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
        guard let flowLayout = self.dashboardCollectionview?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.invalidateLayout()
    }

}

extension ViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath) as! DashboardCell
        let dict = dashboardItems[indexPath.row] as! NSDictionary
        let colorDict = dict["RGBValue"] as! NSDictionary
        cell.featureLabel.text = dict["itemName"] as? String
        cell.layer.cornerRadius = 2.0
        cell.featureImageview.image = UIImage.fontAwesomeIcon(name: String.fontAwesome(code: (dict["imageName"] as? String)!)!, textColor: UIColor.white  , size: CGSize(width: 30, height: 30))
        cell.backgroundColor = UIColor(red: CGFloat(colorDict["R"] as! Float/255), green:  CGFloat(colorDict["G"] as! Float/255), blue:  CGFloat(colorDict["B"]  as! Float/255), alpha: 1.0)
        return cell
    }
    
}
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let serviceManager = ServiceManagerClass(_delegate: self)
                switch indexPath.row {
                case 0:
                    self.selectedFeature = "Message"
                    activityView?.startAnimating()
                    
                    self.updateFirebaseToken()
                    break
                case 1:
        self.selectedFeature = "Attendance"
                    activityView?.startAnimating()
                    attendanceHistoryURL = attendanceHistoryURL.appending(loginDetails.studendID)
                    self.makeAttendanceHistoryRequest()
                    break
                case 2:
                     self.selectedFeature = "Calendar"
                    activityView?.startAnimating()
                    
                    self.makeEventsRequest()
                    
                    break
                case 3:
                    self.selectedFeature = "Circulars"
                    activityView?.startAnimating()
                    
                    self.makeCircularsRequest()
                    
                    break
                case 5:
                    self.selectedFeature = "GPS Tracking"
                    let gpsTracking = storyBoard.instantiateViewController(withIdentifier: "gpsTracking") as! GPSTrackingViewController
                    self.navigationController?.pushViewController(gpsTracking, animated: true)
                    break
                case 6:
                    self.selectedFeature = "Homeworks"
                    activityView?.startAnimating()
                    
                    self.makeHomeworksRequest()
                    
                    break
                case 7:
                    self.selectedFeature = "ExamResult"
                    activityView?.startAnimating()
                    
                    self.makeExamresultRequest()
                    
                    break
                case 8:
                    self.selectedFeature = "TimeTable"
//                    activityView?.startAnimating()
                    
                    //self.makeTimetableRequest()
                    let alert = UIAlertController(title: "Alert", message: "Feature not yet implemented", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    break
                
                default:
                    let alert = UIAlertController(title: "Alert", message: "Feature not yet implemented", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
        
                }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width-10, height: 110.0)
        }
        return CGSize(width: (collectionView.frame.size.width-20)/2.0, height: 85.0)
    }
}

//MARK:- Service delegates
extension ViewController: ServiceManagerDelegate {
    func didReceiveAlamofireResponse(_response : NSDictionary){
        if self.selectedFeature == "Attendance" {
            let dates = _response["data"]! as! String
            guard let datesArray = dates.parseJSONString as? NSArray
                else {
                    return
            }
           
            activityView?.stopAnimating()
            
            let attendanceHistoryVC = storyBoard.instantiateViewController(withIdentifier: "attendanceHistory") as! AttendanceHistoryViewController
            attendanceHistoryVC.dateDictArray = datesArray
            self.navigationController?.pushViewController(attendanceHistoryVC, animated: true)
        }
        else if self.selectedFeature == "Calendar" {
            let dates = _response["data"]! as! String
            guard let datesDict = dates.parseJSONString as? NSArray
                else {
                    return
            }
            activityView?.stopAnimating()
            let calendar = storyBoard.instantiateViewController(withIdentifier: "calendar") as! CalendarViewController
            //calendar.data = datesDict
            self.navigationController?.pushViewController(calendar, animated: true)

        
        }
       
    }
    
    func didReceiveError(_error : Error){
        activityView?.stopAnimating()
        let alert: UIAlertController = UIAlertController(title: "Error", message: _error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func notReachable() {
        activityView?.stopAnimating()
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Internet Not Available", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}


//Mark:- JSON parsing
extension String {
    var parseJSONString: AnyObject? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do {
                return try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            }
            catch{
                print("error")
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
        return nil
    }
}


//Events Webservice
//MARK: - Web service methods

extension ViewController{
    
    
    
    func makeAttendanceHistoryRequest() {
        self.activityView?.isHidden = false
        self.activityView?.startAnimating()
        RequestBuilder().buildRequestForAttendanceHistory(url:attendanceHistoryURL, completionHandler: {
            (success, response, error) in
            if success {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if response != nil {
                let attendanceFeatureVC = self.storyBoard.instantiateViewController(withIdentifier: "attendanceFeature") as! AttendanceFeatureViewcontroller
                    attendanceFeatureVC.datesArray = response!
                    self.navigationController?.pushViewController(attendanceFeatureVC, animated: true)
                }
                else{
                let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
                
                
            }
        })
    }

    
/// to make Events request
func makeEventsRequest() {
    var jsonParams: [String : AnyObject] = [String : AnyObject]()
    jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
    jsonParams["classId"] = loginDetails.classID as AnyObject?
    jsonParams["sectionId"] = loginDetails.sectionID as AnyObject?
    self.activityView?.isHidden = false
    self.activityView?.startAnimating()
    RequestBuilder().buildRequestForEventsWithParams(params: jsonParams, completionHandler: {
        (success, response, error) in
        if success {
            self.activityView?.stopAnimating()
            self.activityView?.isHidden = true
            if response != nil {
                let calendar = self.storyBoard.instantiateViewController(withIdentifier: "calendar") as! CalendarViewController
                calendar.eventsArray = response!
                self.navigationController?.pushViewController(calendar, animated: true)
            }
            else{
            let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            }

        } else {
            self.activityView?.stopAnimating()
            self.activityView?.isHidden = true
            if error?.domain != "Not Reachable"{
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                self.notReachable()
            }
            
            
        }
    })
}
    
    
    /// to make Circulars request
    func makeCircularsRequest() {
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["classId"] = loginDetails.classID as AnyObject?
        jsonParams["sectionId"] = loginDetails.sectionID as AnyObject?
        self.activityView?.isHidden = false
        self.activityView?.startAnimating()
        RequestBuilder().buildRequestForCircularsWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if response != nil {
                    let calendar = self.storyBoard.instantiateViewController(withIdentifier: "circular") as! CircularFeatureViewController
                    calendar.circularsArray = response!
                    self.navigationController?.pushViewController(calendar, animated: true)
                }
                else{
                let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                }

            } else {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
                
            }
        })
    }
    
    /// to make Homeworks request
    func makeHomeworksRequest() {
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["classId"] = loginDetails.classID as AnyObject?
        jsonParams["sectionId"] = loginDetails.sectionID as AnyObject?
        self.activityView?.isHidden = false
        self.activityView?.startAnimating()
        RequestBuilder().buildRequestForHomeworksWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if response != nil {
                    let homeworks = self.storyBoard.instantiateViewController(withIdentifier: "homeworks") as! HomeworkFeatureViewController
                    homeworks.homeworksArray = response!
                    self.navigationController?.pushViewController(homeworks, animated: true)
                }
                else{
                let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                }

            } else {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }

    
    /// to make Timetable request
    func makeTimetableRequest() {
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["classId"] = loginDetails.classID as AnyObject?
        jsonParams["sectionId"] = loginDetails.sectionID as AnyObject?
        self.activityView?.isHidden = false
        self.activityView?.startAnimating()
        RequestBuilder().buildRequestForTimetableWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if response != nil {
                    let homeworks = self.storyBoard.instantiateViewController(withIdentifier: "homeworks") as! HomeworkFeatureViewController
                    homeworks.homeworksArray = response!
                    self.navigationController?.pushViewController(homeworks, animated: true)
                }else{
                let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                }

            } else {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }

    
    /// to make ExamResult request
    func makeExamresultRequest() {
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["classId"] = loginDetails.classID as AnyObject?
        jsonParams["sectionId"] = loginDetails.sectionID as AnyObject?
         jsonParams["studentId"] = loginDetails.studendID as AnyObject?
        self.activityView?.isHidden = false
        self.activityView?.startAnimating()
        RequestBuilder().buildRequestForExamResultsWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if response != nil {
                    let examResultCategory = self.storyBoard.instantiateViewController(withIdentifier: "examResultCategory") as! ExamResultFeatureViewcontroller
                    examResultCategory.examResultDict = response!
                    self.navigationController?.pushViewController(examResultCategory, animated: true)
                }
                else{
                    let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }


    //message requests
    
    func updateFirebaseToken() {
        
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["userId"] = loginDetails.studendID as AnyObject?
        jsonParams["userRole"] = "S" as AnyObject?
        jsonParams["tokenType"] = "ios" as AnyObject?
        if let refreshedToken = FIRInstanceID.instanceID().token(){
             jsonParams["token"] = refreshedToken as AnyObject?
        }
       
        self.activityView?.isHidden = false
        self.activityView?.startAnimating()
        RequestBuilder().buildRequestUpdateTokenWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
//                self.activityView?.stopAnimating()
//                self.activityView?.isHidden = true
                if response != nil {
                    self.getConversationList()
                }
                else{
                    let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }
    
    func getConversationList(){
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["userId"] = loginDetails.studendID as AnyObject?
        jsonParams["userRole"] = "S" as AnyObject?
        self.activityView?.isHidden = false
        self.activityView?.startAnimating()
        RequestBuilder().buildRequestGetConversationListWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                                self.activityView?.stopAnimating()
                                self.activityView?.isHidden = true
                if response != nil {
                    if response != nil {
                    self.conversationArray = response!
                    }
                    let conversationList = self.storyBoard.instantiateViewController(withIdentifier: "conversationList") as! ConversationListViewcontroller
                    conversationList.conversationLists = self.conversationArray
                    conversationList.loginDetails = self.loginDetails
                    self.navigationController?.pushViewController(conversationList, animated: true)

                }
                else{
                    let alert = UIAlertController(title: "Alert", message: "No Data Present", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.activityView?.stopAnimating()
                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }
    
    

}

