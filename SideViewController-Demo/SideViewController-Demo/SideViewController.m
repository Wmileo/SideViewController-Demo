//
//  SideViewController.m
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import "SideViewController.h"



@interface SideViewController()



@end

@implementation SideViewController

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController{
    self = [super init];
    if (self) {

        self.centerViewController = centerViewController;
        self.maxLeftSideWidth = 170;
        self.zoomScale = 0.7;
        self.duration = 0.3;
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.centerViewController.view];
    
}

#pragma mark - controller

-(void)showLeftSide{
    
    [self.view insertSubview:self.leftSideViewController.view belowSubview:self.centerViewController.view];
    
    CGRect rect = self.centerViewController.view.frame;
    rect.origin.x = self.maxLeftSideWidth;
    
//    CALayer *layer = self.centerViewController.view.layer;

    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:self.duration animations:^{
        self.centerViewController.view.frame = rect;
        self.centerViewController.view.transform = CGAffineTransformMakeScale(self.zoomScale, self.zoomScale);
    }];
    
    
    
//    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    moveAnimation.duration = 0.3;
//    moveAnimation.delegate = self;
//    [moveAnimation setValue:@"moveDownBack" forKey:@"identification"];
    
//    CGPoint point = layer.position;
//    point.x += 100;
//    
//    NSValue *v1 = [NSValue valueWithCGPoint:layer.position];
//    NSValue *v2 = [NSValue valueWithCGPoint:point];
//    
//    moveAnimation.values = @[v1,v2];
//    [layer addAnimation:moveAnimation forKey:@"moveDownBack"];
//    
//    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.duration = 0.3;
//    scaleAnimation.values = @[@1,@0.5];
//    [layer addAnimation:scaleAnimation forKey:@"scaleDownBack"];
    
    
//    NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(<#selector#>) userInfo:<#(id)#> repeats:<#(BOOL)#>
    
//    self.centerViewController.view.layer.duration = 1;
//    layer.transform = CATransform3DMakeScale(0.7,  0.7, 1);
//    layer.duration = 1;
//    layer.frame = rect;
    
//    [UIView animateWithDuration:1 animations:^{
//        layer.transform =
//    }];
    

}

-(void)hideSide{
    
    CGRect rect = self.centerViewController.view.frame;
    NSLog(@"%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    CGRect rr = self.view.frame;
    rect.origin.x = (rr.size.width - rr.size.width * self.zoomScale)/2;
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:self.duration animations:^{
        self.centerViewController.view.frame = rect;
        self.centerViewController.view.transform = CGAffineTransformMakeScale(1, 1);
    }];

}

@end


