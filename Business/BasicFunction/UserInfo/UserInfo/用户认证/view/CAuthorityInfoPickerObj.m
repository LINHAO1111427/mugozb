//
//  CAuthorityInfoPickerObj.m
//  MineCenter
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CAuthorityInfoPickerObj.h"
#import "BRPickerView.h" 
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>
 
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiOOOLive.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/StarPriceDOModel.h>
#import <LibProjModel/AnchorAuthVOModel.h>
#import <LibProjModel/UserController_userUpdate.h>
#import <LibProjModel/PayCallOneVsOneDOModel.h>
#import <LibProjModel/HttpApiAnchorAuthenticationController.h>
#import <LibProjModel/AppLiveChannelModel.h>
#import <LibProjModel/OooTwoClassifyVOModel.h>
#import <LibProjView/CustomBRPickerView.h>

@interface CAuthorityInfoPickerObj()
@property (nonatomic, copy)AuthorityInfoPickerCallBack callBack;
@property (nonatomic, assign)int type;
@property (nonatomic, strong)AnchorAuthVOModel *authModel;
@property (nonatomic, assign) int64_t O2OCallPriceId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign)int limit;
@property (nonatomic, weak)CustomBRPickerView *pickerView;
@property (nonatomic, strong) NSDictionary *strategies;

@end

@implementation CAuthorityInfoPickerObj

- (NSDictionary *)strategies{
    if (!_strategies) {
        _strategies = @{
            @"stratege_2"  : [self invocationWithMethod:@selector(invokeBirthdayPicke)],
            @"stratege_3"  : [self invocationWithMethod:@selector(invokeBirthdayPicke)],
            @"stratege_5"  : [self invocationWithMethod:@selector(invokeUserHeight)],
            @"stratege_6"  : [self invocationWithMethod:@selector(invokeUserWeight)],
            @"stratege_7"  : [self invocationWithMethod:@selector(invokeUserSanwei)],
            @"stratege_9"  : [self invocationWithMethod:@selector(invokeWechatNo)],
            @"stratege_14" : [self invocationWithMethod:@selector(invokeVideoFee)],
            @"stratege_15" : [self invocationWithMethod:@selector(invokeVoiceFee)],
            @"stratege_31" : [self invocationWithMethod:@selector(invokeAnchorCategory)]
        };
    }
    return _strategies;
}
- (NSInvocation *)invocationWithMethod:(SEL)selector{
    NSMethodSignature*signature = [CAuthorityInfoPickerObj instanceMethodSignatureForSelector:selector];
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    return invocation;
}
- (void)showInfoPickerWithType:(int)type limit:(int)limit model:(AnchorAuthVOModel *)authModel title:(NSString *)title callBack:(AuthorityInfoPickerCallBack)callBack{
    self.authModel = authModel;
    self.type = type;
    self.callBack = callBack;
    self.title = title;
    self.limit = limit;
    [self showPickerView];
    
}
 

- (void)showPickerView{
    NSString *key = [NSString stringWithFormat:@"stratege_%d",self.type];
    NSInvocation *invocation = self.strategies[key];
    if (invocation) {
        [invocation invoke];
    }
}

#pragma mark - 执行方法
- (void)stringPikser:(NSArray*)sourceArr selectedIndex:(NSInteger)selectedIndex{
    kWeakSelf(self);
    CustomStringPickerView *pickerV = [[CustomStringPickerView alloc] init];
    pickerV.showTitle = self.title;
    [pickerV showStringPicker:@(selectedIndex) stringArr:sourceArr];
    pickerV.doneBlock = ^(BRResultModel * _Nonnull resultModel) {
        if (weakself.type == 5) {//身高
            weakself.authModel.height = (int)resultModel.index+150;
        }else if (weakself.type == 6){//体重
            weakself.authModel.weight = (int)resultModel.index+40;
        }else if (weakself.type == 9){//查看微信号
            StarPriceDOModel *model = self.authModel.wechatPriceList[resultModel.index];
            weakself.authModel.wechatPrice = (int)model.price;
        }
        ///更新用户信息
        [weakself updateInfo];
    };
    _pickerView = pickerV;
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
        weakself.authModel.sanwei = strr;
        ///更新用户信息
        [weakself updateInfo];
    };
    _pickerView = pickerV;
}


