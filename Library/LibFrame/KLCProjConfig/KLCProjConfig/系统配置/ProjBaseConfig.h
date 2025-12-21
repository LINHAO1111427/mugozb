//
//  ProjBaseConfig.h
//  emo
//
//  Created by admin on 2019/12/11.
//  Copyright © 2019 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LibProjBase/ProjConfigInterface.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProjBaseConfig : NSObject<ProjConfigInterface>


///链接socket
+ (void)connectSocketSuccessBlock:(void(^)(void))addAllMonitorBlock;

@end

NS_ASSUME_NONNULL_END
