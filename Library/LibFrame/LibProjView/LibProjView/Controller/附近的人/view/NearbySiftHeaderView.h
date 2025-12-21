//
//  O2ONearbyHeaderView.h
//  LibProjView
//
//  Created by ssssssss on 2020/9/7.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface NearbyHeaderSelectedBtn : UIButton

@property (nonatomic, assign)BOOL isShow; ///是否选中状态

@end


@class NearbySiftHeaderView;
@protocol NearbySiftHeaderViewDelegate <NSObject>
@optional
- (void)NearbySiftHeaderViewGenderSelected:(NearbySiftHeaderView *)headerV selectedGender:(int )gender;
- (void)NearbySiftHeaderViewCitySelected:(NearbySiftHeaderView *)headerV;
@end

@interface NearbySiftHeaderView : UIView
@property (nonatomic, weak)UIViewController *superVc;
@property (nonatomic, assign)BOOL locationAlways;
@property (nonatomic, weak)id<NearbySiftHeaderViewDelegate> delegate;
- (void)reloadShowTitleWith:(NSString *)city gender:(int)gender;


@end

NS_ASSUME_NONNULL_END