///一对一语音费用和一对一视频费用设置
- (void)o2oFeeSetPicket:(NSArray*)sourceArr selectedIndex:(NSInteger)selectedIndex{
    kWeakSelf(self);
     
    UILabel *detailL = [[UILabel alloc] init];
    detailL.font = [UIFont systemFontOfSize:10];
    detailL.textAlignment = NSTextAlignmentRight;
    detailL.textColor = [ProjConfig normalColors];
    
    CustomStringPickerView *pickerV = [[CustomStringPickerView alloc] init];
    pickerV.showTitle = self.title;
    pickerV.changeBlock = ^(BRResultModel * _Nonnull resultModel) {
        if (weakself.type == 14){//视频接听收费
            StarPriceDOModel *model = weakself.authModel.videoPriceList[resultModel.index];
            detailL.text = [NSString stringWithFormat:kLocalizationMsg(@"(%.0lf元/分钟)"),model.money];
        }else if (weakself.type == 15){//语音接听收费
            StarPriceDOModel *model = weakself.authModel.voicePriceList[resultModel.index];
            detailL.text = [NSString stringWithFormat:kLocalizationMsg(@"(%.0lf元/分钟)"),model.money];
        }
    };
    pickerV.doneBlock = ^(BRResultModel * _Nonnull resultModel) {
        if (weakself.type == 14){//视频接听收费
            StarPriceDOModel *model = self.authModel.videoPriceList[resultModel.index];
            weakself.O2OCallPriceId = model.id_field;
            weakself.authModel.payCall.videoCoin = (int)model.price;
        }else if (weakself.type == 15){//语音接听收费
            StarPriceDOModel *model = self.authModel.voicePriceList[resultModel.index];
            weakself.O2OCallPriceId = model.id_field;
            weakself.authModel.payCall.voiceCoin = (int)model.price;
        }
        ///更新用户信息
        [weakself updateInfo];
    };
    [pickerV showStringPicker:@(selectedIndex) stringArr:sourceArr];
    detailL.frame = CGRectMake(kScreenWidth-100, pickerV.height/2.0-25, 80, 50);
    [pickerV addSubview:detailL];
    _pickerView = pickerV;
}

