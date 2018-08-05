//
//  ViewController.swift
//  FHXPictureSliderView
//
//  Created by fenghanxu on 08/04/2018.
//  Copyright (c) 2018 fenghanxu. All rights reserved.
//

import UIKit
import FHXPictureSliderView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = UIColor.white
      
      
      //创建View
      let iconView =  PictureSliderView()
      //添加view
      view.addSubview(iconView)
      //约束view
      iconView.snp.makeConstraints { (make) in
        make.center.equalToSuperview()
        make.width.equalToSuperview()
        make.height.equalTo(200)
      }
      //本地显示
//      iconView.choose = .Local
//      iconView.model = ["0","1","2","3","4","5","6","7","8"]
      //网络图片
      iconView.choose = .Network
      iconView.model = [
        "http://e.hiphotos.baidu.com/image/h%3D300/sign=ce18bf50dbca7bcb627bc12f8e086b3f/a2cc7cd98d1001e98517929cb40e7bec54e7977e.jpg",
        "http://f.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f2fe05953ecfe9925bd317dab.jpg",
        "http://c.hiphotos.baidu.com/image/pic/item/f11f3a292df5e0fe437d0e92506034a85edf7238.jpg",
        "http://d.hiphotos.baidu.com/image/pic/item/3b292df5e0fe992567f5eec338a85edf8cb171ac.jpg",
        "http://e.hiphotos.baidu.com/image/pic/item/aa18972bd40735facafdd12a92510fb30f240817.jpg"]
      
    }


}

