//
//  TIDownloadZipManager.h
//  XTSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIConfig.h"

@interface TIDownloadZipManager : NSObject

typedef NS_ENUM(NSInteger, DownloadedType) {
    TI_DOWNLOAD_TYPE_Sticker = 2, //贴纸
    TI_DOWNLOAD_STATE_Gift = 3, // 礼物
    TI_DOWNLOAD_STATE_Watermark = 7,//水印
    TI_DOWNLOAD_STATE_Mask = 8,//面具
    TI_DOWNLOAD_STATE_Lvmu = 9,//绿幕
    TI_DOWNLOAD_STATE_Interactions = 11,//互动贴纸
    TI_DOWNLOAD_STATE_Makeup = 12,//美妆
    TI_DOWNLOAD_STATE_Makeup_blusher = 1201,//美妆 腮红
    TI_DOWNLOAD_STATE_Makeup_eyelash = 1202,//美妆 睫毛
    TI_DOWNLOAD_STATE_Makeup_eyebrow = 1203,//美妆 眉毛
    
};
 


// MARK: --单例初始化方法--
+ (TIDownloadZipManager *)shareManager;
+(void)releaseShareManager;

- (void)downloadSuccessedType:(DownloadedType)type MenuMode:(TIMenuMode *)mode completeBlock:(void(^)(BOOL successful))completeBlock;
@end
 
