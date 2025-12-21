//
//  ImConfig.h
//  IMSocket
//
//  Created by admin on 2019/6/5.
//  Copyright © 2019 admin. All rights reserved.
//
#ifndef ImConfig_h
#define ImConfig_h




@protocol ImConfig <NSObject>

@optional
-(int64_t)getImKey;//获取腾讯appID
-(void)getImUserSig:(void(^)(NSString *userSig))callBack;//获取签名文件
-(NSString*)getIp;
-(int)getPort;
-(int64_t)getUserID;
-(NSString*)getUserToken;
-(void) onTokenInvalid;

@end

#endif
