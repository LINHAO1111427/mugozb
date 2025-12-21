//
//  GoogsCategoryController.h
//  Shopping
//
//  Created by klc_sl on 2020/7/2.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoogsCategoryController : UIViewController

@property (nonatomic, copy)void(^selectCategory)(int64_t categoryId, NSString *categoryName);

@end

NS_ASSUME_NONNULL_END
