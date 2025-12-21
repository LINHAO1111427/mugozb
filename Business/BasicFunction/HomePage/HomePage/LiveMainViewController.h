//
//  LiveMainViewController.h
//  TCDemo
//
//  Created by klc_tqd on 2019/8/26.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <LibProjView/HomeBaseViewController.h>
NS_ASSUME_NONNULL_BEGIN

@interface LiveMainViewController : HomeBaseViewController
//类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频
@property(nonatomic,strong)NSArray* typeArr;//类型
@property(nonatomic,assign)int64_t  homeDefaultSelectedIndex;

@end

NS_ASSUME_NONNULL_END
 
