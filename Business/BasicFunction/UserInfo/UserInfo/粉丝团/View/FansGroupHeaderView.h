//
//  FansGroupHeaderView.h
//  Fans
//
//  Created by klc on 2020/3/18.
//

#import <UIKit/UIKit.h>
@class FansInfoDtoModel;
NS_ASSUME_NONNULL_BEGIN
@protocol FansGroupHeaderViewDelegate <NSObject>

@optional
- (void)setFansGroupNameClick:(NSString *)nameStr;
- (void)setFansGroupCoinClick:(NSString *)CoinStr;
- (void)setFansGroupIconClick;

@end

@interface FansGroupHeaderView : UIView

@property (nonatomic,strong)FansInfoDtoModel *fansInfoModel;

@property (nonatomic,weak)id<FansGroupHeaderViewDelegate> delegate;

@property (nonatomic,strong)UILabel *rankTitleLable;

@property (nonatomic,strong)UIImageView *userIconV; ///用户头像

@end

NS_ASSUME_NONNULL_END
