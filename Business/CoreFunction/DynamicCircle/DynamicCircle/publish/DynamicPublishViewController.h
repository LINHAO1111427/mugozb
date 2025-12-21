//
//  DynamicPublishViewController.h
//  DynamicCircle
//
//  Created by ssssssss on 2020/8/1.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicPublishViewController : UIViewController

//图片数组
@property (nonatomic, copy)NSArray *imgArr;

///视频
@property (nonatomic, copy)NSURL *videoUrl; //视频地址
@property (nonatomic, copy)NSNumber *videoDuration; //时长
@property (nonatomic, copy)UIImage *previewImg; //预览图
@end

NS_ASSUME_NONNULL_END
