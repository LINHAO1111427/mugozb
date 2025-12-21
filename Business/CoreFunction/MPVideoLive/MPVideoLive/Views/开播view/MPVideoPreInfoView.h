//
//  MPVideoPreInfoView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/7/7.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPVideoPreInfoView : UIView


@property (nonatomic, assign)int64_t roomChannelID;  ///房间频道
@property (nonatomic, assign)int roomTypeID; ///房间类型
@property (nonatomic, copy)NSString *roomTypeVal; ///房间类型的值


///统一数据
@property (weak, nonatomic) UIButton *userLiveCover;  ///用户直播封面
@property (weak, nonatomic) UILabel *cityL;  ///城市定位
@property (weak, nonatomic) UITextView *textV;  //标题输入框
@property (weak, nonatomic) UILabel *selectChannel;  ///选择的频道
@property (weak, nonatomic) UILabel *wishL;     ///心愿单文字
@property (weak, nonatomic) UILabel *roomType; ///房间模式

/// 1:定位。 2:添加封面
- (void)clickActionBlock:(void(^)(int type))actionBlock;

- (void)shoppingBtnSelectedBlock:(void(^)(BOOL selected))actionBlock;
@end

NS_ASSUME_NONNULL_END
