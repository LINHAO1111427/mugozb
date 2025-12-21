//
//  NSString+Extend.m
//  Pods
//
//  Created by shaolei on 17/4/1.
//
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

#define aesPwd  @"klczfb"
#define kLocalizationMsg(key) NSLocalizedString(key, nil)

@implementation NSString (Extend)


- (NSString *)stringByTrimmingWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/** 隐藏手机号 */
-(NSString *)hiddenPhone{
    if (self.length >=8) {
        NSString *string = [self substringWithRange:NSMakeRange(3, 5)];
        NSString *str = [self stringByReplacingOccurrencesOfString:string withString:@"*****"];
        return str;
        
    }
    return self;
}

/** 隐藏身份证号 */
-(NSString *)hiddenCARDID{
    if (self.length >=12) {
        NSString *string = [self substringWithRange:NSMakeRange(3, 9)];
        NSString *str = [self stringByReplacingOccurrencesOfString:string withString:@"*********"];
        return str;
    }
    return self;
}

- (NSString *)hiddenStringToRange:(NSRange)range{
    if (self.length > 0 && range.length > 0 && (self.length >=range.location+range.length)) {

        NSUInteger i = range.length;
        NSString *startStr = @"";
        while (i>0) {
            --i;
            startStr = [startStr stringByAppendingString:@"*"];
        }
        NSString *str = [self stringByReplacingCharactersInRange:range withString:startStr];
        return str;
    }
    return self;
}


/**根据身份证获得生日*/
-(NSString *)birthdayStrFromIdentityCard{
    NSMutableString *birth = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([self length]<14)
        return birth;
    
    //**截取前14位
    NSString *fontNumer = [self substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return birth;
    
    year = [self substringWithRange:NSMakeRange(6, 4)];
    month = [self substringWithRange:NSMakeRange(10, 2)];
    day = [self substringWithRange:NSMakeRange(12,2)];
    
    [birth appendString:year];
    [birth appendString:@"-"];
    [birth appendString:month];
    [birth appendString:@"-"];
    [birth appendString:day];
    return birth;
}

- (NSString *)sexFromIdentityCard{
    int sexInt;
    
    if (self.length<15){
        if(self.length == 15){
            sexInt = [[self substringFromIndex:(self.length-1)] intValue];
        }else{
            sexInt = [[self substringWithRange:NSMakeRange(16,1)] intValue];
        }
        
        if(sexInt%2!=0) return kLocalizationMsg(@"男");
        else return kLocalizationMsg(@"女");
    }
    return kLocalizationMsg(@"男");
}

-(NSString *)ageFromIdentityCard{
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *bsyDate = [formatterTow dateFromString:[self birthdayStrFromIdentityCard]];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return [NSString stringWithFormat:@"%d",-age];
}

- (BOOL)isEmpty{
    NSString * newSelf = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(nil == self
       || self.length ==0
       || [self isEqualToString:@""]
       || [self isEqualToString:@"<null>"]
       || [self isEqualToString:@"(null)"]
       || [self isEqualToString:@"null"]
       || newSelf.length ==0
       || [newSelf isEqualToString:@""]
       || [newSelf isEqualToString:@"<null>"]
       || [newSelf isEqualToString:@"(null)"]
       || [newSelf isEqualToString:@"null"]
       || [self isKindOfClass:[NSNull class]] ){
        return YES;
    }else{
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        return [trimedString isEqualToString: @""];
    }
    return NO;
}

- (BOOL)hasValue{
    NSString * newSelf = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(nil == self
       || self.length ==0
       || [self isEqualToString:@""]
       || [self isEqualToString:@"<null>"]
       || [self isEqualToString:@"(null)"]
       || [self isEqualToString:@"null"]
       || newSelf.length ==0
       || [newSelf isEqualToString:@""]
       || [newSelf isEqualToString:@"<null>"]
       || [newSelf isEqualToString:@"(null)"]
       || [newSelf isEqualToString:@"null"]
       || [self isKindOfClass:[NSNull class]] ){
        return NO;
    }else{
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        return ![trimedString isEqualToString: @""];
    }
    return YES;
}


- (NSArray <NSTextCheckingResult *> *)machesWithEmoji
{
    NSError *error = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"\\[\\w+\\]" options:0 error:&error];
    if (error)
    {
       // NSLog(@"过滤文字正则表达式创建失败"));
        return nil;
    }
    return [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
}


- (BOOL)validPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)validPureLongLong{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int64_t val;
    return[scan scanLongLong:&val] && [scan isAtEnd];
}

- (BOOL)validPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


///身份证验证
- (BOOL)validateIDCardNumber{
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:self];
    if (!isRe) {
        //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [self.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}

-(UIImage *) getImageFromURLStr{
    
   // NSLog(@"过滤文字执行图片下载函数"));
    if ([self isEmpty]) {
        return nil;
    }
    
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self]];
    result = [UIImage imageWithData:data];
    return result;
}


///是否为手机号
- (BOOL)valiMobile{
    NSString *mobile = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 号段正则表达式
         */
        NSString *CM_NUM = @"^(1)[0-9]{10}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        if (isMatch1) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (BOOL)valiPassWord{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,50}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

+ (NSString *)changeShowTimeForSecond:(int64_t)time{
    if (time == 0) {
        return @"00:00";
    }
    int64_t hh = time / 3600;
    int64_t mm = time % 3600 / 60;
    int64_t ss = time % 60;
    if (hh > 0) {
        return [NSString stringWithFormat:@"%02lld:%02lld:%02lld",hh,mm,ss];
    }
    else{
        return [NSString stringWithFormat:@"%02lld:%02lld",mm,ss];
    }
    
}

+ (NSString *)getNowTimeTimestamp{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    long long int currentTime = (long long int)time;
    NSString *timestamp = [NSString stringWithFormat:@"%lld000", currentTime];
    return timestamp;
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{

    if ([jsonString isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)jsonString;
    }
    if ([jsonString isKindOfClass:[NSString class]] && jsonString.length > 0) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err)
        {
           // NSLog(@"过滤文字json解析失败：%@"),err);
            return nil;
        }
        return dic;
    }
    return nil;
}


///加密
- (NSString *)aes256_encrypt {
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    /*AES加密与解密的秘钥，需要与后台协商共同定义，保持与后台的秘钥相同*/
    [aesPwd getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *sourceData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [sourceData length];
    size_t buffersize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(buffersize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [sourceData bytes], dataLength, buffer, buffersize, &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //对加密后的二进制数据进行base64转码
        return [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }else{
        free(buffer);
        return nil;
    }
}

///解码
- (NSString *)aes256_decrypt {
    //先对加密的字符串进行base64解码
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    /*AES加密与解密的秘钥，需要与后台协商共同定义，保持与后台的秘钥相同*/
    [aesPwd getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [decodeData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [decodeData bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return result;
    }else{
        free(buffer);
        return nil;
    }
}


- (NSString *)md5Encrypt{
    
    const char *cStr = [self UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}


+ (NSString *)stringForCompressNum:(NSInteger)number{
    
    NSString *showStr = @"";
    if (number < 10000) {
    
        showStr = [NSString stringWithFormat:@"%zi",number];
    
    }else{
        ///向下取整
        CGFloat tempNum = floorf(number/1000.0);
        showStr = [NSString stringWithFormat:@"%.1lfw",tempNum/10.0];
    }
    
    return showStr;
}


@end
