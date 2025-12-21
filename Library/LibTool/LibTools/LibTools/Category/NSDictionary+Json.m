//
//  NSDictionary+Json.m
//  iphoneLive
//
//  Created by gaogm on 2019/5/3.
//  Copyright © 2019 cat. All rights reserved.
//

#import "NSDictionary+Json.h"

@implementation NSDictionary (Json)

-(NSString*) getStr:(NSString*)strKey
{
    if(strKey==nil || strKey.length<1)
    {
        return @"";
    }
    id iValue= self[strKey];
    
    if(iValue==nil)
    {
        return @"";
    }
    
    if([iValue isKindOfClass:[NSString class]]==NO)
    {
        NSString *str=[NSString stringWithFormat:@"%@",iValue];
        return str;
    }
    
    return iValue;
}
-(int) getInt:(NSString*)strKey
{
    if(strKey==nil || strKey.length<1)
    {
        return 0;
    }
    id iValue= self[strKey];
    if(iValue==nil)
    {
        return 0;
    }
    @try
    {
        return [iValue intValue];
    }
    @catch(NSException *e)
    {
        return 0;
    }
}
-(NSDate*) getDate:(NSString*)strKey
{
    if(strKey==nil || strKey.length<1)
    {
        return [[NSDate alloc] initWithTimeIntervalSince1970:0];
    }
    id iValue= self[strKey];
    if(iValue==nil)
    {
        return [[NSDate alloc] initWithTimeIntervalSince1970:0];
    }
    @try
    {
        return [iValue date];
    }
    @catch(NSException *e)
    {
        return [[NSDate alloc] initWithTimeIntervalSince1970:0];
    }
}
-(int64_t) getInt64:(NSString*)strKey
{
    if(strKey==nil || strKey.length<1)
    {
        return 0;
    }
    id iValue= self[strKey];
    if(iValue==nil)
    {
        return 0;
    }
    @try
    {
        return [iValue longLongValue];
    }
    @catch(NSException *e)
    {
        return 0;
    }
}
-(double) getDouble:(NSString*)strKey{
    if(strKey==nil || strKey.length<1)
    {
        return 0;
    }
    id iValue= self[strKey];
    if(iValue==nil)
    {
        return 0;
    }
    @try
    {
        return [iValue doubleValue];
    }
    @catch(NSException *e)
    {
        return 0;
    }
}

-(NSArray*) getNSArray:(NSString*)strKey
{
    if(strKey==nil || strKey.length<1)
    {
        return nil;
    }
    id iValue= self[strKey];
    if(iValue==nil)
    {
        return nil;
    }
    @try
    {
        NSArray *arr=iValue;
        return arr;
    }
    @catch(NSException *e)
    {
        return nil;
    }
}

-(NSDecimalNumber*) getDecimalNumber:(NSString*)strKey
{
    if(strKey==nil || strKey.length<1)
    {
        
        return   [NSDecimalNumber zero];
        
    }
    id iValue= self[strKey];
    if(iValue==nil)
    {
        return  [NSDecimalNumber zero];
    }
    @try
    {
        NSString* str=[NSString stringWithFormat:@"%@",iValue,nil];
        return  [NSDecimalNumber decimalNumberWithString:str];
        
    }
    @catch(NSException *e)
    {
        return  [NSDecimalNumber zero];
    }
}


- (NSString *)convertToJsonData{
    if (self.count == 0) {
        return @"";
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
       // NSLog(@"过滤文字dictionary转换string错误:%@"),error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}


@end

