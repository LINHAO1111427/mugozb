//
//  MyInviteIncomeRankCell.h
//  MineCenter
//
//  Created by klc on 2020/7/31.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class AppUserIncomeRankingDtoModel;
@interface MyInviteIncomeRankCell : UITableViewCell

@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)AppUserIncomeRankingDtoModel *model;


@end

NS_ASSUME_NONNULL_END
