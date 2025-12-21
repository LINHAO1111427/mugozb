//
//  Dynamic08ClassfiyListVc.h
//  klcLive
//
//  Created by SWH05 on 2022/2/14.
//  Copyright © 2022 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>
#import <JXPagingView/JXPagerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dynamic02ClassfiyListVc : UIViewController<JXPagerViewListViewDelegate,JXCategoryListContentViewDelegate>
///0:全部 1:推荐 2:关注 3.我喜欢的
@property (nonatomic, assign)int type;

@property (nonatomic, assign)int64_t userId; ///某一个用户的ID

///给父视图会掉，告诉父视图要跳转到页面，不刷新
@property (nonatomic, copy)void (^pushNextPageBlock)(void);
@end

NS_ASSUME_NONNULL_END
