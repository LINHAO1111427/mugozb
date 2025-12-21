//
//  SetGoodsPriceVC.h
//  Shopping
//
//  Created by klc_sl on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShopAttrComposeModel;
@interface SetGoodsPriceVC : UIViewController

@property (nonatomic, strong)NSArray<ShopAttrComposeModel *> *arr;
@property (nonatomic, copy)NSString *attribute1;
@property (nonatomic, copy)NSString *attribute2;
@end

NS_ASSUME_NONNULL_END
