//
//  TotalUserRankCell.h
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TotalUserRankCell : UITableViewCell

@property (nonatomic, weak)UILabel *numL;

- (void)updateData:(int)index avater:(NSString *)avater username:(NSString *)username sex:(int)sex age:(int)age wealthLevel:(NSString *)wealthLevel nobleLevel:(NSString *)nobleLevel;



@end

NS_ASSUME_NONNULL_END
