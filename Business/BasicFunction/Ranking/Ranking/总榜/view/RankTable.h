//
//  RankTable.h
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankTable : UITableView
@property (nonatomic, strong)CATextLayer *textLayer;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerHeight:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
