//
//  HHTransition.m
//  TransitionDemo
//
//  Created by 倪辉辉 on 16/6/29.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "HHTransition.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define  SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface HHTransition ()

@end

@implementation HHTransition

- (instancetype)initWithType:(HHTransitionType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _transitionContext = transitionContext;
    switch (_type) {
        case HHTransitionTypePush: {
            [self doPushAnimation];
            break;
        }
        case HHTransitionTypePresent: {
            [self doPresentAnimation];
            break;
        }
    }
}

- (void)doPushAnimation{
    
    NSLog(@"是通过push pop 操作");
    UIViewController *fromVC = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _fromViewController = fromVC;
    
    UIViewController *toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containterView = [_transitionContext containerView];
    
    
    [containterView addSubview:toVC.view];
    [containterView addSubview:fromVC.view];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500;
    fromVC.view.layer.transform = transform;
    fromVC.view.layer.anchorPoint = CGPointMake(1, .5);
    fromVC.view.layer.position = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = [self transitionDuration:_transitionContext];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI_2);
    animation.delegate = self;
    [fromVC.view.layer addAnimation:animation forKey:@"ratationAnimation"];
    
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self animationEnd];
}
- (void)animationEnd{
    UIViewController *toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.hidden = NO;
        // [_fromViewcontroller.view removeFromSuperview];
        [_transitionContext finishInteractiveTransition];
        [_transitionContext completeTransition:YES];
}

- (void)doPresentAnimation{
    NSLog(@"是 Present dismiss 操作");
    UIViewController *fromVC = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _fromViewController = fromVC;
    
    UIViewController *toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containterView = [_transitionContext containerView];
    
    [containterView addSubview:toVC.view];
    
//    UIGraphicsBeginImageContext(fromVC.view.frame.size);
//    [fromVC.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage* viewImage =UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

    toVC.view.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [self animationEnd];
    }];
}
@end
