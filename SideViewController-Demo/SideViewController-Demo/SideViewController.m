//
//  SideViewController.m
//  SideViewController-Demo
//
//  Created by ileo on 14/12/17.
//  Copyright (c) 2014年 ileo. All rights reserved.
//

#import "SideViewController.h"

#define LEFT_SIDE 40

typedef NS_ENUM(NSInteger, ANIMATION_TYPE) {
    ANIMATION_SHOW_LEFT,
    ANIMATION_SHOW_RIGHT,
    ANIMATION_HIDE_SIDE,
};

#define k_IDENTIFICATION @"identification"
#define k_FINISH_BLOCK @"finish_block"
#define k_POSITION @"position"
#define k_SCALE @"scale"

#define kAnimationShowLeft @"ANIMATION_SHOW_LEFT"
#define kAnimationShowRight @"ANIMATION_SHOW_RIGHT"
#define kAnimationHideSide @"ANIMATION_HIDE_SIDE"

typedef NS_ENUM(NSInteger, SIDE_TYPE){
    SIDE_LEFT,
    SIDE_RIGHT
};

#define NSVALUE_POINT(point) [NSValue valueWithCGPoint:point]

@interface SideViewController()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, readonly) CALayer *centerLayer;
@property (nonatomic, readonly) CALayer *leftLayer;
@property (nonatomic, readonly) CALayer *rightLayer;

@property (nonatomic, readonly) UIView *centerView;
@property (nonatomic, readonly) UIView *leftView;
@property (nonatomic, readonly) UIView *rightView;

@property (nonatomic, weak) UIView *sideView;

@property (nonatomic, assign) CGFloat touchX;
@property (nonatomic, assign) BOOL isStartAnimation;
@property (nonatomic, assign) CFTimeInterval lastTimeOffSet;
@property (nonatomic, assign) CGFloat ratio;

@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation SideViewController

