//
//  HHTransition.h
//  TransitionDemo
//
//  Created by 倪辉辉 on 16/6/29.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HHTransitionType) {
    HHTransitionTypePush,
    HHTransitionTypePresent
    
};

@interface HHTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,strong)id transitionContext;
@property (nonatomic,strong) UIViewController* fromViewController;
@property (nonatomic,assign)HHTransitionType type;
@property (assign, nonatomic) BOOL reverse;
- (instancetype)initWithType:(HHTransitionType)type;
@end
