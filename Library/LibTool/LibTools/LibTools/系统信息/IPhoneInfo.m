//
//  IPhoneInfo.m
//  TCDemo
//
//  Created by admin on 2019/11/16.
//  Copyright © 2019 CH. All rights reserved.
//

#import "IPhoneInfo.h"
#import <sys/utsname.h>
#import "KeyChainManager.h"
#import <UIKit/UIKit.h>
#import <ifaddrs.h>
#import <sys/socket.h>
#import <arpa/inet.h>

@implementation IPhoneInfo


+ (NSString *)appVersionNO{
    return  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appVersionBuild{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)appBundleIdentifier{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)phoneType{
    return [IPhoneInfo currentPhoneType];
}

+ (NSString *)systemVersion{
    return [[UIDevice currentDevice] systemVersion];
}


+ (NSString*)currentPhoneType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"VerizoniPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone8Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone8Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhoneX";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhoneX";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhoneXR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhoneXS";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhoneXSMax";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhoneXSMax";
    if ([deviceString isEqualToString:@"iPhone12,1"])   return @"iPhone11";
    if ([deviceString isEqualToString:@"iPhone12,3"])   return @"iPhone11Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])   return @"iPhone11ProMax";
    
    return deviceString;
}

+ (NSString *)phoneUUID{
    
    NSString *UUIDString = @"";
    NSString *KEY_UUID_DATA = [[NSBundle mainBundle] bundleIdentifier];
    NSString *KEY_UUID_TEXT = @"UUID_TEXT";
    NSDictionary *UUID_Dict = (NSDictionary *)[KeyChainManager load:KEY_UUID_DATA];
    if ([UUID_Dict.allKeys containsObject:KEY_UUID_TEXT]) {
        UUIDString = UUID_Dict[KEY_UUID_TEXT];
    }else {
        //没有就获取
        UUIDString = [UIDevice currentDevice].identifierForVendor.UUIDString;
        //保存
        [KeyChainManager save:KEY_UUID_DATA data:@{KEY_UUID_TEXT:UUIDString}];
    }
   // NSLog(@"过滤文字手机：UUID:%@"),UUIDString);
    return UUIDString;
}


+ (NSString *)ipAddress{
    
    NSString *address = @"error";
    
    struct ifaddrs *interfaces = NULL;
    
    struct ifaddrs *temp_addr = NULL;
    
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        
        // Loop through linked list of interfaces
        
        temp_addr = interfaces;
        
        while(temp_addr != NULL) {
            
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                
                // Check if interface is en0 which is the wifi connection on the iPhone
                
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    // Get NSString from C String
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
            
        }
        
    }
    
    freeifaddrs(interfaces);
    
    return address;
}


@end
