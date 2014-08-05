//
//  VenueTable.m
//  JiaDing_3D
//
//  Created by mark on 14-7-17.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "VenueTable.h"
#import "VenueCellTableViewCell.h"




@interface VenueTable()
@property NSArray *contents;
@end

@implementation VenueTable

- (void)setupData{
    if(self.contents == nil ||  self.contents.count == 0){
        static NSString * pictureName = @"test.jpg";
        self.contents =
        @[[ContentInfo withTitle:@"嘉定竹刻博物馆" address:@"嘉定区南大街321号"
                     phoneNumber:@"021-59537232" pictureName:pictureName],
          [ContentInfo withTitle:@"韩天衡美术馆" address:@"博乐路70号"
                     phoneNumber:@"021-59923360" pictureName:pictureName],
          [ContentInfo withTitle:@"嘉定镇街道文化活动" address:@"清河路196号"
                     phoneNumber:@"021-59537640" pictureName:pictureName],
          [ContentInfo withTitle:@"法华塔" address:@"上海嘉定区南大街349号"
                     phoneNumber:@"021-59927867" pictureName:pictureName],];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row;
    ContentInfo *info = self.contents[row];
    VenueCellTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"VenueCellTableViewCell"
                                                           owner:self  options:nil] lastObject];;
    [cell setWithContent:info];
    return cell;
}

@end
