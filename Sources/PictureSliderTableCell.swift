//
//  PictureSliderView
//  B7iOS
//
//  Created by 膳品科技 on 16/8/11.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit
import FHXColorAndFont

public class PictureSliderTableCell: UITableViewCell {
  
  fileprivate let kPictureSliderCell = "kPictureSliderCell"
  fileprivate let layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    layout.scrollDirection = .horizontal
    return layout
  }()
  
  fileprivate var collectionView: UICollectionView!
  fileprivate var pageControl = UIPageControl()
  
  //请求图片方式
  public var choose = PictureSliderView.Choose.Unknow
  /// 定时器
  fileprivate var timer : Timer?
  /// 数据数组
  public  var model:[String] = [String](){
    didSet{
      if model != oldValue {
        if model.count > 1 {
          removeTimer()
          beginTimer()
        }
        pageControl.numberOfPages = model.count
        pageControl.currentPage = 0
        collectionView.reloadData()
      }
    }
  }
  /// 轮播图数量倍数
  fileprivate let mulriple : Int = 9999
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    buildUI()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension PictureSliderTableCell {
  
  fileprivate func buildUI() {
    collectionView = UICollectionView(frame: self.bounds,
                                      collectionViewLayout: layout)
    addSubview(collectionView)
    addSubview(pageControl)
    buildLayout()
    buildSubView()
  }
  
  private func buildLayout() {
    collectionView.snp.makeConstraints { (make) in
      make.top.right.left.bottom.equalToSuperview()
    }
    
    pageControl.snp.makeConstraints { (make) in
      make.bottom.equalToSuperview()
      make.centerX.equalToSuperview()
    }
  }
  
  private func buildSubView() {
    
    pageControl.pageIndicatorTintColor = Color.white
    pageControl.currentPageIndicatorTintColor = Color.theme
    
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.isPagingEnabled = true
    collectionView.bounces = false
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout = layout
    collectionView.backgroundColor = Color.background
    collectionView.layer.contents = UIImage(named: "default-banner")?.cgImage
    
    collectionView.register(PictureSliderCell.self, forCellWithReuseIdentifier: kPictureSliderCell)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PictureSliderTableCell: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return frame.size
  }
  
}

// MARK: - 设置collectionView代理与数据源
extension PictureSliderTableCell : UICollectionViewDataSource,UICollectionViewDelegate{
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return  model.count * mulriple
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PictureSliderCell  = collectionView.dequeueReusableCell(withReuseIdentifier: kPictureSliderCell, for: indexPath) as! PictureSliderCell
        cell.choose = choose
        cell.model = model[indexPath.item % model.count]
        return cell
    }
  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let cellModel = model[indexPath.item % model.count]
//    switch cellModel.type {
//    case .shop:
//      let vc = UIStoryboard.viewController(with: ShopDetailViewController.self)
//      let shopModel = ShopModel()
//      shopModel.shopIid = cellModel.shopIid
//      vc.shopModel = shopModel
//      sp.viewController.sp.push(vc: vc, animated: true)
//    case .good:
//      let vc = UIStoryboard.viewController(with: GoodsDetailViewController.self)
//      vc.goodModel.goodsIid = cellModel.goodsIid
//      vc.goodModel.shopIid = cellModel.shopIid
//      sp.viewController.sp.push(vc: vc, animated: true)
//    case .webURL:
//      let vc = ActivityViewController()
//      vc.urlStr = cellModel.bannerUrl
//      sp.viewController.sp.push(vc: vc, animated: true)
//    case .unknown: SPLogs("未知类型")
//    }
//  }
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.width == 0 { return  }
    let offestX = scrollView.contentOffset.x
    pageControl.currentPage = Int(ceil(offestX / scrollView.width)) % model.count
  }
    
}


// MARK: - scroll - Delegate
extension PictureSliderTableCell{
  
  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    removeTimer()
  }

  public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                willDecelerate decelerate: Bool) {
    beginTimer()
  }
  
}

// MARK: - UI显示事件
extension PictureSliderTableCell{
  
  /// 开启定时器
  func beginTimer() {
    timer = Timer.scheduledTimer(timeInterval: 6.18,
                                 target: self,
                                 selector: #selector(pictureSlide),
                                 userInfo: nil,
                                 repeats: true)
    
    RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    
  }
  /// 移除定时器
  func removeTimer() {
    timer?.invalidate()
  }
  /// 开始轮播事件
  @objc func pictureSlide() {
    if model.isEmpty { return }
    guard let indexPath = collectionView.indexPathsForVisibleItems.last else { return }
    let nextIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
    guard nextIndexPath.item < (model.count * mulriple) else {
      removeTimer()
      return
    }
    collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
  }
}
