//
//  ViewController.m
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

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
    
        UIActivityIndicatorView *wait = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        wait.frame = CGRectMake(0, 0, self.width, self.width);
        wait.center = CGPointMake(320/2, 320/2);
//        wait.backgroundColor = [UIColor greenColor];
        [wait startAnimating];
        [self.view addSubview:wait];
    
    UIView *piont = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 200)];
    piont.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:piont];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showLeft{
    [((AppDelegate *)([UIApplication sharedApplication].delegate)).sideViewController showLeftSide];
}

@end
