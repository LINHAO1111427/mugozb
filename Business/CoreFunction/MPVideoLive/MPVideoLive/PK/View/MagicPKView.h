//
//  MagicPKView.h
//  MPVideoLive
//
//  Created by admin on 2019/7/30.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MagicPKView : UIView


/**
 初始化

 @param superV PK的视图
 @param dic socket返回数据
 */
- (instancetype)initWithSuperView:(UIView *)superV dic:(NSDictionary *)dic anchorId:(NSString *)anchorId;

@property (nonatomic, strong)NSString *pkTime;

@property (nonatomic, strong) void(^resultFinish)(void);

/**
 取消pk
 计时器清零
 */
- (void)resetPkView;

/**
 更新显示数据的
 
 @param dic pk结果数据
 */
- (void)updateShowData:(NSDictionary *)dic;

/**
  显示pk结果

 @param dic pk结果数据
 */
- (void)showPkResult:(NSDictionary *)dic;



@end

NS_ASSUME_NONNULL_END
