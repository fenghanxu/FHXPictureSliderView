//
//  PictureSliderCell.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/8/11.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit
import SnapKit

class PictureSliderCell: UICollectionViewCell {

  fileprivate let imageView = UIImageView()
  
  var choose = PictureSliderView.Choose.Unknow
  
  var model: String = String(){
    didSet{
      if model != oldValue {
        updateUI()
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    buildUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PictureSliderCell {
  
  fileprivate func updateUI() {
    switch choose {
    case .Local:
      imageView.image = UIImage(named: model) ?? UIImage()
    case .Network:
      imageView.setImage(urlStr: model, placeholder: UIImage())
    default:
      break
    }
    
    
  }

 fileprivate func buildUI() {
    self.addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }
}
