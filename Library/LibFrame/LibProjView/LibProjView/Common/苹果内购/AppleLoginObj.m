//
//  AppleLoginObj.m
//  LibProjView
//
//  Created by klc_sl on 2020/8/21.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "AppleLoginObj.h"
#import <LibTools/LibTools.h>

static AppleLoginObj *_loginObj = nil;

@interface AppleLoginObj ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, copy)void (^userInfoBlock)(BOOL ,AppleUserInfoModel *);

@end

@implementation AppleLoginObj

+ (void)authAppleID:(void (^)(BOOL, AppleUserInfoModel * _Nonnull))userInfoBlock{
    [[AppleLoginObj share] authUserLogin:userInfoBlock];
}


- (void)authUserLogin:(void (^)(BOOL, AppleUserInfoModel * _Nonnull))block{
    
    if (@available(iOS 13.0, *)) {
        
        _userInfoBlock = block;
        
        ASAuthorizationAppleIDProvider * appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest * authAppleIDRequest = [appleIDProvider createRequest];
        ASAuthorizationPasswordRequest * passwordRequest = [[[ASAuthorizationPasswordProvider alloc] init] createRequest];
        
        NSMutableArray <ASAuthorizationRequest *> * array = [NSMutableArray arrayWithCapacity:2];
        if (authAppleIDRequest) {
            [array addObject:authAppleIDRequest];
        }
        
        NSArray <ASAuthorizationRequest *> * requests = [array copy];
        
        ASAuthorizationController * authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:requests];
        authorizationController.delegate = self;
        authorizationController.presentationContextProvider = self;
        [authorizationController performRequests];
        
    } else {
        // 处理不支持系统版本
       // NSLog(@"过滤文字系统不支持Apple登录"));
    }
}


+ (AppleLoginObj *)share{
    if (!_loginObj) {
        _loginObj = [[AppleLoginObj alloc] init];
    }
    return _loginObj;
}



#pragma mark - ASAuthorizationControllerDelegate -

// 授权失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = kLocalizationMsg(@"用户取消了授权请求");
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = kLocalizationMsg(@"授权请求失败");
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = kLocalizationMsg(@"授权请求响应无效");
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = kLocalizationMsg(@"未能处理授权请求");
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = kLocalizationMsg(@"授权请求失败未知原因");
            break;
    }
    if (_userInfoBlock) {
        _userInfoBlock(NO, nil);
        _userInfoBlock = nil;
    }
}

/// Apple登录授权成功
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization{
    
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        ASAuthorizationAppleIDCredential * credential = authorization.credential;
        
        // 苹果用户唯一标识符，该值在同一个开发者账号下的所有 App 下是一样的，开发者可以用该唯一标识符与自己后台系统的账号体系绑定起来。
        NSString * userID = credential.user;
        
        // 苹果用户信息 如果授权过，可能无法再次获取该信息
        NSPersonNameComponents * fullName = credential.fullName;
        NSString * email = credential.email;
        
        // 服务器验证需要使用的参数
        NSString * authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        NSString * identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        
        // 用于判断当前登录的苹果账号是否是一个真实用户，取值有：unsupported、unknown、likelyReal
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"appleID"];
        
       // NSLog(@"过滤文字userID: %@"), userID);
       // NSLog(@"过滤文字fullName: %@"), fullName);
       // NSLog(@"过滤文字email: %@"), email);
       // NSLog(@"过滤文字authorizationCode: %@"), authorizationCode);
       // NSLog(@"过滤文字identityToken: %@"), identityToken);
       // NSLog(@"过滤文字realUserStatus: %@"), @(realUserStatus));
        
        ///返回数据
        if (_userInfoBlock) {
            AppleUserInfoModel *userInfo = [[AppleUserInfoModel alloc] init];
            userInfo.userId = userID;
            userInfo.userName = fullName.nickname;
            userInfo.authorizationCode = authorizationCode;
            userInfo.identityToken = identityToken;
            _userInfoBlock(YES, userInfo);
            _userInfoBlock = nil;
        }
        
    }
    else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        
        // 用户登录使用现有的密码凭证
        ASPasswordCredential * passwordCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString * user = passwordCredential.user;
        // 密码凭证对象的密码
        NSString * password = passwordCredential.password;
        
       // NSLog(@"过滤文字userID: %@"), user);
       // NSLog(@"过滤文字password: %@"), password);
        
        ///返回数据
        if (_userInfoBlock) {
            AppleUserInfoModel *userInfo = [[AppleUserInfoModel alloc] init];
            userInfo.userId = user;
            userInfo.userName = @"";
            userInfo.authorizationCode = @"";
            userInfo.identityToken = @"";
            _userInfoBlock(YES,userInfo);
            _userInfoBlock = nil;
        }
        
    } else {
        if (_userInfoBlock) {
            _userInfoBlock(NO, nil);
            _userInfoBlock = nil;
        }
    }
}

#pragma mark - ASAuthorizationControllerPresentationContextProviding
//告诉代理应该在哪个window 展示授权界面给用户
-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return [UIApplication sharedApplication].keyWindow;
}

+ (BOOL)authAppleLogin{
    if (@available(iOS 13.0, *)) {
        return YES;
    } else {
        return NO;
    }
}

@end


@implementation AppleUserInfoModel


@end
