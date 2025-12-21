//
//  LoginRes.m
//  Login
//
//  Created by 高光明 on 2020/4/1.
//

#import "LoginRes.h"

@implementation LoginRes
+ (NSString*)getNibFullName:(NSString *)NibName
{
    //return [NSString stringWithFormat:@"Frameworks/Login.framework/%@",NibName,nil];
    return [NSString stringWithFormat:@"LoginB.bundle/%@",NibName,nil];
}
@end
