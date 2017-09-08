//
//  MoveInverseTransition.m
//  TranstionDemo
//
//  Created by 刘凡 on 2017/3/22.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "MoveInverseTransition.h"
#import "FirstViewController.h"
#import "CollectionViewCell.h"
#import "SecondViewController.h"


@implementation MoveInverseTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //获取动画前后两个vc 和发生的容器ControllerView
        FirstViewController *toVC = (FirstViewController *)[transitionContext
               viewControllerForKey:UITransitionContextToViewControllerKey];
        SecondViewController *fromVC = (SecondViewController *)[transitionContext
                viewControllerForKey:UITransitionContextFromViewControllerKey];
    
      UIView *ContainerView = [transitionContext containerView];
    
    
    //在前一个VC上创建一个截图
    UIView *snapShotView = [fromVC.HeadImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.backgroundColor = [UIColor clearColor];
    snapShotView.frame = [ContainerView convertRect:fromVC.HeadImageView.frame fromView:fromVC.HeadImageView.superview];
    fromVC.HeadImageView.hidden = YES;
    
    //初始化后一个VC中图片的位置
    CollectionViewCell *cell = (CollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.indexPath];
    cell.ImageView.hidden = YES;
    
    
    //顺序
    [ContainerView insertSubview:toVC.view belowSubview:fromVC.view];
    [ContainerView addSubview:snapShotView];
    
    //发生动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha = 0.0f;
        snapShotView.frame = toVC.finalCellRect;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.HeadImageView.hidden = NO;
        cell.ImageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
