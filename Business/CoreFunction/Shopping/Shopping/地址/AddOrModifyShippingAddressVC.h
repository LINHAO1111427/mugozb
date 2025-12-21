//
//  AddShippingAddressVC.h
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ShopAddressModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface AddOrModifyShippingAddressVC : UIViewController
@property (nonatomic, strong)NSNumber *isModify;
@property (nonatomic, strong)ShopAddressModel *modifyAddressModel;//地址传值
@end

NS_ASSUME_NONNULL_END
