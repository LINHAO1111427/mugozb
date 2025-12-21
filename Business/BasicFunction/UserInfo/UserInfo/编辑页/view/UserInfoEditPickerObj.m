//
//  UserInfoEditPickerObj.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoEditPickerObj.h"
#import "BRPickerView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>
 
#import <LibProjModel/HttpApiUserController.h>

#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/StarPriceDOModel.h>
#import <LibProjModel/UserController_userUpdate.h>
#import <LibProjView/CustomBRPickerView.h>

@interface UserInfoEditPickerObj ()

@property (nonatomic, copy)userInfoPickerCallBack callBack;
@property (nonatomic, assign)int type;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)ApiUserInfoModel *userModel;
@property (nonatomic, weak)CustomBRPickerView *pickerV;
@property (nonatomic, assign)int limit;

@end


@implementation UserInfoEditPickerObj

- (void)showInfoPickerWithType:(int)type limit:(int)limit model:(ApiUserInfoModel *)userModel title:(NSString *)title callBack:(userInfoPickerCallBack)callBack{
    self.userModel = userModel;
    self.type = type;
    self.title = title;
    self.limit = limit;
    self.callBack = callBack;
    [self showPickerView];
}
 
- (void)updateInfo{
    UserController_userUpdate *update = [[UserController_userUpdate alloc]init];
    ApiUserInfoModel *usermodel = self.userModel;
    update.birthday = usermodel.birthday.length > 0?usermodel.birthday:@"";;
    update.constellation = usermodel.constellation.length > 0?usermodel.constellation:@"";
    update.height = -1;
    update.liveThumb = @"";
    update.sex = -1;
    update.signature = @"";
    update.username = @"";
    update.vocation = @"";
    update.wechat = @"";
    update.sex = usermodel.sex;
    update.height = usermodel.height >0?usermodel.height:-1;
    update.weight = usermodel.weight>0?usermodel.weight:-1;
    update.sanwei = usermodel.sanwei.length>0?usermodel.sanwei:@"";
    kWeakSelf(self);
    [HttpApiUserController userUpdate:update callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            if (weakself.callBack) {
                weakself.callBack(YES);
            }
            [weakself.pickerV dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)showPickerView{
    if (self.type == 2 || self.type == 3) {//生日
        [self birthdayPicke];
    }else{
        NSInteger selectedIndex = 0;
        NSMutableArray *sourceArr = [NSMutableArray array];
        if (self.type == 5) {//身高
            NSInteger userHeight = 170;
            if (self.userModel.height > 0) {
                userHeight = self.userModel.height;
            }
            for (int i = 150; i <= 200; i++) {
                [sourceArr addObject:[NSString stringWithFormat:@"%dcm",i]];
                if (i == userHeight) {
                    selectedIndex = i-150;
                }
            }
            [self stringPikser:sourceArr selectedIndex:selectedIndex];
            
        }else if (self.type == 6){//体重
            NSInteger userWeight = 50;
            if (self.userModel.height > 0) {
                userWeight = (int)self.userModel.weight;
            }
            for (int i = 40; i <= 100; i++) {
                [sourceArr addObject:[NSString stringWithFormat:@"%dkg",i]];
                if (i == userWeight) {
                    selectedIndex = i-40;
                }
            }
            [self stringPikser:sourceArr selectedIndex:selectedIndex];
            
        }else if (self.type == 7){//三围
            NSInteger h = 85;
            NSInteger m = 65;
            NSInteger l = 80;
            if (self.userModel.sanwei.length > 0) {
                NSArray *sanweiArr = [self.userModel.sanwei componentsSeparatedByString:@","];
                if (sanweiArr.count > 2) {
                    h = [sanweiArr[0] integerValue];
                    m = [sanweiArr[1] integerValue];
                    l = [sanweiArr[2] integerValue];
                }
            }
        
            int oneIndex = 0;
            int twoIndex = 0;
            int threeIndex = 0;
            NSMutableArray *xArr = [NSMutableArray array];
            for (int i = 70; i <= 105; i++) {
                [xArr addObject:[NSString stringWithFormat:@"%d",i]];
                if (i == h) {
                    oneIndex = i-70;
                }
                
            }
            [sourceArr addObject:[NSArray arrayWithArray:xArr]];
            
            NSMutableArray *yArr = [NSMutableArray array];
            for (int i = 50; i <= 80; i++) {
                [yArr addObject:[NSString stringWithFormat:@"%d",i]];
                if (i == m) {
                    twoIndex = i-50;
                }
            }
            [sourceArr addObject:[NSArray arrayWithArray:yArr]];
            
            NSMutableArray *tArr = [NSMutableArray array];
            for (int i = 80; i <= 100; i++) {
                [tArr addObject:[NSString stringWithFormat:@"%d",i]];
                if (i == l) {
                    threeIndex = i-80;
                }
            }
            [sourceArr addObject:[NSArray arrayWithArray:tArr]];
            
            NSArray *selectIndexs = @[@(oneIndex),@(twoIndex),@(threeIndex)];
            [self userSanwei:sourceArr selectIndexs:selectIndexs];
        }else if (self.type == 8){//性别
            NSInteger sex = 0;
            sex = (int)self.userModel.sex;
            for (int i = 0; i <= 2; i++) {
                if (i == 0) {
                    [sourceArr addObject:kLocalizationMsg(@"其他")];
                }else if(i == 1){
                    [sourceArr addObject:kLocalizationMsg(@"男")];
                }else if(i == 2){
                    [sourceArr addObject:kLocalizationMsg(@"女")];
                }
                if (i == sex) {
                    selectedIndex = i;
                }
            }
            [self stringPikser:sourceArr selectedIndex:selectedIndex];
        }
    }
}


- (void)stringPikser:(NSArray*)sourceArr selectedIndex:(NSInteger)selectedIndex{
    kWeakSelf(self);
    CustomStringPickerView *picker = [[CustomStringPickerView alloc] init];
    picker.showTitle = self.title;
    [picker showStringPicker:@(selectedIndex) stringArr:sourceArr];
    picker.doneBlock = ^(BRResultModel * _Nonnull resultModel) {
        if (self.type == 5) {//身高
            weakself.userModel.height = (int)resultModel.index+150;
        }else if (self.type == 6){//体重
            weakself.userModel.weight = (int)resultModel.index+40;
        }else if(self.type == 8){//性别
            weakself.userModel.sex = (int)resultModel.index;
        }
        [weakself updateInfo];
    };
    _pickerV = picker;
}


////设置用户三维
- (void)userSanwei:(NSArray*)sourceArr selectIndexs:(NSArray*)selectIndexs{
    kWeakSelf(self);
    CustomStringPickerView *pickerV = [[CustomStringPickerView alloc] init];
    pickerV.showTitle = self.title;
    [pickerV showMultiStringPicker:selectIndexs stringArr:sourceArr];
    pickerV.multiDoneBlock = ^(NSArray<BRResultModel *> * _Nonnull resultModelArr) {
        NSMutableString *strr = [NSMutableString string];
        for (int i = 0; i < resultModelArr.count; i++) {
            BRResultModel *model = resultModelArr[i];
            if (i == 0) {
                [strr appendFormat:@"%@",model.value];
            }else{
                [strr appendFormat:@" %@",model.value];
            }
        }
        weakself.userModel.sanwei = strr;
        [weakself updateInfo];
    };
    _pickerV = pickerV;
}


//生日
- (void)birthdayPicke{
    kWeakSelf(self);
    CustomDataPickerView *datePicker = [[CustomDataPickerView alloc] init];
    datePicker.showTitle = self.title;
    [datePicker showDatePicker:self.userModel.birthday limit:self.limit dateFormatter:@"yyyy-MM-dd"];
    datePicker.doneBlock = ^(NSDate * _Nonnull selectDate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *selectValue = [selectDate timeStringWithDateFormat:@"yyyy-MM-dd"];
            weakself.userModel.birthday = selectValue;
            NSArray *dataArr = [selectValue componentsSeparatedByString:@"-"];
            int mounth = [dataArr[1] intValue];
            int day = [dataArr[2] intValue];
            NSString *constellation = [self getAstroWithMonth:mounth day:day];
            weakself.userModel.constellation = constellation;
            [weakself updateInfo];
        });
    };
}

//获取星座
- (NSString *)getAstroWithMonth:(int)m day:(int)d{
    NSString *astroString = kLocalizationMsg(@"摩羯座水瓶座双鱼座白羊座金牛座双子座巨蟹座狮子座处女座天秤座天蝎座射手座摩羯座");
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return kLocalizationMsg(@"错误日期格式!");
    }
    if(m==2 && d>29){
        return kLocalizationMsg(@"错误日期格式!!");
    }else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return kLocalizationMsg(@"错误日期格式!!!");
        }
    }
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*3-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*3,3)]];
    return result;
}
//比较日期
- (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta =  [dateformater dateFromString:aDate];
    NSDate *dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame){// 相等
          aa = 0;
    }else if (result == NSOrderedAscending){//bDate比aDate大
          aa = 1;
    }else if (result == NSOrderedDescending){//bDate比aDate小
        aa = -1;
    }
    return aa;
}


@end
