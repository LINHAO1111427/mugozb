//
//  TiUIMeiZhuangView.h
//  TiFancy
//
//  Created by MBP DA1003 on 2019/8/1.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIMenuPlistManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface TiUIMeiZhuangView : UIView

@property(nonatomic,copy)void(^clickOnCellBlock)(NSInteger index);

@property(nonatomic,copy)void(^makeupShowDisappearBlock)(BOOL Hidden);

@property(nonatomic,strong) TIMenuMode *mode;

-(void)setHiddenAnimation:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
