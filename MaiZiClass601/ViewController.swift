//
//  ViewController.swift
//  MaiZiClass601
//
//  Created by 叶俊中 on 2016/11/28.
//  Copyright © 2016年 叶俊中. All rights reserved.
//

import UIKit
import Alamofire//网络请求库
import Kingfisher//图片加载
import PullToRefresh//下拉刷新
import SwiftyJSON//json解析




class ViewController: UIViewController,TitleSegmentDelegate {

    let firstURL = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&passport=&devId=ECIDH5J3VtJNmnlsgmFGFUgU324iLqCs%2FTN6KzBE6GrzJ6En48foT5R9wH%2FOcJXY&size=20&version=6.0&spever=false&net=wifi&lat=BNsQafMiQurgbJgINKDqOA%3D%3D&lon=bSHK%2B1pn5rA0G0bX3U5%2FOQ%3D%3D&ts=1460300866&sign=sZkXOQmPZa571vREFlmf4Ko0tVPzkKGHYxTTQ3x8M1N48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
    
    let second = "http://c.3g.163.com/nc/article/headline/T1348647853363/20-20.html?from=toutiao&passport=&devId=ECIDH5J3VtJNmnlsgmFGFUgU324iLqCs%2FTN6KzBE6GrzJ6En48foT5R9wH%2FOcJXY&size=20&version=7.0&spever=false&net=wifi&lat=&lon=&ts=1461501767&sign=mXgNK3x2QjdojToKQTv6IaORy9YlCvx7kPOlbxq9e2B48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
    
    let CellSnap  = "SnapTableViewCell"
    let CellImage = "ImageTableViewCell"
    
    var imageURLArray : Array<String>?
    var tableViewProtocol : TableviewProtocol?
    
    lazy var segment : TitleSegment = {
        
        let temp = TitleSegment.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40))
        temp.titleArray = ["头条", "娱乐", "热点" ,"体育" ,"北京", "网易", "财经", "科技"]
        temp.delegate = self
        
        return temp
        
    }()
    
    lazy var topView : ScrollImageView = {
        
        let temp = ScrollImageView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 190))
        
        return temp
        
    }()
    
    lazy var tableView : UITableView = {
        
        let temp = UITableView.init(frame: CGRect(x: 0, y: 40, width: self.view.bounds.width, height: self.view.bounds.height - 40 - 64))
        
        return temp
        
    }()
    
    var refresher = PullToRefresh()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavgationBar()
        addSubView()
        setupSubview()
        setupLayout()
        
        getDataFromServer()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    MARK: - ViewSetup
    
    func setupNavgationBar() {
        
        self.navigationController?.navigationBar.isTranslucent  = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 0.86, green: 0.2, blue: 0.22, alpha: 1)
        
    }
    
    func addSubView() {
        
        self.view.addSubview(segment)
        self.view.addSubview(tableView)
        
    }
    
    func setupLayout() {
        
    }
    
    func setupSubview() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.register(SnapTableViewCell.self, forCellReuseIdentifier: CellSnap)
        self.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: CellImage)
        
        self.tableView.addPullToRefresh(self.refresher) {
            
            self.getDataFromServer()
            
        }
        
    }
    
    //    MARK: - Private
    
    func getDataFromServer() {
        
        let url = firstURL
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            switch response.result {
            case let .success(data):
                
                let json = JSON(data)
                
                let adArray: Array<JSON> = json["T1348647853363"][0]["ads"].arrayValue
                
                self.topView.imageURLArray = adArray.map({ adDic -> String in
                    
                    return adDic["imgsrc"].stringValue
                    
                })
                
                if let tempArray: NSArray = json["T1348647853363"].arrayObject as NSArray? {
                    
                    let newsArray = tempArray.subarray(with: NSRange(location: 1,length: tempArray.count - 1))
                    
                    self.setupTableViewData(newsArray as NSArray?)
                    
                }
                
                self.tableView.tableHeaderView = self.topView//首行
                self.tableView.reloadData()
                
            case .failure:
                print("\(response.result.error)")
                
            }
            
        }
        
    }
    
    func setupTableViewData(_ array : NSArray?) {
        
        self.tableViewProtocol = TableviewProtocol()
        
        self.tableViewProtocol?.newsArray = array;
        
        self.tableView.delegate = self.tableViewProtocol
        self.tableView.dataSource = self.tableViewProtocol
        
    }
    
    //    MARK: - delegate
    
    func buttonDidClicked(_ index: Int) {
        
        print("点击\(index)")
        
    }



}

