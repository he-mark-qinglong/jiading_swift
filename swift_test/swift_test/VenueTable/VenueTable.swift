//
//  VenueTable.swift
//  swift_test
//
//  Created by mark on 14-8-1.
//  Copyright (c) 2014年 mark. All rights reserved.
//

import Foundation

class VenueTable:UITableView, UITableViewDataSource, UITableViewDelegate
{
    var navigationController:UINavigationController?
    var contents:Array<AnyObject>? = nil
    var pictureName:String = "test.jpg"
    
    func setupData(){
        if(self.contents == nil || self.contents!.count == 0 ){
            self.contents = [
                ContentInfo(title: "嘉定竹刻博物馆", address: "嘉定区南大街321号",
                    phoneNumber: "021-59537232", pictureName: pictureName),
                ContentInfo( title: "韩天衡美术馆", address: "博乐路70号",
                    phoneNumber: "021-59923360", pictureName: pictureName),
                ContentInfo( title: "嘉定镇街道文化活动", address:"清河路196号",
                    phoneNumber:"021-59537640",pictureName: pictureName),
                ContentInfo( title:"法华塔", address:"上海嘉定区南大街349号",
                    phoneNumber:"021-59927867", pictureName:pictureName)
            ];
        }
    }
    
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int) ->Int{
        return 4
    }
    func tableView( tableView:UITableView!, heightForRowAtIndexPath indexPath:NSIndexPath )
    ->Int {
        return 120
    }
    func tableView( tableView:UITableView!, cellForRowAtIndexPath indexPath:NSIndexPath )
    ->UITableViewCell{
        let row = indexPath.row
        let info:ContentInfo = self.contents![row] as ContentInfo
        let cell:VenueCell = NSBundle.mainBundle()
            .loadNibNamed("VenueCell", owner:nil,  options:nil)![0] as VenueCell
        cell.setWithContent(info)
        return cell;
    }
}