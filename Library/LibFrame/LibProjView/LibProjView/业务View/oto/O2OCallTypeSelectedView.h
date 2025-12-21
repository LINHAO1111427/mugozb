//
//  O2OCallTypeSelectedView.h
//  LibProjView
//
//  Created by ssssssss on 2020/9/7.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class O2OCallTypeSelectedView;
@interface O2OCallTypeParam : NSObject

///通话人姓名
@property (nonatomic, copy)NSString *username;
///语音通话金额
@property (nonatomic, assign)double voiceCoin;
///视频通话金额
@property (nonatomic, assign)double videoCoin;
///通话对象的角色
@property (nonatomic, assign)int callUserRole;

@end

typedef void (^O2OCallTypeCallback)(NSInteger type,O2OCallTypeSelectedView *callView);
@interface O2OCallTypeSelectedView : UIView
+ (void)showCallTypeViewWith:(O2OCallTypeParam *)param callBack:(O2OCallTypeCallback)callBack;
@end

NS_ASSUME_NONNULL_END
