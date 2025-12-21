//
//  LibToolsRes.m
//  Login
//
//  Created by 高光明 on 2020/4/1.
//

#import "LibToolsRes.h"

@implementation LibToolsRes
+ (NSString*)getNibFullName:(NSString *)NibName
{
    return [NSString stringWithFormat:@"LibToolsB.bundle/%@",NibName,nil];
}
@end
