//
//  ViewController.m
//  TransitionDemo
//
//  Created by 倪辉辉 on 16/6/29.
//  Copyright © 2016年 倪辉辉. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

#import "HHTransition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
{
    UIScreenEdgePanGestureRecognizer *_pan;
    UIScreenEdgePanGestureRecognizer *_pan2;
    UIPercentDrivenInteractiveTransition *_interaction;
}
@property (weak, nonatomic) IBOutlet UIButton *presentBtn;
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
@property (assign ,nonatomic)HHTransitionType type;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.transitioningDelegate = self;
    
    _pan  = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlEdgeScreenPanGesture:)];
    _pan.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:_pan];
    _pan2  = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlEdgeScreenPanGesture:)];
    _pan2.edges = UIRectEdgeBottom;
    [self.view addGestureRecognizer:_pan2];
}

- (void)handlEdgeScreenPanGesture:(UIScreenEdgePanGestureRecognizer *)pan{
    NSLog(@"x position is %f",[pan translationInView:self.view].x);
    CGFloat progress = (-1 * [pan translationInView:self.view].x)/CGRectGetWidth(self.view.frame);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _interaction = [[UIPercentDrivenInteractiveTransition alloc] init];
            if (pan == _pan) {
                [self push];
            }else{
                [self Present];
            }
            
            
            break;
        case UIGestureRecognizerStateChanged:
            [_interaction updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (progress >= 0.5) {
                [_interaction finishInteractiveTransition];
            }else {
                [_interaction cancelInteractiveTransition];
                [self.navigationController popViewControllerAnimated:YES];
            }
            _interaction = nil;
        }
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)PresentClick:(UIButton *)sender {
//    self.type = HHTransitionTypePresent;
//    SecondViewController *vc = [SecondViewController new];
//    [self presentViewController:vc animated:YES completion:nil];
    [self Present];
}
- (IBAction)pushClick:(UIButton *)sender {
//    self.type = HHTransitionTypePush;
//    SecondViewController *vc = [SecondViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    [self push];
}
- (void)push{
    self.type = HHTransitionTypePush;
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)Present{
    self.type = HHTransitionTypePresent;
    SecondViewController *vc = [SecondViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[HHTransition alloc] initWithType:_type];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[HHTransition alloc] initWithType:1];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return _interaction;
}

#pragma mark UINavigationControllerDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0){
    return _interaction;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    
    HHTransition *t;
    if(operation == UINavigationControllerOperationPush){
        
    }else if (operation == UINavigationControllerOperationPop){
    
    }
    t = [[HHTransition alloc] initWithType:_type];
    return t;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"...");
}

@end
