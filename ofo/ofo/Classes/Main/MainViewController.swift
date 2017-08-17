//
//  MainViewController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    // MARK: - 控件属性
    /// 地图
//    @IBOutlet weak var mapView: MKMapView!
    
    /// 扫码用车面板视图
    @IBOutlet weak var panelView: UIView!
    
    /// 包含按钮的底部容器视图
    @IBOutlet weak var containerView: UIView!
    
    /// 扫码用车
    @IBOutlet weak var sweepCodeCarBtn: UIButton!
    
    /// 用户中心
    @IBOutlet weak var UserCenter: UIButton!
    
    /// 活动中心
    @IBOutlet weak var ActivityCenter: UIButton!

    
    // MARK: - 懒加载
    /// 导航栏底部阴影图片
    fileprivate lazy var shadowImageView: UIImageView = {
        let imV = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW, height: shadowImageViewH))
        imV.image = UIImage(named: "whiteImage")
        return imV
    }()
    
    
    /// 高德地图
    var mapView: MAMapView!
    
    /// 定位管理器
    var locationManager: AMapLocationManager!
    
    /// 搜索API
    var search: AMapSearchAPI!
    
    /// 大头针点标注数据
    var pin : MyPinAnnotation!
    
    /// 大头针视图
    var pinView: MAAnnotationView!
    
    /// 附近是否搜索
    var nearBySearch = true
    
    // 定位按钮
    @IBAction func btnPositionTapped(_ sender: UIButton) {
//        locationManager.startUpdatingLocation()
        nearBySearch = true
        searchNearbyYellowBike()
        
        
    }
    
    /// 警告按钮点击
//    @IBAction func btnReportTapped(_ sender: UIButton) {
//        navigationController?.performSegue(withIdentifier: "PresentReportSegue", sender: nil)
//    }
    
    
    
    /// 用户中心按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func UserCenterTap(_ sender: UIButton) {
        UserInfoTap()
    }
    
    
    /// 扫码用车按钮事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func sweepCodeCar(_ sender: UIButton) {
        
        scanQRCode()
    }
    
    /// 箭头按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func arrowBtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected  // 取反按钮状态
        
        if sender.isSelected {
            UIView.animate(withDuration: 0.25) {    // 平移动画
                // y值为: 正, 使得向下平移, 使得隐藏.
                self.containerView.transform = CGAffineTransform(translationX: 0, y: self.panelView.frame.size.height)
                self.sweepCodeCarBtn.transform = CGAffineTransform(translationX: 0, y: self.sweepCodeCarBtn.frame.size.height)
                self.UserCenter.transform = CGAffineTransform(translationX: 0, y: self.UserCenter.frame.size.height)
                self.ActivityCenter.transform = CGAffineTransform(translationX: 0, y: self.ActivityCenter.frame.size.height)
            }
            
        } else {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.transform = .identity
            })

            UIView.animate(withDuration: 0.3, delay: 0.1, options: [], animations: {
                self.sweepCodeCarBtn.transform = .identity
                self.UserCenter.transform = .identity
                self.ActivityCenter.transform = .identity
            }, completion: nil)
        }
        
    }

    // MARK: - 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
}

// MARK: - 配置UI
extension MainViewController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        addSubV()
        configNavigationBar()
        configMaMapView()
