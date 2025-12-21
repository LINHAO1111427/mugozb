//
//  OrderFormCrustVC.h
//  Shopping
//
//  Created by yww on 2020/8/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface OrderFormCrustVC : UIViewController

@property (nonatomic, assign)int64_t shop_id;
@property (nonatomic, assign)int selectedStatus;
@property (nonatomic, assign)int type;
@property (nonatomic, copy)NSString *navTitle;

@end

NS_ASSUME_NONNULL_END
