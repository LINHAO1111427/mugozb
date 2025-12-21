//
//  ApprovalStatusView.h
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApprovalStatusView : UIView

/// status 0:没有申请 1:审核中 2.审核通过 3.审核拒绝 4.被冻结
-(void)showContentStr:(NSString *)contentStr status:(int)status;


@end

NS_ASSUME_NONNULL_END
