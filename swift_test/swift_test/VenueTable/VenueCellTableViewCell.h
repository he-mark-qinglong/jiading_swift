//
//  VenueCellTableViewCell.h
//  JiaDing_3D
//
//  Created by mark on 14-7-17.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentInfo : NSObject
@property NSString *title;
@property NSString *address;
@property NSString *phoneNumber;
@property NSString *pictureName;

+ (instancetype)withTitle:(NSString*)title
                  address:(NSString *)address
              phoneNumber:(NSString *)phoneNumber
              pictureName:(NSString *)pictureName;
@end


@interface VenueCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@property (weak, nonatomic) IBOutlet UIImageView *picture;

- (void)setWithContent:(ContentInfo*)info;
@end

