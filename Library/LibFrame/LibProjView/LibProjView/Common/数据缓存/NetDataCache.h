//
//  NetDataCache.h
//  LibProjView
//
//  Created by admin on 2020/5/8.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetDataCache : NSObject


+ (void)downloadAll;


///缓存礼物图片
+ (void)downloadGiftImage;


///缓存用户等级图片
+ (void)downloadLevelIcon;


///缓存用户勋章图片
+ (void)downLoadMedalIcon;


@end

NS_ASSUME_NONNULL_END
