//
//  SetUserMarkVC.m
//  UserInfo
//
//  Created by klc_sl on 2021/3/18.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SetUserMarkVC.h"
#import <TXImKit/TXImKit.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiChatMsgController.h>
#import <LibProjModel/UserGroupIdDtoModel.h>
#import <LibProjModel/AppIdBOModel.h>
#import <LibProjView/SendIMMessageObj.h>
 
@interface SetUserMarkVC () <UITextFieldDelegate>

@property (nonatomic, weak)UITextField *textF;

@end

@implementation SetUserMarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = kLocalizationMsg(@"设置备注");
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemTitle:kLocalizationMsg(@"保存") bgColor:[UIColor whiteColor] textColor:kRGB_COLOR(@"#333333") clickHandle:^{
        [self saveBtnClick];
    }]];
    
    self.view.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    
    [self createUI];
}

- (void)saveBtnClick{
    kWeakSelf(self);
    [HttpApiUserController setUserNameRemarks:_textF.text.length > 0? _textF.text:@"" toUserId:[self.userId longLongValue] callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself updateUserInfo:[self.userId longLongValue] resultBlock:^(NSDictionary *extInfoDic) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.navigationController popViewControllerAnimated:YES];
                });
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)deleteUserInfo{
    [IMInfoManager deleteUserExtraInfo:[self.userId longLongValue]];
}


- (void)createUI{
    
    UIView *inputView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 48)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputView];
    UITextField *inputT = [[UITextField alloc]initWithFrame:CGRectMake(12, 4, kScreenWidth-24, 40)];
    inputT.textColor = kRGB_COLOR(@"#2B2C2C");
    inputT.font = [UIFont systemFontOfSize:14];
    inputT.textAlignment = NSTextAlignmentLeft;
    inputT.delegate = self;
    inputT.clearButtonMode = UITextFieldViewModeAlways;
    inputT.placeholder = kLocalizationMsg(@"请输入您想设置的备注");
    inputT.text = self.remark.length > 0?self.remark:@"";
    self.textF = inputT;
    [inputView addSubview:inputT];
}

- (void)deleteBtnClick:(UIButton *)btn{
    _textF.text = @"";
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length == 0) {
        return YES;
    }
    
    if (textField.text.length+string.length > 15) {
        return NO;
    }
    return YES;
}

#pragma mark - 修改用户信息
- (void)updateUserInfo:(int64_t)userId  resultBlock:(void(^)(NSDictionary *extInfoDic))resultBlock{
    NSMutableArray *groupArr = [[NSMutableArray alloc] init];
    NSMutableArray *userArr = [[NSMutableArray alloc] init];
    AppIdBOModel *idmodel = [[AppIdBOModel alloc]init];
    idmodel.id_field = userId;
    [userArr addObject:idmodel];
     
    UserGroupIdDtoModel *model = [[UserGroupIdDtoModel alloc]init];
    model.groupIdList = groupArr;
    model.userIdList = userArr;
    [HttpApiChatMsgController getImExtraInfo1:model callback:^(int code, NSString *strMsg, NSArray<ImExtraInfoModel *> *arr) {
        if (code == 1 && arr.count) {
            NSMutableDictionary *extInfoDic = [[NSMutableDictionary alloc] init];
            for (ImExtraInfoModel *userInfoM in arr) {
                if (userInfoM.name.length || userInfoM.avatar.length) {
                    NSDictionary *dict = [userInfoM modelToJSONObject];
                    [extInfoDic setObject:dict forKey:@(userInfoM.UGID)];
                    [[IMSocketIns getIns] setExtraInfo:userInfoM.UGID ditExtraInfo:dict];
                }
            }
            resultBlock?resultBlock([extInfoDic copy]):nil;
        }else{
            resultBlock?resultBlock(@{}):nil;
        }
    }];
}
@end

