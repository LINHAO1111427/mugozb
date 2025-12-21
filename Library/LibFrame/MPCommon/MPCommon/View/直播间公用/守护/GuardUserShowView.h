//
//  GuardUserShowView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/21.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GuardUserVOModel;
@interface GuardUserShowView : UIView

- (void)showGuardUser:(NSArray<GuardUserVOModel *> *)arr;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
