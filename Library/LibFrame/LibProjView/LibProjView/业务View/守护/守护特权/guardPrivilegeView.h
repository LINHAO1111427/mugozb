//
//  guardPrivilegeView.h
//  LibProjView
//
//  Created by ssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface guardPrivilegeView : UIScrollView 
- (instancetype)initWithFrame:(CGRect)frame from:(BOOL)fromUserInfo contentY:(CGFloat)contentY;
@end

NS_ASSUME_NONNULL_END
