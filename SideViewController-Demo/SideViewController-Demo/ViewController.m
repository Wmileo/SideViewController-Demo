//
//  ViewController.m
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "LeftViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:showButton];
    [showButton addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    showButton.backgroundColor = [UIColor whiteColor];
    
    UIButton *butt = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 50)];
    butt.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:butt];
    [butt addTarget:self action:@selector(lalala) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showLeft{
    [((AppDelegate *)([UIApplication sharedApplication].delegate)).sideViewController showLeftSide];
}

-(void)lalala{
    [((AppDelegate *)([UIApplication sharedApplication].delegate)).sideViewController showRightSide];
//    [self.navigationController pushViewController:[[LeftViewController alloc] init] animated:YES];
}

@end
