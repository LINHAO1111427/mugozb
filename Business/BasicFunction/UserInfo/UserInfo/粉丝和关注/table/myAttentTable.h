//
//  myAttentTable.h
//  Fans
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myAttentTable : UITableView<JXCategoryListContentViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame type:(int)type;
@property (nonatomic, weak)UIViewController *superVc;
@end

NS_ASSUME_NONNULL_END
