//
//  FirstViewController.h
//  TranstionDemo
//
//  Created by 刘凡 on 2017/3/20.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionViewCell;
@interface FirstViewController : UICollectionViewController

@property(nonatomic, strong) NSIndexPath *indexPath;

@property(nonatomic, assign) CGRect finalCellRect;

@end
