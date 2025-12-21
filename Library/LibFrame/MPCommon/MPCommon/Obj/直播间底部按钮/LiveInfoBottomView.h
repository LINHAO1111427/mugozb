//
//  LiveInfoBottomView.h
//  LiveCommon
//
//  Created by admin on 2020/5/12.
//  Copyright © 2020 . All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface LiveFunctionItemModel : NSObject
///已10000为界限
///10000代表更多按钮
///10000一下的值直接处理，高于10000的值自己处理
@property (nonatomic, assign)NSInteger msgType;
///显示名称
@property (nonatomic, copy)NSString *name;
///功能图标
@property (nonatomic, copy)NSString *iconStr;
///标识图标名字
@property (nonatomic, copy)NSString *badgeStr;

@end



@interface LiveInfoBottomView : UIView


+ (CGRect)viewFrame;

///创建语音视图
- (void)showChatView:(UIView *)superView;


- (void)changeFunctionItems:(NSArray<LiveFunctionItemModel *> *)items;


- (void)clickFunction:(NSInteger)msgType;

@end

NS_ASSUME_NONNULL_END
