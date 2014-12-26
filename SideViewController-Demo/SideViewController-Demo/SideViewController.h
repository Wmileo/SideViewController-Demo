//
//  SideViewController.h
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, STATUS_TYPE){
    STATUS_LEFT,
    STATUS_RIGHT,
    STATUS_CENTER,
};

@interface SideViewController : UIViewController

@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) UIViewController *leftSideViewController;
@property (nonatomic, strong) UIViewController *rightSideViewController;

@property (nonatomic, assign) CGFloat maxLeftSideWidth;
@property (nonatomic, assign) CGFloat maxRightSideWidth;
@property (nonatomic, assign) CGFloat zoomScale;
@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, assign) STATUS_TYPE status;
@property (nonatomic, assign) BOOL canDrag;

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController;

-(void)showLeftSideFinish:(void(^)())finish;
-(void)showRightSideFinish:(void(^)())finish;
-(void)hideSideFinish:(void(^)())finish;

@end
