//
//  LibProjViewRes.m
//  LibProjView
//
//  Created by klc_sl on 2020/4/17.
//  Copyright © 2020 . All rights reserved.
//

#import "LibProjViewRes.h"

@implementation LibProjViewRes

+ (NSString*)getNibFullName:(NSString *)NibName
{
    return [NSString stringWithFormat:@"LibProjViewB.bundle/%@",NibName,nil];
}

@end
