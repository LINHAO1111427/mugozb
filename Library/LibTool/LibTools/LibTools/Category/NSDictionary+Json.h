//
//  NSDictionary+Json.h
//  iphoneLive
//
//  Created by gaogm on 2019/5/3.
//  Copyright © 2019 cat. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Json)

-(NSString*) getStr:(NSString*)strKey;
-(int) getInt:(NSString*)strKey;
-(double) getDouble:(NSString*)strKey;
-(NSDate*) getDate:(NSString*)strKey;
-(int64_t) getInt64:(NSString*)strKey;
-(NSDecimalNumber*) getDecimalNumber:(NSString*)strKey;

-(NSArray*) getArray:(NSString*)strKey cls:(Class)cls;


-(NSString *)convertToJsonData;

@end


NS_ASSUME_NONNULL_END