-(instancetype)initWithCenterViewController:(UIViewController *)centerViewController{
    self = [super init];
    if (self) {
        self.centerViewController = centerViewController;
        self.maxLeftSideWidth = 190;
        self.maxRightSideWidth = 100;
        self.zoomScale = 0.7;
        self.duration = 0.2;
        self.isStartAnimation = NO;
        self.status = STATUS_CENTER;
        self.canDrag = YES;
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
}

#pragma mark - controller

-(void)showLeftSideFinish:(void (^)())finish{
    [self addAnimation:ANIMATION_SHOW_LEFT finish:finish];
}

-(void)hideSideFinish:(void (^)())finish{
    [self addAnimation:ANIMATION_HIDE_SIDE finish:finish];
}

-(void)showRightSideFinish:(void (^)())finish{
    [self addAnimation:ANIMATION_SHOW_RIGHT finish:finish];
}

-(void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    
    CGFloat touchX = [pan locationInView:self.view].x;

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"start");
            self.isStartAnimation = YES;
            self.centerLayer.speed = 0;
            self.touchX = touchX;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {

            self.isStartAnimation = NO;
            self.centerLayer.speed = 1;
            self.centerLayer.timeOffset = 0;
            self.centerLayer.beginTime = 0;
            
            CFTimeInterval pausedTime = self.lastTimeOffSet;
            
            self.centerLayer.beginTime = [self.centerLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;

        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (self.isStartAnimation) {
                self.isStartAnimation = NO;
                switch (self.status) {
                    case STATUS_CENTER:
                        [self addAnimation:ANIMATION_SHOW_LEFT finish:nil];
                        self.ratio = self.maxLeftSideWidth * 5;
                        break;
                    case STATUS_LEFT:
                        [self addAnimation:ANIMATION_HIDE_SIDE finish:nil];
                        self.ratio = self.maxLeftSideWidth * 5;
                        break;
                    case STATUS_RIGHT:
                        [self addAnimation:ANIMATION_HIDE_SIDE finish:nil];
                        self.ratio = self.maxRightSideWidth * 5;
                        break;
                    default:
                        break;
                }
            }
            self.lastTimeOffSet = (touchX - self.touchX)/self.ratio;
            if (self.status == STATUS_LEFT) {
                self.lastTimeOffSet = -self.lastTimeOffSet;
            }
            if (self.lastTimeOffSet < 0.015) {
                self.lastTimeOffSet = 0.015;
            }
            self.centerLayer.timeOffset = self.lastTimeOffSet;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - gesturerecognizer

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.panGestureRecognizer) {
        
        if (!self.canDrag) {
            return NO;
        }
        
        CGFloat touchX = [gestureRecognizer locationInView:self.view].x;
        
        switch (self.status) {
            case STATUS_CENTER:
                if (touchX < LEFT_SIDE) {
                    return YES;
                }
                break;
            case STATUS_LEFT:
                return YES;
                break;
            case STATUS_RIGHT:
                return YES;
                break;
                
            default:
                break;
        }
        
    }
    return NO;
}

#pragma mark - private

-(void)willShowSide:(SIDE_TYPE)type{
    self.sideView = (type == SIDE_LEFT)?self.leftView:self.rightView;
    if (self.sideView) {
        if ([self.view.subviews containsObject:self.sideView]) {
            [self.sideView removeFromSuperview];
        }
        [self.view insertSubview:self.sideView belowSubview:self.centerView];
    }
}

-(void)didShowSide{
    self.centerButton.frame = self.centerView.bounds;
    [self.centerView addSubview:self.centerButton];
}

-(void)didHideSide{
    if (self.sideView) {
        [self.sideView removeFromSuperview];
    }
    [self.centerButton removeFromSuperview];
}

-(void)addAnimation:(ANIMATION_TYPE)type finish:(void(^)())finish{
    
    CGPoint point = self.centerLayer.position;
    CGFloat scale;
    
    NSArray *positions,*scales;
    NSString *identification;
    
    CGFloat view_width = self.view.frame.size.width;
    
    STATUS_TYPE status;
    switch (type) {
        case ANIMATION_HIDE_SIDE:
            scales = @[@(self.zoomScale),@1];
            point.x = view_width / 2;
            identification = kAnimationHideSide;
            status = STATUS_CENTER;
            break;
        case ANIMATION_SHOW_LEFT:
            [self willShowSide:SIDE_LEFT];
            scales = @[@1,@(self.zoomScale)];
            point.x = self.maxLeftSideWidth + (view_width * self.zoomScale) /2;
            identification = kAnimationShowLeft;
            status = STATUS_LEFT;
            break;
        case ANIMATION_SHOW_RIGHT:
            [self willShowSide:SIDE_RIGHT];
            identification = kAnimationShowRight;
            scales = @[@1,@(self.zoomScale)];
            point.x = view_width - (view_width * self.zoomScale)/2 - self.maxRightSideWidth;
            status = STATUS_RIGHT;
            break;
        default:
            break;
    }
    
    scale = [[scales lastObject] floatValue];
    positions = @[NSVALUE_POINT(self.centerLayer.position),NSVALUE_POINT(point)];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = self.duration;
    moveAnimation.values = positions;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = self.duration;
    scaleAnimation.values = scales;

    __weak __typeof(self) wself = self;
    void(^Finish)() = ^{
        wself.status = status;
        if (finish) {
            finish();
        }
        if (status == STATUS_CENTER) {
            [wself didHideSide];
        }else{
            [wself didShowSide];
        }
    };

    scaleAnimation.delegate = self;
    [scaleAnimation setValue:Finish forKey:k_FINISH_BLOCK];
    
    [self.centerLayer addAnimation:moveAnimation forKey:k_POSITION];
    [self.centerLayer addAnimation:scaleAnimation forKey:k_SCALE];
    
    self.centerLayer.position = point;
    self.centerLayer.transform = CATransform3DMakeScale(scale, scale, scale);
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim valueForKey:k_FINISH_BLOCK]) {
        void(^finish)() = [anim valueForKey:k_FINISH_BLOCK];
        if (finish) {
            finish();
        }
    }
}

#pragma mark - set get
-(void)setCenterViewController:(UIViewController *)centerViewController{
    if (_centerViewController != centerViewController) {
        BOOL hasLast = NO;
        CGPoint point;
        CATransform3D transform;
        if (_centerViewController) {
            point = self.centerLayer.position;
            transform = self.centerLayer.transform;
            hasLast = YES;
        }
        [self.view addSubview:centerViewController.view];
        if (self.centerView){
            [self.centerView removeGestureRecognizer:self.panGestureRecognizer];
            [self.centerView removeFromSuperview];
        }
        _centerViewController = centerViewController;
        [self.centerView addGestureRecognizer:self.panGestureRecognizer];
        if (hasLast) {
            self.centerLayer.position = point;
            self.centerLayer.transform = transform;
        }
    }
    if (self.status != STATUS_CENTER) {
        [self hideSideFinish:nil];
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
-(UIButton *)centerButton{
    if (!_centerButton) {
        _centerButton = [[UIButton alloc] initWithFrame:CGRectNull];
        [_centerButton addTarget:self action:@selector(clickOnCenterButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}
-(void)clickOnCenterButton{
    [self addAnimation:ANIMATION_HIDE_SIDE finish:nil];
}
@end


