//
//  shortVideoIdSaveObj.m
//  ShortVideo
//
//  Created by klc_sl on 2021/5/21.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ShortVideoIdSaveObj.h"

@implementation ShortVideoIdSaveObj

@synthesize shortVideoId = _shortVideoId;

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:_shortVideoId forKey:@"shortVideoId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _shortVideoId = [aDecoder decodeIntForKey:@"shortVideoId"];
    }
    return self;
}

#pragma mark - NSCoping
- (id)copyWithZone:(NSZone *)zone {
    ShortVideoIdSaveObj *copy = [[[self class] allocWithZone:zone] init];
    copy.shortVideoId = self.shortVideoId;
    return copy;
}

#pragma mark - 归档与解档
+ (void)ArchiveShortVideoWith:(int64_t)shortVideoId{
    
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *arrPath =[docPath stringByAppendingPathComponent:@"shortVideoId.arr"];
    NSArray *saveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:arrPath];
    NSMutableArray *mutArr = [NSMutableArray array];
    if (saveArray) {
        mutArr = [NSMutableArray arrayWithArray:saveArray];
        BOOL isContain = NO;
        for (ShortVideoIdSaveObj *obj in saveArray) {
            if (obj.shortVideoId == shortVideoId) {
                isContain = YES;
                break;
            }
        }
        if (!isContain) {
            ShortVideoIdSaveObj *obj = [[ShortVideoIdSaveObj alloc]init];
            obj.shortVideoId = (int)shortVideoId;
            [mutArr addObject:obj];
            BOOL flag = [NSKeyedArchiver archiveRootObject:mutArr toFile:arrPath];
           // NSLog(@"过滤文字免费短视频id == %lld保存%@"),shortVideoId,flag?kLocalizationMsg(@"成功"):kLocalizationMsg(@"失败"));
        }
    }else{
        ShortVideoIdSaveObj *obj = [[ShortVideoIdSaveObj alloc] init];
        obj.shortVideoId = (int)shortVideoId;
        [mutArr addObject:obj];
        BOOL flag = [NSKeyedArchiver archiveRootObject:mutArr toFile:arrPath];
       // NSLog(@"过滤文字免费短视频id == %lld保存%@"),shortVideoId,flag?kLocalizationMsg(@"成功"):kLocalizationMsg(@"失败"));
 
    }
}


+ (ShortVideoIdSaveObj*)unArchiveShortVideoWith:(int64_t)shortVideoId{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *arrPath =[docPath stringByAppendingPathComponent:@"shortVideoId.arr"];
    NSArray *saveArray = [NSKeyedUnarchiver unarchiveObjectWithFile:arrPath];
    ShortVideoIdSaveObj *objReturn;
    if (saveArray) {
        for (ShortVideoIdSaveObj *obj in saveArray) {
           // NSLog(@"过滤文字============每一个保存的数据%lld"),shortVideoId);
            if (obj.shortVideoId == shortVideoId) {
               // NSLog(@"过滤文字============已保存%lld"),shortVideoId);
                objReturn = obj;
                break;
            }
        }
    }
    return objReturn;
}



@end
