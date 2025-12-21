//
//  beGuardVc.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface guardListVc : UIViewController<JXCategoryListContentViewDelegate>
- (instancetype)initWithType:(int)type userId:(int64_t)user_id;
@end

NS_ASSUME_NONNULL_END
