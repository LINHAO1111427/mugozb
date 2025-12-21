//
//  SystemNoticeView.h
//  LibProjView
//
//  Created by klc on 2020/5/16.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SystemNoticeCallback)(BOOL isShowDetail,NSString *url);
@interface SystemNoticeView : UIView

+ (void)showSystemNoticeCallBack:(SystemNoticeCallback)block;

@end

NS_ASSUME_NONNULL_END
