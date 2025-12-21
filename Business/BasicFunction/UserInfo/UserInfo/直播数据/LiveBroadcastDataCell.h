//
//  LiveBroadcastDataCell.h
//  UserInfo
//
//  Created by klc on 2020/3/20.
//

#import <UIKit/UIKit.h>
@class AppUsersLiveDataVOModel;
NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString *const LiveBroadcastDataCellIdentifier;
@interface LiveBroadcastDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sortLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationTimeL;
@property (weak, nonatomic) IBOutlet UILabel *roomNumL;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;
@property (weak, nonatomic) IBOutlet UIView *lookNumView;
@property (weak, nonatomic) IBOutlet UILabel *lookNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *lookNumTitleL;
@property (weak, nonatomic) IBOutlet UIView *addFollowView;
@property (weak, nonatomic) IBOutlet UILabel *addFollowNumL;
@property (weak, nonatomic) IBOutlet UILabel *addFollowNumTitleL;
@property (weak, nonatomic) IBOutlet UIView *rewardNumView;
@property (weak, nonatomic) IBOutlet UILabel *rewardNumL;
@property (weak, nonatomic) IBOutlet UILabel *rewardNumTitleL;
@property (weak, nonatomic) IBOutlet UIView *addFansNumView;
@property (weak, nonatomic) IBOutlet UILabel *addFansNumL;
@property (weak, nonatomic) IBOutlet UILabel *addFansNumTitleL;
@property (weak, nonatomic) IBOutlet UIView *giveGiftView;
@property (weak, nonatomic) IBOutlet UILabel *giveGiftNumL;
@property (weak, nonatomic) IBOutlet UILabel *giveGiftNumTitleL;


@property (strong, nonatomic)AppUsersLiveDataVOModel *model;


@end

NS_ASSUME_NONNULL_END
