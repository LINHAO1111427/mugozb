//
//  GoodDetailNaviView.h
//  LibProjView
//
//  Created by klc_sl on 2021/8/2.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodDetailNaviView : UIView

@property (nonatomic, weak)JXCategoryTitleView *titleView;

@property (nonatomic, weak)UIButton *backBtn;

@property (nonatomic, weak)UIButton *shoppingCartBtn;

@property (nonatomic, weak)UIButton *messageBtn;

///选择某一个分类
@property (nonatomic, copy)void(^didSelectItem)(NSInteger index);

///设置背景是否透明
@property (nonatomic, assign)CGFloat bgAlpha;
///设置购物车未读数
@property (nonatomic, assign)int shopCarNum;
///设置消息未读数
@property (nonatomic, assign)int messageNum;
///设置titleVIew选中第几个
@property (nonatomic, assign)NSInteger selectTitleViewIndex;

@end

NS_ASSUME_NONNULL_END
