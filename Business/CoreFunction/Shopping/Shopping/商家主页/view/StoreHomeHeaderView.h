//
//  StoreHomeHeaderView.h
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopBusinessDTOModel;

NS_ASSUME_NONNULL_BEGIN

@interface StoreHomeHeaderView : UIView

@property (nonatomic, assign)CGFloat viewHeight;

@property (nonatomic, strong)ShopBusinessDTOModel *dtoModel;


@end

NS_ASSUME_NONNULL_END
