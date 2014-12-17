//
//  SideViewController.h
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideViewController : UIViewController

@property (nonatomic, strong) UIViewController *centerViewController;
@property (nonatomic, strong) UIViewController *leftSideViewController;
@property (nonatomic, strong) UIViewController *rightSideViewController;

@property (nonatomic, assign) CGFloat maxLeftSideWidth;
@property (nonatomic, assign) CGFloat maxRightSideWidth;

@end
