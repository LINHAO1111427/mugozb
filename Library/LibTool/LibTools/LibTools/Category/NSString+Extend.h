//
//  NSString+Extend.h
//  Pods
//
//  Created by shaolei on 17/4/1.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extend)


/** 去掉两端空格和换行符 */
- (NSString *)stringByTrimmingWhitespace;

    /** 隐藏手机号 */
- (NSString *)hiddenPhone;
    
    /** 隐藏身份证号 */
- (NSString *)hiddenCARDID;

/** 隐藏文字 */
- (NSString *)hiddenStringToRange:(NSRange)range;

    
    /**根据身份证获得生日*/
- (NSString *)birthdayStrFromIdentityCard;
   
/**
 *  根据身份证号获取性别
 */
- (NSString *)sexFromIdentityCard;
    
/**
 *  根据身份证号获取年龄
 */
- (NSString *)ageFromIdentityCard;


/// 字符串是否为空
- (BOOL)isEmpty;

///字符串是否有值
- (BOOL)hasValue;
    

///获取所有的emoji文字
- (NSArray <NSTextCheckingResult *> *)machesWithEmoji;


///是否是整型
- (BOOL)validPureInt;

///是否是长整型
- (BOOL)validPureLongLong;

///是否是浮点型
- (BOOL)validPureFloat;

///身份证号验证
- (BOOL)validateIDCardNumber;

///从网络下载图片
- (UIImage *) getImageFromURLStr;

///是否为密码是否包含数字或者密码
- (BOOL)valiPassWord;

///是否为中国的手机号
- (BOOL)valiMobile;

////将秒数成显示的时间
+ (NSString *)changeShowTimeForSecond:(int64_t)time;

///获取当前时间戳（毫秒）
+ (NSString *)getNowTimeTimestamp;

///json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

///加密
- (NSString *)aes256_encrypt;

///解密
- (NSString *)aes256_decrypt;

///加密
- (NSString *)md5Encrypt;


///评论数显示
+ (NSString *)stringForCompressNum:(NSInteger)number;


@end
