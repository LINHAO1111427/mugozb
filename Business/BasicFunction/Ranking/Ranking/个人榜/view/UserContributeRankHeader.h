//
//  UserContributeRankHeader.h
//  Ranking
//
//  Created by ssssssss on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol UserContributeRankHeaderDelegate <NSObject>
@optional
- (void)UserContributeRankHeaderBtnClickWith:(NSInteger)index;

@end
@interface UserContributeRankHeader : UIView
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, weak)id<UserContributeRankHeaderDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
