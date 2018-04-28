//
//  ViewController.swift
//  Test UISearchController
//
//  Created by WY on 2018/4/28.
//  Copyright © 2018年 HHCSZGD. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UISearchBarDelegate , UISearchControllerDelegate{
    let  resultsController = MySearchResultsController()
    var searchVC : UISearchController!
    var text = ""
    let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
         configSearchBarVC()
    }
    func configSearchBarVC() {
        // Create the search results controller and store a reference to it.
        self.searchVC = UISearchController.init(searchResultsController: resultsController)
        
        // Use the current view controller to update the search results.
        self.searchVC.searchResultsUpdater = resultsController;
        self.searchVC.delegate = self
        self.searchVC.searchBar.delegate  = self
        // Install the search bar as the table header.
        self.tableView.tableHeaderView = self.searchVC.searchBar;
        self.tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        // It is usually good to set the presentation context.
        self.definesPresentationContext = true
        tableView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if text == "\n"{
            
            self.searchVC.isActive = false
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configTableView() {
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.frame = CGRect(x:0 , y :DDNavigationBarHeight , width : self.view.bounds.width , height : self.view.bounds.height - DDNavigationBarHeight - DDSliderHeight)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func willDismissSearchController(_ searchController: UISearchController){
        self.text = searchController.searchBar.text ?? ""
        self.tableView.reloadData()
    }
    func didDismissSearchController(_ searchController: UISearchController){

    }
}



extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.text.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tempCell : UITableViewCell!
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell"){
            tempCell = cell
        }else{
            tempCell  = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "UITableViewCell")
        }
        
        tempCell.backgroundColor = UIColor.randomColor
        let s = NSString(string: self.text)
        let beShow = s.substring(with: NSRange.init(location: indexPath.row, length: 1))
        tempCell.textLabel?.text = "输入的第\(indexPath.row)个字符:" +  beShow
        return tempCell
    }

}

var  DDNavigationBarHeight : CGFloat =  DDDevice.type == .iphoneX ? 88 : 64
let DDSliderHeight: CGFloat = (DDDevice.type == .iphoneX) ?  34 : 0

enum DeviceType:String {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6p
    case iphoneX
    case unkonw
}
class DDDevice: UIDevice {
    class var type : DeviceType{
        //竖屏模式下
        switch (UIScreen.main.bounds.height , UIScreen.main.bounds.width) {
        case (480 , 320) ,  (320 , 480 ):
            return .iPhone4
        case (568 , 320) , (320 ,568):
            return .iPhone5
        case (667,375) , (375 , 667):
            return .iPhone6
        case (736 , 414) , (414 , 736 ):
            return .iPhone6p
        case (812 , 375) , (375 , 812):
            return .iphoneX
        default:
            return .unkonw
        }
    }
    
    
}
