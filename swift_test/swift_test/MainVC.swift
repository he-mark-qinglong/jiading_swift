//
//  MainVC.swift
//  swift_test
//
//  Created by mark on 14-7-31.
//  Copyright (c) 2014年 mark. All rights reserved.
//

import Foundation
import UIKit

func isIphone5() -> Bool{
    return UIScreen.mainScreen().bounds.size.height == 568
}

class MainVC: UIViewController{
    @IBOutlet var changguan_btn : UIButton!
    @IBOutlet var zhanpin_btn : UIButton!
    @IBOutlet var shoucang_btn : UIButton!
    @IBOutlet var mainView : UIView!
    
    @IBOutlet var tableView : VenueTable!
    @IBOutlet var scrollView : UIScrollView!
    
    @IBOutlet var qiciBtn : UIButton!
    @IBOutlet var huihuaBtn : UIButton!
    @IBOutlet var yuqiBtn : UIButton!
    @IBOutlet var wenhuajiadingBtn : UIButton!
    @IBOutlet var zukeBtn : UIButton!
    @IBOutlet var shufaBtn : UIButton!
    @IBOutlet var qingtongBtn : UIButton!
    @IBOutlet var kejuBtn : UIButton!
    
    @IBOutlet var topBtnImg : UIImageView!
    
    func rac_settings(){
        
        //使用这句话之后只需要改变scrollViewB是否隐藏就可以了，另一个会自动跟着变成相反的状态
        RAC(self.scrollView, "hidden") <= RACObserve(self.tableView, keyPath: "hidden")
            .map{  value in
                //不通的按钮点击会改变hidden属性，然后跟着改变顶部图片的内容。
                if(value.boolValue == true){
                    self.topBtnImg.image = UIImage(named:"tt_场馆.png");
                }else{
                    self.topBtnImg.image = UIImage(named:"tt_展品.png");
                }
                return !value.boolValue;
        }
        
        //两个按钮的点击切换不同的内容。
        self.changguan_btn.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
            .subscribeNext {
                _ in
                self.tableView.hidden = true;
        }
        self.zhanpin_btn.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
            .subscribeNext{
                _ in
                self.tableView.hidden = false;
        }
        //收藏按钮
        self.shoucang_btn.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
            .subscribeNext{
                _ in
                let vc = UIViewController();
                self.navigationController?.pushViewController(vc, animated:false);
                //设置标题和背景
                let lb = UILabel(frame:CGRectMake(0, 0, 100, 30))
                lb.font      = UIFont(name:"", size:15)
                lb.textColor = UIColor.blueColor();
                lb.text      = "收藏";
                vc.navigationItem.titleView = lb;
        }
        
        //TODO，修改为对应的UIViewController.也有可能是同一个ViewController，但是参数不同
        let ciqi_vc           = UIViewController()
        let yuqi_vc           = UIViewController()
        let huihua_vc         = UIViewController()
        let wenhuajiading_vc  = UIViewController()
        let zuke_vc           = UIViewController()
        let shufa_vc          = UIViewController()
        let qingtong_vc       = UIViewController()
        let keju_vc           = UIViewController()
        
        var btns2Actions: NSDictionary = [
            "瓷器":[self.qiciBtn, ciqi_vc],
            "玉器":[self.yuqiBtn, yuqi_vc],
            "绘画":[self.huihuaBtn, huihua_vc],
            "文化嘉定":[self.wenhuajiadingBtn, wenhuajiading_vc],
            "竹刻":[self.zukeBtn, zuke_vc],
            "书法":[self.shufaBtn, shufa_vc],
            "青铜":[self.qingtongBtn, qingtong_vc],
            "科举":[self.kejuBtn, keju_vc]]
        //定制每个button事件跳转的视图控制器。
        for (_, value): (AnyObject, AnyObject) in btns2Actions {
            let array = value as! NSArray;
            let btn        = array[0]as! UIButton;
            let vc:UIViewController = array[1] as! UIViewController;
            btn.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
                .subscribeNext { _ in
                    self.navigationController?.pushViewController(vc, animated:false)
            }
        }
    }
    
    //设置导航栏隐藏
    override func viewDidAppear(animated:Bool){
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated:true);
    }
    
    override func viewDidDisappear(animated:Bool){
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated:false);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rac_settings()
        
        self.mainView.backgroundColor = UIColor.clearColor()
        if(!isIphone5()){
            self.scrollView.contentSize = CGSizeMake(0, 600)
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x,
                self.tableView.frame.origin.y,
                self.tableView.frame.size.width,
                400)
        }
        
        self.tableView.navigationController = self.navigationController
        self.tableView.delegate        = self.tableView
        self.tableView.dataSource      = self.tableView
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.setupData()
        
        //A和B是隐藏显示关系相反，RAC中观察了一个，另一个就不用跟着改了。
        self.tableView.hidden = true;
    }
}