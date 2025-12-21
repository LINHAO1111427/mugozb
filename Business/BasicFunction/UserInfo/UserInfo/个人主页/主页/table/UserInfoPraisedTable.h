//
//  UserInfoPraisedTable.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagingView/JXPagerView.h>
NS_ASSUME_NONNULL_BEGIN

@class ApiUserInfoModel;
@interface UserInfoPraisedTable : UIViewController<JXPagerViewListViewDelegate>
@property(nonatomic,strong)ApiUserInfoModel *userModel;
@end

NS_ASSUME_NONNULL_END
