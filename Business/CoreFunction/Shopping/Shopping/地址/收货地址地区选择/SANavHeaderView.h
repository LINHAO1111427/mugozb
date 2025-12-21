//
//  SANavHeaderView.h
//  LibProjView
//
//  Created by klc on 2020/7/21.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SANavHeaderView,SASelctedModel;
@protocol SANavHeaderViewDelegate <NSObject>
@optional
- (void)SANavHeaderView:(SANavHeaderView*)headerView didSelectedAt:(NSInteger)index;

@end
@interface SANavHeaderView : UIView
@property (nonatomic, weak)id<SANavHeaderViewDelegate> delegate;
- (void)updateDataWith:(SASelctedModel *)model selectedIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
