//
//  ThirdViewController.m
//  TransitionDemo
//
//  Created by 倪辉辉 on 16/6/29.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "ThirdViewController.h"
#import "HHTransition.h"

@interface ThirdViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.transitioningDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[HHTransition alloc] initWithType:1];
}

@end
