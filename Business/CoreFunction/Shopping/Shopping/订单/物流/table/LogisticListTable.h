//
//  LogisticListTable.h
//  Shopping
//
//  Created by yww on 2020/8/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApiShopLogisticsDTOModel;
NS_ASSUME_NONNULL_BEGIN

@interface LogisticListTable : UITableView<JXCategoryListContentViewDelegate>
@property (nonatomic, strong)ApiShopLogisticsDTOModel *logisticsModel;
@property (nonatomic, assign)int index;
@end

NS_ASSUME_NONNULL_END
