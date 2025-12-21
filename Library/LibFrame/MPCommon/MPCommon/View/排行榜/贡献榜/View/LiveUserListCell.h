//
//  LiveUserListCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUserBasicInfoModel;
@class RanksDtoModel;

@interface LiveUserListCell : UITableViewCell

@property (weak, nonatomic) UILabel *numberL;  ///排位


@property (nonatomic, strong)RanksDtoModel *ranksModel;

@property (nonatomic, strong)ApiUserBasicInfoModel *userModel;

@end

NS_ASSUME_NONNULL_END
