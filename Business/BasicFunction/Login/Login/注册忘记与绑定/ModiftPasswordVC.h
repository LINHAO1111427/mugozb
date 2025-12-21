//
//  ModiftPasswordVC.m
//  3V-Project  项目登录
//
//  Created by admin on 2019/8/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LoginFaceTypeRegister = 0,//注册
    LoginFaceTypeLosePwd =1,//忘记密码
    LoginFaceTypeBindPhone =2,//三方登陆绑定手机号
}LoginFaceType;
@interface ModiftPasswordVC : UIViewController

////0注册 1忘记密码 2绑定手机号
@property (nonatomic, copy)NSNumber *operationTypetype;

@end
