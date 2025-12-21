//
//  UserInfoRes.m
//  Login
//
//  Created by 高光明 on 2020/4/1.
//

#import "UserInfoRes.h"

@implementation UserInfoRes
+ (NSString*)getNibFullName:(NSString *)NibName
{
    return [NSString stringWithFormat:@"UserInfoB.bundle/%@",NibName,nil];
}
@end
