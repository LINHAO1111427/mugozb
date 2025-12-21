//
//  RankSectionHeader.h
//  Ranking
//
//  Created by ssssssss on 2020/12/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankSectionHeader : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

///从0开始
@property (nonatomic, assign)int selectIndex;


@property (nonatomic, copy) void(^btnClickCallBack)(int index);


@end

NS_ASSUME_NONNULL_END
