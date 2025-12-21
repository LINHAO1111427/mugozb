//
//  ChangeBgImageVC.h
//  LiveCommon
//
//  Created by klc on 2020/5/23.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveManager.h>

NS_ASSUME_NONNULL_BEGIN


@interface ChangeBgImageVC : UIViewController


- (void)selectLiveBgThumb:(int)type resultBlock:(void(^)(int64_t imageId, NSString *imageURL))block;

@end

NS_ASSUME_NONNULL_END
