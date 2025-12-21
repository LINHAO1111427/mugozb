//
//  LiveCommonRes.m
//  Login
//
//  Created by 高光明 on 2020/4/1.
//

#import "LiveCommonRes.h"

@implementation LiveCommonRes

+ (NSString*)getNibFullName:(NSString *)NibName
{
    return [NSString stringWithFormat:@"LiveCommonB.bundle/%@",NibName,nil];
}


@end
