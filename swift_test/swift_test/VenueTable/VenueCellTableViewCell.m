//
//  VenueCellTableViewCell.m
//  JiaDing_3D
//
//  Created by mark on 14-7-17.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "VenueCellTableViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>  //@strongify/@weakify

@interface VenueCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@property BOOL isShared;
@property BOOL isCollected;
@end

@implementation VenueCellTableViewCell
@synthesize mainTitle, phoneNumber, address, picture;

- (BOOL)shareMe
{
    NSLog(@"share");
    return YES;
}

- (BOOL) addToCollection
{
    NSLog(@"collect");
    return YES;
}

- (BOOL )removeFromCollection
{
    return YES;
}

- (void)pointAtAddress
{
    
}

- (void)makeACall
{
    
}
- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    @weakify(self);
    
    [[self.shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         if(self.isShared == NO){
             if([self shareMe]){
                 [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"icon_share_on.png"]
                                     forState:UIControlStateNormal];
                 self.shareBtn.enabled = NO;
             }
         }
         self.isShared = !self.isShared;
     }];
    
    [[self.collectBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        @strongify(self);
        if(self.isCollected == NO){
            if([self addToCollection])
                [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon_shape_on.png"]
                                           forState:UIControlStateNormal];
        }else{
            if([self removeFromCollection])
                [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon_shape.png"]
                                           forState:UIControlStateNormal];
        }
        self.isCollected = !self.isCollected;
    }];
    [[self.addressBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self pointAtAddress];
     }];
    [[self.phoneBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         [self makeACall];
     }];
}

- (void)setWithContent:(ContentInfo*)info{
    self.mainTitle.text   = info.title;
    self.phoneNumber.text = info.phoneNumber;
    self.address.text     = info.address;
    self.picture.image    = [UIImage imageNamed:info.pictureName];
    //按钮相关的属性设置
    self.isShared         = NO;
    self.isCollected      = NO;
}
@end


@implementation ContentInfo
+ (instancetype)withTitle:(NSString*)title
                  address:(NSString *)address
              phoneNumber:(NSString *)phoneNumber
              pictureName:(NSString *)pictureName
{
    ContentInfo *content = [[ContentInfo alloc] init];
    content.title        = title;
    content.address      = address;
    content.phoneNumber  = phoneNumber;
    content.pictureName  = pictureName;
    return content;
}
@end