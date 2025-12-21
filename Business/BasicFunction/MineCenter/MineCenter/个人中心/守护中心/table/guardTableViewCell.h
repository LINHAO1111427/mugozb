//
//  guardTableViewCell.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GuardUserVOModel;
@protocol guardTableViewCellDelegate <NSObject>
@optional
- (void)guardTableViewCellRenewBtnClickWith:(GuardUserVOModel *)model;
@end

@interface guardTableViewCell : UITableViewCell
@property (nonatomic, assign)int type;//0守护别人 1被人守护 
@property (nonatomic, strong)GuardUserVOModel *guardModel;
@property (nonatomic, weak)id<guardTableViewCellDelegate> deleagte;
@end

NS_ASSUME_NONNULL_END
