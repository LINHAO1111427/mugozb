//
//  MKJCollectionViewFlowLayout.h
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KlcCollectionViewFlowLayoutDelegate <NSObject>

- (void)collectioViewScrollToIndex:(NSInteger)index;

@end

@interface KlcCardCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) id<KlcCollectionViewFlowLayoutDelegate>delegate;

@property (nonatomic,assign) BOOL needAlpha;

@end
