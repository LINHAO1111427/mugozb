//
//  VertifyVideoPlayerView.h
//  MineCenter
//
//  Created by ssssssss on 2020/1/6.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
 
typedef void(^RecordPlayerViewConfirmBlock)(void);
typedef void(^RecordPlayerViewRemakeBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface VertifyVideoPlayerView : UIView
@property (nonatomic, copy) RecordPlayerViewConfirmBlock confirmBlock;
@property (nonatomic, copy) RecordPlayerViewRemakeBlock remakeBlock;
@property (nonatomic, strong) NSURL *playUrl;
@end

NS_ASSUME_NONNULL_END
