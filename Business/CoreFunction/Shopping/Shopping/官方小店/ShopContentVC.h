//
//  ShopContentVC.h
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopContentVC : UIViewController

@property(nonatomic,strong)NSNumber *shStatus;//0:没有申请 1:审核中 2.审核通过 3.审核拒绝 4.被冻结
@property(nonatomic,copy)NSString *remake;

@end

NS_ASSUME_NONNULL_END
