//
//  EmptyView.h
//  TCDemo
//
//  Created by admin on 2019/10/22.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmptyView : UIView 

@property (nonatomic, weak)UIImageView *iconImgV;
/// default kLocalizationMsg(@" 暂无数据")
@property (nonatomic, weak)UILabel *titleL;
@property (nonatomic, weak)UILabel *detailL;

///默认hidden
- (void)showInView:(UIView *)superView;

- (void)showInView:(UIView *)superView andFrame:(CGRect)frame;

///点击视图
- (void)clickHandle:(void(^)(void))handle;


@end

NS_ASSUME_NONNULL_END
