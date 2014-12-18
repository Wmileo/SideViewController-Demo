//
//  SideViewController.h
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideViewControllerDelegate <NSObject>

-(void)willShowLeftSide;
-(void)didShowLeftSide;

-(void)willShowRightSide;
-(void)didShowRightSide;

-(void)willHideSide;
-(void)didHideSide;

@end

@interface SideViewController : UIViewController

@property (nonatomic, assign) id<SideViewControllerDelegate> delegate;

@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) UIViewController *leftSideViewController;
@property (nonatomic, strong) UIViewController *rightSideViewController;

@property (nonatomic, assign) CGFloat maxLeftSideWidth;
@property (nonatomic, assign) CGFloat maxRightSideWidth;
@property (nonatomic, assign) CGFloat zoomScale;
@property (nonatomic, assign) NSTimeInterval duration;

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController;

-(void)showLeftSide;
-(void)showRightSide;
-(void)hideSide;

@end