///用户分类
- (void)userLevelPicket:(NSArray*)sourceArr num:(int)num selectedIndex:(NSArray *)selectIndexs{
    kWeakSelf(self);
    CustomStringPickerView *pickerV = [[CustomStringPickerView alloc] init];
    pickerV.showTitle = self.title;
    pickerV.multiDoneBlock = ^(NSArray<BRResultModel *> * _Nonnull resultModelArr) {
        
        NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:1];
        for (BRResultModel *resultM in resultModelArr) {
            [titleArr addObject:resultM.value];
            
            switch ([resultM.remark intValue]) {
                case 0:
                {
                    weakself.authModel.oooOneClassifyId = [resultM.key longLongValue];
                }
                    break;
                case 1:
                {
                    weakself.authModel.oooTwoClassifyId = [resultM.key longLongValue];
                }
                    break;
                default:
                    break;
            }
            
        }
        ///更新用户信息
        [weakself updateInfo];
    };
    
    [pickerV showLinkageStringPicker:selectIndexs numberOfComponents:num stringArr:sourceArr];
    _pickerView = pickerV;
    
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
//更新用户信息
- (void)updateInfo{
    kWeakSelf(self);
    if (self.type == 14 || self.type == 15) {//视频语音通话
        int64_t starPriceId = 0;
        int liveType = 0;
        if (self.type == 14) {//视频
            starPriceId = self.O2OCallPriceId;
            liveType = 1;
        }else{
            starPriceId = self.O2OCallPriceId;
            liveType = 2;
        }
        [HttpApiOOOLive setPayCallOneVsOnePrice:starPriceId type:liveType callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.callBack(YES, self.authModel);
                [weakself.pickerView dismiss];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    } else{
        [HttpApiAnchorAuthenticationController authUpdate:self.authModel callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.callBack(YES, self.authModel);
                [weakself.pickerView dismiss];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
#pragma mark - invoke
//生日
- (void)invokeBirthdayPicke{
    kWeakSelf(self);
    CustomDataPickerView *dataPicker = [[CustomDataPickerView alloc] init];
    dataPicker.showTitle = self.title;
    [dataPicker showDatePicker:self.authModel.birthday limit:self.limit dateFormatter:@"yyyy-MM-dd"];
    dataPicker.doneBlock = ^(NSDate * _Nonnull selectDate) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *brithday = [selectDate timeStringWithDateFormat:@"yyyy-MM-dd"];
            weakself.authModel.birthday = brithday;
            NSArray *dataArr = [brithday componentsSeparatedByString:@"-"];
            int mounth = [dataArr[1] intValue];
            int day = [dataArr[2] intValue];
            NSString *constellation = [self getAstroWithMonth:mounth day:day];
            weakself.authModel.constellation = constellation;
            ///更新用户信息
            [weakself updateInfo];
        });
        
    };
    _pickerView = dataPicker;
}

//身高
- (void)invokeUserHeight{
    NSInteger selectedIndex = 0;
    NSMutableArray *sourceArr = [NSMutableArray array];
    NSInteger userHeight = 170;
    if (self.authModel.height > 0) {
        userHeight = self.authModel.height;
    }
    for (int i = 150; i <= 200; i++) {
        [sourceArr addObject:[NSString stringWithFormat:@"%dcm",i]];
        if (i == userHeight) {
            selectedIndex = i-150;
        }
    }
    [self stringPikser:sourceArr selectedIndex:selectedIndex];
}

//体重
- (void)invokeUserWeight{
    NSInteger selectedIndex = 0;
    NSMutableArray *sourceArr = [NSMutableArray array];
    NSInteger userWeight = 50;
    if (self.authModel.height > 0) {
        userWeight = (int)self.authModel.weight;
    }
    for (int i = 40; i <= 100; i++) {
        [sourceArr addObject:[NSString stringWithFormat:@"%dkg",i]];
        if (i == userWeight) {
            selectedIndex = i-40;
        }
    }
    [self stringPikser:sourceArr selectedIndex:selectedIndex];
}
//三围
- (void)invokeUserSanwei{
    NSMutableArray *sourceArr = [NSMutableArray array];
    NSInteger h = 85;
    NSInteger m = 65;
    NSInteger l = 80;
    if (self.authModel.sanwei.length > 0) {
        NSArray *sanweiArr = [self.authModel.sanwei componentsSeparatedByString:@","];
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
}
//查微信号
- (void)invokeWechatNo{
    NSInteger selectedIndex = 0;
    NSMutableArray *sourceArr = [NSMutableArray array];
    for (int i = 0; i < self.authModel.wechatPriceList.count; i++) {
        StarPriceDOModel *mod = self.authModel.wechatPriceList[i];
        if (mod.price == self.authModel.wechatPrice) {
            selectedIndex = i;
        }
        [sourceArr addObject:[NSString stringWithFormat:@"%d%@",(int)mod.price,[KLCAppConfig unitStr]]];
    }
    [self stringPikser:sourceArr selectedIndex:selectedIndex];
}
//视频接听收费
- (void)invokeVideoFee{
    NSInteger selectedIndex = 0;
    NSMutableArray *sourceArr = [NSMutableArray array];
    for (int i = 0; i < self.authModel.videoPriceList.count; i++) {
        StarPriceDOModel *mod = self.authModel.videoPriceList[i];
        if (mod.price == self.authModel.payCall.videoCoin) {
            selectedIndex = i;
        }
        [sourceArr addObject:[NSString stringWithFormat:kLocalizationMsg(@"%d%@/分钟"),(int)mod.price,[KLCAppConfig unitStr]]];
    }
    [self o2oFeeSetPicket:sourceArr selectedIndex:selectedIndex];
}

//语音接听收费
- (void)invokeVoiceFee{
    NSInteger selectedIndex = 0;
    NSMutableArray *sourceArr = [NSMutableArray array];
    for (int i = 0; i < self.authModel.voicePriceList.count; i++) {
        StarPriceDOModel *mod = self.authModel.voicePriceList[i];
        if (mod.price == self.authModel.payCall.voiceCoin) {
            selectedIndex = i;
        }
        [sourceArr addObject:[NSString stringWithFormat:kLocalizationMsg(@"%d%@/分钟"),(int)mod.price,[KLCAppConfig unitStr]]];
    }
    [self o2oFeeSetPicket:sourceArr selectedIndex:selectedIndex];
}

//主播分类
- (void)invokeAnchorCategory{
    ///数据源
    NSMutableArray *sourceArr = [NSMutableArray arrayWithCapacity:1];
    
    NSInteger selectOneIndex = 0;
    NSInteger selectTowIndex = 0;
    ///是否有二级分类
    __block BOOL hasTwoClassfiyList = NO;
    [self.authModel.oooOneClassifyList enumerateObjectsUsingBlock:^(AppLiveChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.oooTwoClassifyVOList.count > 0) {
            hasTwoClassfiyList = YES;
            *stop = YES;
        }
    }];
    
    for (int i = 0; i < self.authModel.oooOneClassifyList.count; i++) {
        AppLiveChannelModel *mod = self.authModel.oooOneClassifyList[i];
        BRResultModel *model = [[BRResultModel alloc]init];
        model.parentKey = @"-1";
        model.parentValue = @"";
        model.key = kStringFormat(@"%lld",mod.id_field);
        model.value = mod.title;
        model.remark = @"0";
        [sourceArr addObject:model];
        if (mod.id_field == self.authModel.oooOneClassifyId) {
            selectOneIndex = i;
        }
        
        if (mod.oooTwoClassifyVOList.count > 0) {
            ///二级分类
            for (int j = 0; j < mod.oooTwoClassifyVOList.count; j++) {
                OooTwoClassifyVOModel *twoMod = mod.oooTwoClassifyVOList[j];
                BRResultModel *subModel = [[BRResultModel alloc]init];
                subModel.parentKey = model.key;
                subModel.parentValue = model.value;
                subModel.key = kStringFormat(@"%lld",twoMod.id_field);
                subModel.value = twoMod.oooTowTypeName;
                subModel.remark = @"1";
                [sourceArr addObject:subModel];
                if (twoMod.id_field == self.authModel.oooTwoClassifyId) {
                    selectTowIndex = j;
                }
            }
        }else{
            ///该分类下没有二级数据，但是其他类型有二级数据
            if (hasTwoClassfiyList) {
                BRResultModel *subModel = [[BRResultModel alloc]init];
                subModel.parentKey = model.key;
                subModel.parentValue = model.value;
                subModel.key = @"-99";
                subModel.value = kLocalizationMsg(@"无");
                subModel.remark = @"1";
                [sourceArr addObject:subModel];
            }
        }
    }
    [self userLevelPicket:sourceArr num:hasTwoClassfiyList?2:1 selectedIndex:@[@(selectOneIndex),@(selectTowIndex)]];
}
@end
