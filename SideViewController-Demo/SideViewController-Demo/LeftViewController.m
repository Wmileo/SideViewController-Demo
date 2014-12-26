//
//  LeftViewController.m
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"

@implementation LeftViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(150, 40, 50, 50)];
    button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(hideSide) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)hideSide{
    [((AppDelegate *)([UIApplication sharedApplication].delegate)).sideViewController hideSideFinish:nil];
}

@end
