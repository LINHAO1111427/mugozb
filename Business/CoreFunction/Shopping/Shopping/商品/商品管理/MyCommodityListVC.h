//
//  MyCommodityListVC.h
//  Shopping
//
//  Created by klc on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCommodityListVC : UIViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, assign)MyCommodityStatus status;
@end

NS_ASSUME_NONNULL_END
