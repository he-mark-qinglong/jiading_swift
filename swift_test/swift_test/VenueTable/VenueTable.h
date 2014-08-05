//
//  VenueTable.h
//  JiaDing_3D
//
//  Created by mark on 14-7-17.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueTable : UITableView<UITableViewDataSource, UITableViewDelegate>

@property UINavigationController *navigationController;

- (void)setupData;
@end
