//
//  BFDynamicHeaderView.h
//  klcProject
//
//  Created by ssssssssssss on 2020/7/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AppAdsModel.h>
#import <LibProjModel/AppVideoTopicModel.h>
 
NS_ASSUME_NONNULL_BEGIN

@class DynamicMainHeaderView;
@protocol DynamicMainHeaderViewDelegate <NSObject>
@optional

- (void)dynamicMainHeaderView:(DynamicMainHeaderView *)headerView changeHeaderHeight:(CGFloat)height;
- (void)dynamicMainHeaderView:(DynamicMainHeaderView *)headerView sliderClick:(AppAdsModel *)model selectedIndex:(NSInteger)index;
- (void)dynamicMainHeaderView:(DynamicMainHeaderView *)headerView topicClick:(AppVideoTopicModel *)model selectedIndex:(NSInteger)index;

@end

@interface DynamicMainHeaderView : UIView

@property (nonatomic, weak)id<DynamicMainHeaderViewDelegate> delegate;

- (void)loadShowData;

@end

NS_ASSUME_NONNULL_END
