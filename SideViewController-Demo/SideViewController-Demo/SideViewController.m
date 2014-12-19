//
//  SideViewController.m
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import "SideViewController.h"

typedef NS_ENUM(NSInteger, ANIMATION_TYPE) {
    ANIMATION_SHOW_LEFT,
    ANIMATION_SHOW_RIGHT,
    ANIMATION_HIDE_SIDE,
};

typedef NS_ENUM(NSInteger, SIDE_TYPE){
    SIDE_LEFT,
    SIDE_RIGHT
};

@interface SideViewController()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, readonly) CALayer *centerLayer;
@property (nonatomic, readonly) CALayer *leftLayer;
@property (nonatomic, readonly) CALayer *rightLayer;

@property (nonatomic, readonly) UIView *centerView;
@property (nonatomic, readonly) UIView *leftView;
@property (nonatomic, readonly) UIView *rightView;

@property (nonatomic, weak) UIView *sideView;

@end

@implementation SideViewController

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController{
    self = [super init];
    if (self) {

        self.centerViewController = centerViewController;
        self.maxLeftSideWidth = 180;
        self.maxRightSideWidth = 100;
        self.zoomScale = 0.7;
        self.duration = 0.3;
        
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
}

#pragma mark - controller

-(void)showLeftSide{

    [self willShowSide:SIDE_LEFT];
    
    CGRect rect = self.centerViewController.view.frame;
    CGRect rr = self.view.frame;
    rect.origin.x = self.maxLeftSideWidth - (rr.size.width - rr.size.width * self.zoomScale)/2;

    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:self.duration animations:^{
        self.centerViewController.view.frame = rect;
        self.centerViewController.view.transform = CGAffineTransformMakeScale(self.zoomScale, self.zoomScale);
    }];

}

-(void)hideSide{
    
    CGRect rect = self.centerViewController.view.frame;
    CGRect rr = self.view.frame;
    rect.origin.x = (rr.size.width - rr.size.width * self.zoomScale)/2;
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView animateWithDuration:self.duration animations:^{
        self.centerViewController.view.frame = rect;
        self.centerViewController.view.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        [self didHideSide];
    }];

}

-(void)showRightSide{
    [self willShowSide:SIDE_RIGHT];
    
    CGRect rect = self.centerViewController.view.frame;
    CGRect rr = self.view.frame;
    rect.origin.x = -self.maxRightSideWidth + (rr.size.width - rr.size.width * self.zoomScale)/2;
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:self.duration animations:^{
        self.centerViewController.view.frame = rect;
        self.centerViewController.view.transform = CGAffineTransformMakeScale(self.zoomScale, self.zoomScale);
    }];
}

-(void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    
    CGFloat touchX = [pan locationInView:self.view].x;
    NSLog(@"%f",touchX);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
        
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
        
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - gesturerecognizer

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.panGestureRecognizer) {
        
    }
    return YES;
}

#pragma mark - private

-(void)willShowSide:(SIDE_TYPE)type{
    self.sideView = (type == SIDE_LEFT)?self.leftView:self.rightView;
    if (self.sideView) {
        [self.view insertSubview:self.sideView belowSubview:self.centerView];
    }
}

-(void)didHideSide{
    if (self.sideView) {
        [self.sideView removeFromSuperview];
    }
}

-(void)addAnimation:(ANIMATION_TYPE)type{
    
    NSArray *positions,*scales;
    switch (type) {
        case ANIMATION_HIDE_SIDE:
            
            break;
        case ANIMATION_SHOW_LEFT:
            
            break;
        case ANIMATION_SHOW_RIGHT:
            
            break;
            
        default:
            break;
    }
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = self.duration;
    moveAnimation.delegate = self;
    [moveAnimation setValue:@"moveUpBack" forKey:@"identification"];
    moveAnimation.values = positions;
    [self.centerLayer addAnimation:moveAnimation forKey:@"moveUpBack"];
    
    if (type == ANIMATION_HIDE_SIDE) {
        
    }
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = self.duration;
    scaleAnimation.values = scales;
    [self.centerLayer addAnimation:scaleAnimation forKey:@"scaleUpBack"];
    
    
}

#pragma mark - set get
-(void)setCenterViewController:(UIViewController *)centerViewController{
    if (_centerViewController != centerViewController) {
        [self.view addSubview:centerViewController.view];
        if (self.centerView){
            [self.centerView removeGestureRecognizer:self.panGestureRecognizer];
            [self.centerView removeFromSuperview];
        }
        _centerViewController = centerViewController;
        [self.centerView addGestureRecognizer:self.panGestureRecognizer];
    }
}

-(UIPanGestureRecognizer *)panGestureRecognizer{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        _panGestureRecognizer.delegate = self;
    }
    return _panGestureRecognizer;
}

-(CALayer *)centerLayer{
    if (self.centerViewController){
        return self.centerViewController.view.layer;
    }else{
        return nil;
    }
}
-(CALayer *)leftLayer{
    if (self.leftSideViewController){
        return self.leftSideViewController.view.layer;
    }else{
        return nil;
    }
}
-(CALayer *)rightLayer{
    if (self.rightSideViewController) {
        return self.rightSideViewController.view.layer;
    }else{
        return nil;
    }
}
-(UIView *)centerView{
    if (self.centerViewController) {
        return self.centerViewController.view;
    }else{
        return nil;
    }
}
-(UIView *)leftView{
    if (self.leftSideViewController) {
        return self.leftSideViewController.view;
    }else{
        return nil;
    }
}
-(UIView *)rightView{
    if (self.rightSideViewController) {
        return self.rightSideViewController.view;
    }else{
        return nil;
    }
}
@end


