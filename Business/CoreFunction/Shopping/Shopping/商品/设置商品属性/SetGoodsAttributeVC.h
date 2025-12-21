//
//  SetGoodsAttributeVC.h
//  Shopping
//
//  Created by klc_sl on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetGoodsAttributeVC : UIViewController
@property (nonatomic, assign)BOOL isModify;
@property (nonatomic, assign)int64_t goodsId;  ///商品ID
@end

NS_ASSUME_NONNULL_END
