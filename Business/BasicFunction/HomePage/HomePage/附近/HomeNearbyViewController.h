//
//  HomeNearbyViewController.h
//  HomePage
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryListContainerView.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeNearbyViewController : UIViewController<JXCategoryListContentViewDelegate>

@property(nonatomic,copy)NSString *address;
/// 刷新列表
/// @param isRefresh 是否刷新
/// @param type 类型
- (void)loadData:(BOOL)isRefresh;


@end

NS_ASSUME_NONNULL_END
