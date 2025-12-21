//
//  AlyCloudObj.h
//  XTStorageKit
//
//  Created by swh_y on 2022/5/27.
//  Copyright © 2022 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
 
@interface AlyCloudObj : NSObject
 
+ (void)alyunUploadImage:(NSData *)imageData filename:(NSString *)filename param:(NSDictionary *)param callBack:(nonnull void (^)(BOOL success, id result))callBack;


+ (void)alyunUploadFile:(NSString *)file filename:(NSString *)filename param:(NSDictionary *)param callBack:(nonnull void (^)(BOOL success, id result))callBack upProgress:(nonnull void (^)(CGFloat progress))progerssHander;
@end

NS_ASSUME_NONNULL_END
