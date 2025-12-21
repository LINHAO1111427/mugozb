//
//  OtherChannelView.h
//  Shopping
//
//  Created by kalacheng on 2020/6/29.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface OtherChannelView : UIView


@property (nonatomic, assign)int64_t channelId;

@property (nonatomic, copy)void (^addGoodsSuccess)(void);
@property (nonatomic, assign)BOOL isModify;
@property (nonatomic, strong)ShopGoodsDTOModel *model;
@end

NS_ASSUME_NONNULL_END
