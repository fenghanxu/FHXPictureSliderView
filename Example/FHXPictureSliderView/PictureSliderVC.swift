//
//  PictureSliderVC.swift
//  FHXPictureSliderView_Example
//
//  Created by 冯汉栩 on 2018/8/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import FHXPictureSliderView

class PictureSliderVC: UIViewController {
  
   fileprivate let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
         buildUI()
      
    }

  func buildUI(){
    view.backgroundColor = UIColor.white
    view.addSubview(tableView)
    buildSubview()
    buildLayout()
  }
  
  func buildSubview(){
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.backgroundColor = UIColor.white
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.register(PictureSliderTableCell.self, forCellReuseIdentifier: "kPictureSliderTableCell")
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 200
  }
  
  func buildLayout(){
    tableView.snp.makeConstraints { (make) in
      make.left.right.equalToSuperview()
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }

}

extension PictureSliderVC:UITableViewDataSource,UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "kPictureSliderTableCell", for: indexPath) as! PictureSliderTableCell
    cell.choose = .Network
    cell.model = [
      "http://e.hiphotos.baidu.com/image/h%3D300/sign=ce18bf50dbca7bcb627bc12f8e086b3f/a2cc7cd98d1001e98517929cb40e7bec54e7977e.jpg",
      "http://f.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f2fe05953ecfe9925bd317dab.jpg",
      "http://c.hiphotos.baidu.com/image/pic/item/f11f3a292df5e0fe437d0e92506034a85edf7238.jpg",
      "http://d.hiphotos.baidu.com/image/pic/item/3b292df5e0fe992567f5eec338a85edf8cb171ac.jpg",
      "http://e.hiphotos.baidu.com/image/pic/item/aa18972bd40735facafdd12a92510fb30f240817.jpg"]
    return cell
  }
  
}
