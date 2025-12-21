//
//  LookeMeTableViewCell.h
//  Fans
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApiUserAttenModel;
NS_ASSUME_NONNULL_BEGIN
@protocol LookeMeTableViewCellDelegate <NSObject>
@optional
- (void)LookeMeTableViewCellDealBtnClick:(BOOL)isAttent indexPath:(NSIndexPath *)indexPath;

@end
@interface LookeMeTableViewCell : UITableViewCell
@property(nonatomic,strong)ApiUserAttenModel *model;
- (instancetype)initWithFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath;
@property(nonatomic,weak)id<LookeMeTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
