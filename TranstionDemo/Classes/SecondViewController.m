//
//  SecondViewController.m
//  TranstionDemo
//
//  Created by 刘凡 on 2017/3/22.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "SecondViewController.h"
#import "MoveInverseTransition.h"
#import "FirstViewController.h"

@interface SecondViewController ()<UINavigationControllerDelegate>

//返回手势
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置nav代理
    self.navigationController.delegate = self;
    
    //设置从边界滑入
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer =[[UIScreenEdgePanGestureRecognizer alloc]
                                                                 initWithTarget:self action:@selector(edgePanGesture:)];
    
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    
    [self.view addGestureRecognizer:edgePanGestureRecognizer];

}


-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    //计算手指的物理距离 （滑了多远,与起始位置无关)
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width *1.0);
    
    //把这个百分比限制在0~1之间;
    progress = MIN(1.0, MAX(0.0, progress));
    
    //当前手势刚刚开始，我们创建一个UIPercentDrivenInteractiveTransition 对象;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(recognizer.state == UIGestureRecognizerStateChanged ){
        //当手慢慢划入时， 我们把总体手势入的进度告诉 UIPercentDrivenInteractiveTransition 对象;
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if(recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state
             == UIGestureRecognizerStateEnded){
         //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }

}


#pragma mark - <UINavigationControllerDelegate>

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    
    if ([toVC isKindOfClass:[FirstViewController class]]) {
        MoveInverseTransition *inverseTransition =  [[MoveInverseTransition alloc]init];
        return inverseTransition;
    }else{
        return nil;
    }
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isKindOfClass:[MoveInverseTransition class]]) {
        return self.percentDrivenTransition;
    }else{
        return nil;
    }
}



@end
