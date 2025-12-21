//
//  RefundReasonTable.h
//  Shopping
//
//  Created by yww on 2020/11/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApplyRefundReasonDTOModel;
@protocol RefundReasonTableDelegate <NSObject>
@optional
- (void)refundReasonTableDidSelected:(NSIndexPath *)selectedIndex withModel:(ApplyRefundReasonDTOModel *)model;

@end
@interface RefundReasonTable : UITableView
@property (nonatomic, weak)id<RefundReasonTableDelegate> resonDelegate;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, assign) NSIndexPath *selectIndex;
@end

NS_ASSUME_NONNULL_END
