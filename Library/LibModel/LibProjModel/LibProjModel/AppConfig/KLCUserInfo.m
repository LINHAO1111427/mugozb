//
//  KLCUserInfo.m
//  TCDemo
//
//  Created by admin on 2020/9/19.
//  Copyright © 2019 CH. All rights reserved.
//

#import "KLCUserInfo.h"
#import <LibTools/LibTools.h>
#import "ApiUserInfoModel.h"
#import "HttpApiUserController.h"
#import <LibProjBase/ProjBaseData.h>
#import <LibProjModel/ApiUserInfoLoginModel.h>


#define UserInfoKey       @"UserInfomationKey"
#define LoginInfoKey      @"LoginInfomationKey"

@interface KLCUserInfo ()

///登陆信息
@property (nonatomic, strong)ApiUserInfoLoginModel *loginInfo;

@property (nonatomic, strong)ApiUserInfoModel *userInfo;

@end

@implementation KLCUserInfo

+ (instancetype)share{
    static KLCUserInfo *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userInfo == nil) {
            userInfo = [[KLCUserInfo alloc] init];
        }
    });
    return userInfo;
}

- (ApiUserInfoLoginModel *)loginInfo{
    if (!_loginInfo) {
        NSDictionary *loginInfoDic = [NSUserDefaults arcObjectForKey:LoginInfoKey];
        _loginInfo = [ApiUserInfoLoginModel getFromDict:loginInfoDic];
    }
    return _loginInfo;
}

- (ApiUserInfoModel *)userInfo{
    if (!_userInfo) {
        NSDictionary *userInfoDic = [NSUserDefaults arcObjectForKey:UserInfoKey];
        _userInfo = [ApiUserInfoModel getFromDict:userInfoDic];
    }
    return _userInfo;
}

///保存登陆信息
- (void)saveLoginInfo:(ApiUserInfoLoginModel *)loginInfo{
    self.loginInfo = loginInfo;
    kWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ///保存登陆信息
        NSDictionary *loginInfoDic = [weakself.loginInfo modelToJSONObject];
        [NSUserDefaults setArcObject:loginInfoDic forKey:LoginInfoKey];
    });
}

////保存用户信息
- (void)saveUserInfo:(ApiUserInfoModel *)userInfo{
    self.userInfo = userInfo;
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserInfoUpdate object:nil];
    kWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ///保存用户信息
        NSDictionary *userInfoDic = [weakself.userInfo modelToJSONObject];
        [NSUserDefaults setArcObject:userInfoDic forKey:UserInfoKey];
    });
}


+ (void)setAppLoginedInfo:(ApiUserInfoLoginModel *)login {
    [[KLCUserInfo share] saveUserInfo:login.userInfo];
    [[KLCUserInfo share] saveLoginInfo:login];
    
    if (login.isFirstLogin == 1) { ///是第一次登录
        
    }
}


+ (void)updateUserInfo:(void (^)(void))complete{
    ApiUserInfoModel *userInfo = [KLCUserInfo share].userInfo;
    if (userInfo.userId < 1) {
        return;
    }
    [HttpApiUserController getUserInfo:userInfo.userId callback:^(int code, NSString *strMsg, ApiUserInfoModel *model) {
        if (code == 1) {
            [[KLCUserInfo share] saveUserInfo:model];
            if (complete) {
                complete();
            }
        }
    }];
}


+ (void)setServiceUserInfo:(UserController_userUpdate *)userInfo complete:(void (^ _Nullable)(BOOL, NSString * _Nonnull))complete{
    
    if (userInfo) {
        UserController_userUpdate *update = userInfo;
        ApiUserInfoModel *user = [KLCUserInfo getUserInfo];
        update.birthday = update.birthday.length>0?update.birthday:user.birthday;
        update.constellation = update.constellation.length>0?update.constellation:user.constellation;
        update.height = update.height >0?update.height:user.height;
        update.liveThumb = update.liveThumb.length>0?update.liveThumb:user.liveThumb;
        update.sex = update.sex>0?update.sex:[KLCUserInfo getGender];
        update.signature = update.signature.length>0?update.signature:user.signature;
        update.username = update.username.length>0?update.username:user.username;
        update.vocation = update.vocation.length>0?update.vocation:user.vocation;
        update.wechat = update.wechat.length>0?update.wechat:@"";
        update.weight = update.weight>0?update.weight:user.weight;
        update.sanwei = update.sanwei.length>0?update.sanwei:user.sanwei;
        [HttpApiUserController userUpdate:update callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [[KLCUserInfo share] updateSetServiceUserInfo:update];
            }else{
            }
            if (complete) {
                complete(code==1?YES:NO, strMsg);
            }
        }];
    }else{
        if (complete) {
            complete(NO, @"");
        }
    }
}

