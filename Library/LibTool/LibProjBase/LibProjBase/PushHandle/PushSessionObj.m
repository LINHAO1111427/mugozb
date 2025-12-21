//
//  PushSessionObj.m
//  PushKit
//
//  Created by shao on 2019/9/9.
//  Copyright © 2019 klc. All rights reserved.
//

#import "PushSessionObj.h"
#import "HttpClient.h"

@implementation PushSessionObj


+ (void)requestSession:(NSString *)url param:(NSDictionary *)param complete:(nonnull void (^)(BOOL, id _Nullable))complete{
    
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    [muDic addEntriesFromDictionary:param];
    [muDic setObject:@([HttpClient getUid]) forKey:@"_uid_"];
    [muDic setObject:[HttpClient getToken] forKey:@"_token_"];
    [muDic setObject:[HttpClient getOSType] forKey:@"_OS_"];
    [muDic setObject:[HttpClient getOSVersion] forKey:@"_OSV_"];
    [muDic setObject:[HttpClient getOSInfo] forKey:@"_OSInfo_"];
    
    [HttpClient requestPostWithPath:url param:muDic success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet[@"code"] intValue];
        complete((code==1)?YES:NO,dicRet[@"retObj"]);
    } failed:^(int code,NSString *error) {
        complete(code,nil);
    }];
}


@end
