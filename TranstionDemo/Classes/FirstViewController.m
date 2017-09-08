//
//  FirstViewController.m
//  TranstionDemo
//
//  Created by 刘凡 on 2017/3/20.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "FirstViewController.h"
#import "CollectionViewCell.h"
#import "SecondViewController.h"
#import "MagicMoveTransition.h"


@interface FirstViewController ()<UINavigationControllerDelegate>

@end

@implementation FirstViewController

static NSString * const reuseIdentifier = @"CollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate = self;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    SecondViewController *secondVC = segue.destinationViewController;
}


#pragma mark <uiNavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[SecondViewController class]]) {
        MagicMoveTransition *transition = [[MagicMoveTransition alloc]init];
        return transition;
    }else{
        return nil;
    }
    
    
}
#pragma mark <UICollectionViewDataSource>
//section的数目
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section Item的数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}


@end
