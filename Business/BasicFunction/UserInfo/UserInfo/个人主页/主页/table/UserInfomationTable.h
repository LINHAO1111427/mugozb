//
//  UserInfomationTable.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagingView/JXPagerView.h>
NS_ASSUME_NONNULL_BEGIN

@class ApiUserInfoModel;
@interface UserInfomationTable : UIViewController<JXPagerViewListViewDelegate>

@property (nonatomic, copy)void(^dynamicBtnClick)(void);

- (instancetype)initWithUserId:(int64_t)userId;

@end

NS_ASSUME_NONNULL_END
