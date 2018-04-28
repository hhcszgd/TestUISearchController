//
//  MySearchResultsController.swift
//  Test UISearchController
//
//  Created by WY on 2018/4/28.
//  Copyright © 2018年 HHCSZGD. All rights reserved.
//

import UIKit

class MySearchResultsController: UIViewController , UISearchResultsUpdating{

    var text = ""
    let tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
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
//        tableView.backgroundColor = UIColor.orange
        tableView.frame = CGRect(x:0 , y :0 , width : self.view.bounds.width , height : self.view.bounds.height - DDNavigationBarHeight - DDSliderHeight)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func updateSearchResults(for searchController: UISearchController){
        self.text = searchController.searchBar.text ?? ""
        self.tableView.reloadData()
    }
}



extension MySearchResultsController : UITableViewDelegate , UITableViewDataSource {
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
        tempCell.textLabel?.text = beShow
        return tempCell
    }
    
}
extension UIColor{
    class var randomColor : UIColor  {
        get{
            let r = CGFloat(arc4random_uniform(225)) / 255.0
            let g = CGFloat(arc4random_uniform(225)) / 255.0
            let b = CGFloat(arc4random_uniform(225)) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: 1)
        }
    }
}
