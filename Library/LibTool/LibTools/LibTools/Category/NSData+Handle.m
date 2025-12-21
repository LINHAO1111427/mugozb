//
//  NSData+Handle.m
//  TCDemo
//
//  Created by admin on 2019/9/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import "NSData+Handle.h"

@implementation NSData (Handle)

- (NSDictionary *)jsonValue{
    if (self == nil || self.length == 0) {
        return @{};
    }
    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:&error];
    return (error == nil)?jsonDic:@{};
}


- (NSString *)typeForImageData{
    uint8_t c;
    [self getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @".jpeg";
        case 0x89:
            return @".png";
        case 0x47:
            return @".gif";
        case 0x49:
        case 0x4D:
            return @".tiff";
    }
    return @".jpeg";
}


@end
