//
//  TiUISubMenuOneViewCell.h
//  XTSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIMenuPlistManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiUIMenuOneViewCell : UICollectionViewCell

@property(nonatomic,strong) TIMenuMode *mode;
 
@property(nonatomic,copy)void(^clickOnCellBlock)(NSInteger index);

@property(nonatomic,copy)void(^makeupShowDisappearBlock)(BOOL Hidden);


@property(nonatomic,assign) BOOL isMakeupShow;

@end

NS_ASSUME_NONNULL_END
