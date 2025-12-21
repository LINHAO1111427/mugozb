//
//  MyChannelView.h
//  Shopping
//
//  Created by kalacheng on 2020/6/29.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyChannelView : UIView

@property (nonatomic, assign)int64_t channelId;
@property (nonatomic, assign) int64_t goodsId;  ///商品属性id
@property (nonatomic, strong)ShopGoodsDTOModel *model;
@property (nonatomic, assign)BOOL isModify;
@property (nonatomic, copy)void (^addGoodsSuccess)(void);

- (void)priceIsHidden:(BOOL)hidden attrStr:(NSString *)str;//价格的隐藏与否


- (void)keyboardNotification:(BOOL)isAdd;


@end
 
NS_ASSUME_NONNULL_END
