//
//  ShortVideoIdSaveObj.h
//  ShortVideo
//
//  Created by klc_sl on 2021/5/21.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShortVideoIdSaveObj : NSObject

@property (nonatomic, assign)int shortVideoId;
+ (void)ArchiveShortVideoWith:(int64_t)shortVideoId;
+ (ShortVideoIdSaveObj*)unArchiveShortVideoWith:(int64_t)shortVideoId;

@end

NS_ASSUME_NONNULL_END
