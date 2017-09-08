//
//  MagicMoveTransition.m
//  TranstionDemo
//
//  Created by 刘凡 on 2017/3/22.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CollectionViewCell.h"

@implementation MagicMoveTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    

    
    FirstViewController *fromVC = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC   = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    
    //对Cell上的 imageView 截图，同时将这个 imageView 本身隐藏
    CollectionViewCell *cell =(CollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems] firstObject]];
    fromVC.indexPath = [[fromVC.collectionView indexPathsForSelectedItems]firstObject];
    
    UIView * snapShotView = [cell.ImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.ImageView.frame fromView:cell.ImageView.superview];
    cell.ImageView.hidden = YES;
    
    
    //设置第二个控制器的位置、透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.HeadImageView.hidden = YES;
    
    //把动画前后的两个ViewController加到容器中,顺序很重要,snapShotView在上方
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    //动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.HeadImageView.frame fromView:toVC.HeadImageView.superview];
        
    } completion:^(BOOL finished) {
        //为了让回来的时候，cell上的图片显示，必须要让cell上的图片显示出来
        toVC.HeadImageView.hidden = NO;
        cell.ImageView.hidden = NO;
        [snapShotView removeFromSuperview];
        //告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
