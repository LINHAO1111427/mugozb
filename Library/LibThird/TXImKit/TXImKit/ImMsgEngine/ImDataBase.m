//
//  ImDataBase.m
//  IMSocket
//
//  Created by wy on 2020/7/14.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ImDataBase.h"
#import "ImSendResult.h"
#import "NSDictionary+Json.h"

///IMMsg数据存储
@interface ImDataBase ()
  
@property (nonatomic, assign) int64_t  uid;
 
@end


@implementation ImDataBase


static ImDataBase *sharedInstance = nil;
static sqlite3 *database = nil;


+(ImDataBase*)getIns{
    return sharedInstance;
}

-(void)closeDB{
    sqlite3_close(database);
}

-(void)createDB:(int64_t) uid{
    
    sharedInstance=self;
    
    self.uid=uid;
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    
    NSString *dbName= [NSString stringWithFormat:@"db8v%lli.db",uid];
    NSString * dbPathName = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: dbName]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    bool haveDataBase;
    
    if ([filemgr fileExistsAtPath: dbPathName ] == NO)
    {
        haveDataBase=NO;
    }else{
        haveDataBase=YES;
    }
    
    const char *dbpath = [dbPathName UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        char *errMsg;
        const char *sql=  "create table imExtraInfo(UGID BIGINT primary key,updateTime BIGINT,info text(8000))";
        sqlite3_exec(database, sql, NULL, NULL, &errMsg);
    }
}

 
 
/// 获取个人信息
/// @param UGID 用户群组标识
-(ImExtraInfo*)getExtraInfo:(int64_t)UGID{
    NSString* sql=[NSString stringWithFormat:@"select info,updateTime from  imExtraInfo where  UGID=%lli",UGID];
    
    sqlite3_stmt * stmt;
    ImExtraInfo*info=[[ImExtraInfo alloc] init];
    if (sqlite3_prepare(database, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            char *charExtra = (char *)sqlite3_column_text(stmt, 0);
            if(charExtra!=nil)
            {
                NSString* strExtra=[[NSString alloc] initWithUTF8String:charExtra];
                info.extraInfo=[self strToDict:strExtra];;
            }
            int64_t  updateTime=sqlite3_column_int64(stmt, 1);
            info.extraInfoUpdateTime=[NSDate dateWithTimeIntervalSince1970:updateTime/1000.0];
            
            break;
        }
    }
    sqlite3_finalize(stmt);
    return info;
    
}

 
/// 更新存储个人信息
/// @param ditExtraInfo 信息内容
/// @param UGID 用户群组标识
- (void)setExtraInfo:(NSDictionary*)ditExtraInfo withUGID:(int64_t)UGID{
    if (ditExtraInfo == nil) {
        return;
    }
    NSString*extraInfo = [ditExtraInfo toStr];
    if (extraInfo.length > 4000) {
        return;
    }
    
    int64_t updateTime=(int64_t)([[NSDate date] timeIntervalSince1970]*1000);
    
    char *errMsg;
    sqlite3_exec(database, [NSString stringWithFormat:@"delete from imExtraInfo where UGID=%lli",UGID].UTF8String, NULL, NULL, &errMsg);
    
    
    char* sql=  "INSERT INTO imExtraInfo(UGID,updateTime,info) VALUES(?,?,?);";
    
    sqlite3_stmt *stmt;
    
    
    if (sqlite3_prepare_v2(database, sql, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, UGID);
        sqlite3_bind_int64(stmt, 2, updateTime);
        sqlite3_bind_text(stmt, 3, extraInfo.UTF8String,-1,NULL);
    }
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}

 

/// 删除某个人的信息
/// @param UGID 用户群组标识
- (void)delExtraInfo:(int64_t)UGID {
    char *errMsg;
    sqlite3_exec(database, [NSString stringWithFormat:@"delete from imExtraInfo where UGID=%lli",UGID].UTF8String, NULL, NULL, &errMsg);
}


-(NSDictionary*) strToDict:(NSString*)json{
    NSData *jsonData  = [json dataUsingEncoding : NSUTF8StringEncoding];
    NSDictionary *dic =nil;
    if (jsonData) {
        
        dic  = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
        
    }
    return dic;
}


@end