- (void)updateSetServiceUserInfo:(UserController_userUpdate *)userUpdate{
    //本地缓存
    ApiUserInfoModel *usermodel = _userInfo;
    if (userUpdate.birthday.length>0) { ///生日
        usermodel.birthday = userUpdate.birthday;
    }
    if (userUpdate.constellation.length>0) { //星座
        usermodel.constellation = userUpdate.constellation;
    }
    if (userUpdate.height>0) { //身高
        usermodel.height = userUpdate.height;
    }
    if (userUpdate.liveThumb.length>0) { ///封面
        usermodel.liveThumb=userUpdate.liveThumb;
    }
    if (userUpdate.signature.length>0) {  ///签名
        usermodel.signature=userUpdate.signature;
    }
    if (userUpdate.username.length>0) { ///用户名
        usermodel.username=userUpdate.username;
    }
    if (userUpdate.vocation.length>0) {  ///职业
        usermodel.vocation=userUpdate.vocation;
    }
    if (userUpdate.sex>0) { ///性别
        usermodel.sex = userUpdate.sex;
    }
    if (userUpdate.weight>0) { ///体重
        usermodel.weight = userUpdate.weight;
    }
    [self saveUserInfo:usermodel];
}


+ (ApiUserInfoModel *)getUserInfo {
    return [KLCUserInfo share].userInfo;
}

+ (void)setUserInfo:(ApiUserInfoModel *)userInfo{
    [[KLCUserInfo share] saveUserInfo:userInfo];
}


+ (void)removeUserInfo{
    [KLCUserInfo share].userInfo = nil;
    [KLCUserInfo share].loginInfo = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserInfoKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LoginInfoKey];
}


+ (void)updateUserToken:(NSString *)userToken{
    ApiUserInfoLoginModel *loginInfo =  [KLCUserInfo share].loginInfo;
    loginInfo.user_token = userToken;
    [[KLCUserInfo share] saveLoginInfo:loginInfo];
}

+ (void)updateUserPhone:(NSString *)UserPhone{
    ApiUserInfoModel *userInfo =  [KLCUserInfo share].userInfo;
    userInfo.mobile = UserPhone;
    [[KLCUserInfo share] saveUserInfo:userInfo];
}


+ (NSString *)getUserToken{
    NSString *userToken =  [KLCUserInfo share].loginInfo.user_token;
    return userToken.length>0?userToken:@"";
}

///性别
+ (int)getGender{
    return [KLCUserInfo share].userInfo.sex;
}

+ (int64_t)getUserId{
    return [KLCUserInfo share].userInfo.userId;
}

+ (NSString *)getNikeName{
    NSString *username = [KLCUserInfo share].userInfo.username;
    return username.length?username:@"";
}

+(NSString *)getAvatar{
    NSString *avatar = [KLCUserInfo share].userInfo.avatar;
    return avatar.length?avatar:@"";
}

+ (int)getRole{
    return [KLCUserInfo share].userInfo.role;
}

+ (int)getSvip{
    return [KLCUserInfo share].userInfo.isSvip;
}

+ (int)getNobleGrade {
    return [KLCUserInfo share].userInfo.nobleGrade;
}

+ (NSArray *)packList{
    NSArray *packList = [KLCUserInfo share].loginInfo.packList;
    return  packList> 0?packList:@[];
}

+ (void)removePackList {
    ApiUserInfoLoginModel *loginInfo =  [KLCUserInfo share].loginInfo;
    loginInfo.packList = [[NSMutableArray alloc] init];
    [[KLCUserInfo share] saveLoginInfo:loginInfo];
}

+ (BOOL)isFirstLogin{
    return [KLCUserInfo share].loginInfo.isFirstLogin == 1 ? YES : NO;
}

+ (int64_t)userAvatarId{
    return [KLCUserInfo share].loginInfo.userAvatarId;
}

+ (BOOL)isFirstRechange{
    return [KLCUserInfo share].loginInfo.isFirstRecharge>0?NO:YES;
}
+ (void)alreadyShowFirstRechange{
    ApiUserInfoLoginModel *loginInfo =  [KLCUserInfo share].loginInfo;
    loginInfo.isFirstRecharge = 1;
    [[KLCUserInfo share] saveLoginInfo:loginInfo];
}

+ (double)getLat{
    return [KLCUserInfo share].userInfo.lat;
}

+ (double)getLng{
    return [KLCUserInfo share].userInfo.lng;
}

+ (NSString *)getCity{
    NSString *city = [KLCUserInfo share].userInfo.city;
    return city.length?city:@"";
}

+ (NSString *)getAddress{
    NSString *address = [KLCUserInfo share].userInfo.address;
    return address.length?address:@"";
}

+ (BOOL)isNeedBind{
    return [KLCUserInfo share].userInfo.isPid == 2?NO:YES;
}

+ (void)saveBind{
    ApiUserInfoModel *userInfo =  [KLCUserInfo share].userInfo;
    userInfo.isPid = 2;
    [[KLCUserInfo share] saveUserInfo:userInfo];
}


@end
