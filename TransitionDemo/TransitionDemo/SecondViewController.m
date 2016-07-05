//
//  SecondViewController.m
//  TransitionDemo
//
//  Created by 倪辉辉 on 16/6/29.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "SecondViewController.h"
#import "HHTransition.h"
#import "ThirdViewController.h"

@interface SecondViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.transitioningDelegate = self;
}
- (IBAction)dismissClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)popClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)PresentTo3:(UIButton *)sender {
    ThirdViewController *vc = [ThirdViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[HHTransition alloc] initWithType:1];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[HHTransition alloc] initWithType:1];
}

@end
