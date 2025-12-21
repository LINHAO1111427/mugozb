//
//  MagicBoxView.h
//  klcProject
//
//  Created by klc_sl on 2020/7/21.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MagicBoxView : UIView


#pragma mark - 嵌入样式 -
///加载数据
- (void)loadShowData;

///退出游戏
- (void)stopGame;


#pragma mark - 弹窗样式 -
+ (void)showMagicBox:(int64_t)uid;


@end

NS_ASSUME_NONNULL_END
