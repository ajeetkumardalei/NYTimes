//
//  ViewController.swift
//  NYTimeDemo
//
//  Created by Ajeet on 26/11/18.
//  Copyright © 2018 Ajeet. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SafariServices


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    @IBOutlet weak var btnMenu:UIButton!
    @IBOutlet weak var btnSearch:UIButton!
    @IBOutlet weak var btnMore:UIButton!
    @IBOutlet weak var tblvw: UITableView!
//    var arrMain:[String:Any] = [:]
    var arrMain = [Result]()
    
    
    
    func setup(){
        btnMenu.tag = 1; btnSearch.tag = 2; btnMore.tag = 3
        //        self.tblvw.register(NewsCell.self, forCellReuseIdentifier: "newscell")
        self.tblvw.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newscell")
        tblvw.tableFooterView = UIView.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        //MARK: we can call below 3 procedures but First one i considered as of now.
        callNewsAPI()
//        callNewsAPI2()
//        callNewsAPI3()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Safari controller delegate method
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    //MARK: Tableview datasource & delegate methods lined up
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMain.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create cell identifier
        let cellidentifier = "newscell"
        
        // create a new cell if needed or reuse an old one
        var cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier) as? NewsCell
//        if cell == nil{
//        }
        
        // set the text from the data model
        if arrMain.count > 0{
        let dict = arrMain[indexPath.row]
        cell?.lblTitle.text = dict.title
        cell?.lblAbstract.text = dict.byline
        cell?.lblDate.text = dict.published_date
        }
        
        
        //cell?.textLabel?.text = "Hi Ajeet"
        cell?.selectionStyle = .none
//        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        if arrMain.count > 0{
            let dict = arrMain[indexPath.row]
            guard let sampleurl = dict.url, sampleurl.count > 0 else {print("url is not present");return}
            guard let myurl = URL.init(string: sampleurl) else {return}
            let safarivc = SFSafariViewController.init(url: myurl)
            safarivc.delegate = self
            self.present(safarivc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        let title = "Alert!"
        var msg:String?
        switch sender.tag {
        case 1://menu btn tapped
            msg = "menu tapped"
        case 2://menu btn tapped
            msg = "Search tapped"
        case 3://menu btn tapped
            msg = "More details tapped"
        default:
            break
        }
        let alertController = UIAlertController(title: title, message: msg, preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        { action -> Void in
            // Put your code here
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    //++++++++++++++++++++ Alamofire +++++++++++++++++++++++
    //MARK: This is Alamofire http networking request GET
    /// first configured baseURL and then added endpoint
    
    func callNewsAPI() -> Void {
        let strURL = baseURL + endPoint
        
        Alamofire.request(strURL).responseData { (resData) -> Void in
            guard let responseData = resData.result.value, responseData != nil else {return}
            
            //here we convert the data into string format
            if let strOutput = String(data : responseData, encoding : String.Encoding.utf8){
                //print("response came: =>", strOutput)}
            
            /*//we can do better with SwiftyJSON
            guard let rootJSON = JSON.init(rawValue: responseData) else {print("unable to parse swift json");return}
                if let arrResult = rootJSON["results"].arrayObject{
                    print("arr result:=>", arrResult)
            }*/
            
                guard let rootJSON = try? JSONSerialization.jsonObject(with: responseData, options: [])
                    else{ print("failedh");return}
                
                if let JSON = rootJSON as? [String: Any] {
                    guard let jsonArray = JSON["results"] as? [[String: Any]]
                        else {return}
                    print(jsonArray)
                    
                    for dict in jsonArray{
//                        let title = dict["title"] as? String
//                        let desc = dict["byline"] as? String
//                        let date = dict["published_date"] as? String
                        
                        self.arrMain.append(Result.init(dict))
                    }
                    
                    DispatchQueue.main.async {
                        self.tblvw.reloadData()
                    }
                }
            }
        }
    }
    
    func callNewsAPI2(){
        let strURL = baseURL + endPoint
        let myurl = URL.init(string: strURL)
        
        Alamofire.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//            print(response)
            guard let responseData = response.result.value else {print("Network error occured"); return}
            
            //we can do better with SwiftyJSON
            guard let jsonResponse = JSON.init(rawValue: responseData) else {print("json parsing fail"); return}
            //print(jsonResponse)
            
            
            //apply model class for data structure
            var rootModel:Response?
            
//            if let arrResponse = rootJSON["contacts"].arrayObject {
//
//            }
        }
    }
    
    //by using nsurlsession call we can make http request
    func callNewsAPI3() -> Void{
        let strURL = baseURL + endPoint

        guard let url = URL(string: strURL) else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let responseData = data else {return}
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String:Any]
//                let dictRes = json!["companies"]
//                print(dictRes)
//                
//            } catch {
//                print("didnt work")
//            }
            
            
            
            //apply model class for data structure
            guard let jsonResponse = try? JSONDecoder().decode(Response.self, from: responseData) else {
                print("Error: Couldn't decode data into Blog")
                return
            }
        

            
            }.resume()
    }
    
    

}

