//
//  AppleLoginObj.h
//  LibProjView
//
//  Created by klc_sl on 2020/8/21.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AuthenticationServices/AuthenticationServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleUserInfoModel : NSObject

@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *authorizationCode;
@property (nonatomic, copy)NSString *identityToken;

@end


@interface AppleLoginObj : NSObject


+ (void)authAppleID:(void(^)(BOOL success, AppleUserInfoModel *userInfo))userInfoBlock;


@end

NS_ASSUME_NONNULL_END