//        initLocationManager()
        
    }
    
    /// 添加控件
    private func addSubV() {
        view.addSubview(shadowImageView)
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 左边的item
        let imageView = UIImageView(image: UIImage(named: "yellowBikeLogo"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        
        // 隐藏返回按钮上的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // 修改导航栏按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    /// 配置高德地图
    private func configMaMapView() {
        mapView = MAMapView(frame: view.bounds)
        mapView.zoomLevel = 17      // 设置缩放级别
        
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow    // 追踪位置
        mapView.delegate = self
        
        // 构造主搜索对象 AMapSearchAPI，并设置代理。
        search = AMapSearchAPI()
        search.delegate = self
        
        view.insertSubview(mapView, at: 0)
    }
    
    /// 初始化定位管理器
    private func initLocationManager() {
        locationManager = AMapLocationManager()
//        locationManager.delegate = self
        locationManager.distanceFilter = 10
        locationManager.locatingWithReGeocode = true
    }

    
}

// MARK: - 事件监听
extension MainViewController {
    
    /// 扫描二维码
    fileprivate func scanQRCode() {
        // 获取storyboard
        let storyBoard = UIStoryboard(name: "QRCodeController", bundle: nil)
        let qrcodeVC = storyBoard.instantiateInitialViewController()
        present(qrcodeVC!, animated: true, completion: nil)     // motal展现
    }
    
    /// 用户信息按钮点击
    fileprivate func UserInfoTap() {
        
//        self.performSegue(withIdentifier: "PresentMenuSegue", sender: nil)
    }

    
    /// 搜索自定义位置
    ///
    /// - Parameter center: 2d地图
    func searchCustomLocation(_ center: CLLocationCoordinate2D) {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        
        // 设置关键字检索参数
        // 进行关键字检索的请求参数类为 AMapPOIKeywordsSearchRequest，其中 keywords 是必设参数。types 为搜索类型。
        request.keywords = "电影院"
        request.radius = 500            ///查询半径，范围：0-50000，单位：米 [default = 3000]
        request.requireExtension = true
        
        search.aMapPOIAroundSearch(request) // 发起POI关键字搜索
    }
    
    
    /// 搜索附近的小黄车
    func searchNearbyYellowBike() {
        searchCustomLocation(mapView.userLocation.coordinate)
    }
    
    
    /// 大头针动画
    func pinAnimation()  {
        //坠落效果，y轴加位移
        let endFrame = pinView.frame
        
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.pinView.frame = endFrame
        }, completion: nil)
        
    }
    

}

// MARK: - MAMapViewDelegate 协议
extension MainViewController: MAMapViewDelegate {
    
    /// 用户移动地图的交互
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - wasUserAction: 用户是否移动
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        
        if wasUserAction {
            pin.isLockedToScreen = true
            pinAnimation()
            searchCustomLocation(mapView.centerCoordinate)
        }
    }
    
    
    /// 地图初始化完成后
    ///
    /// - Parameter mapView: mapView
    func mapInitComplete(_ mapView: MAMapView!) {
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        pin.isLockedToScreen = true // 是否固定在屏幕一点

        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
        
        searchNearbyYellowBike()
    }
    
    /// 自定义大头针视图
    ///
    /// - Parameters:
    ///   - mapView: 地图view
    ///   - annotation: 指定的标注
    /// - Returns: 大头针视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
       
        //用户定义的位置，不需要自定义
        if annotation is MAUserLocation {
            return nil
        }
        
        if annotation is MyPinAnnotation {
            let reuseid = "anchor"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid)
            if av == nil {
                av = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            }
            // 设置大头针
            av?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            av?.canShowCallout = false
            
            pinView = av    // 赋值大头针
            return av
        }
        
        
        let reuseid = "reuseid"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid) as? MAPinAnnotationView
        
        if annotationView == nil {
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
        }
        
        if annotation.title == "正常可用" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        } else {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
        }
        
        annotationView?.canShowCallout = true    // 是否允许弹出callout
        annotationView?.animatesDrop = true      // 添加到地图时是否使用下落动画效果
        
        return annotationView
    }
}

// MARK: - AMapSearchDelegate 协议
extension MainViewController: AMapSearchDelegate {
    
    /// 搜索周边完成后的处理
    ///
    /// - Parameters:
    ///   - request: 请求
    ///   - response: 响应
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        guard response.count > 0  else {
            print("周边没有小黄车!!")
            return
        }
        
        // 遍历请求的结果
        for poi in response.pois {
            print(poi.name)
        }

        
        var annotations : [MAPointAnnotation] = []
        
        annotations = response.pois.map {
            let annotation = MAPointAnnotation()
            //latitude: 纬度      longitude: 经度
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude: CLLocationDegrees($0.location.longitude))
            
            if $0.distance < 400 {
                annotation.title = "红包区域内开锁任意小黄车"
                annotation.subtitle = "骑行10分钟可获得现金红包"
            } else {
                annotation.title = "正常可用"
            }
            
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        
        if nearBySearch {
            mapView.showAnnotations(annotations, animated: true)
            nearBySearch = !nearBySearch
        }
    }
    
    
}






