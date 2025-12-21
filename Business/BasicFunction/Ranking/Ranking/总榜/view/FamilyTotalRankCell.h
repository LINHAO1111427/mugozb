//
//  FamilyTotalRankCell.h
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FamilyTotalRankCell : UITableViewCell

@property (nonatomic, strong)UIImageView *levelImgV;

- (void)updateData:(int)index avater:(NSString *)avater username:(NSString *)username num:(CGFloat)num introduce:(NSString *)introduce;

@end

NS_ASSUME_NONNULL_END
