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

-(NSDictionary*) getNSDictionary:(NSString*)strKey
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
        NSDictionary *arr=iValue;
        return arr;
    }
    @catch(NSException *e)
    {
        return nil;
    }
}


/*
 -(NSArray*) getArray:(NSString*)strKey cls:(Class)cls
 {
 NSArray*arr=  [self getNSArray:strKey];
 if(arr==nil)
 {
 return nil;
 }
 NSMutableArray* retArr=[NSMutableArray new];
 for(int i=0;i<[arr count];i++)
 {
 NSObject* obj=[cls new];
 if( [obj yy_modelSetWithJSON:arr[i]])
 {
 [retArr addObject:obj];
 }
 }
 
 return retArr;
 
 }
 */
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

-(NSString*) toStr
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:0];
    NSString *dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return dataStr;
}

+ (NSDictionary *)dictionaryForJsonData:(NSData *)jsonData{
    if (![jsonData isKindOfClass:[NSData class]] || jsonData.length < 1) {
        return nil;
    }
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    if (![jsonObj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [NSDictionary dictionaryWithDictionary:(NSDictionary *)jsonObj];
}

@end

