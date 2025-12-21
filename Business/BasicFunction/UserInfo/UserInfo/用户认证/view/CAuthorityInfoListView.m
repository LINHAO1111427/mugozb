//
//  CAuthorityInfoListView.m
//  MineCenter
//
//  Created by ssssssss on 2020/11/27.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CAuthorityInfoListView.h"
#import "UserInfoEditTableHeader.h"

#import "CAuthorityInfoFooter.h"
#import "CAuthorityVideoRecordVc.h"
#import "CAuthorityUploadPhotoVc.h"
#import "CAuthorityInfoPickerObj.h"
#import "CAuthorityUserInfoInputVc.h"
#import "CAuthorityMarkSlectedVc.h"

#import <LibProjModel/KLCAppConfig.h>
#import "LibProjModel/AnchorAuthVOModel.h"
#import "LibProjModel/AnchorAuthDOModel.h"
#import "LibProjModel/PayCallOneVsOneDOModel.h"
#import "LibProjModel/HttpApiAnchorAuthenticationController.h"
#import <LibProjModel/AppLiveChannelModel.h>
#import <LibProjModel/OooTwoClassifyVOModel.h>

#import "UserInfoGroupDetailView.h"


@interface CAuthorityInfoListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *authorityTable;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)AnchorAuthVOModel *authModel;
@property (nonatomic, strong)UserInfoEditTableHeader *tableHeader;//头部
@property (nonatomic, strong)CAuthorityInfoFooter *tableFooter;//尾部
@property (nonatomic, strong)UIButton *submitBtn;// 提交按钮

@property (nonatomic, copy)CAuthorityInfoPickerObj *pickerObj;

@end
@implementation CAuthorityInfoListView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [self getAuthorityInfo];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.authorityTable];
    [self addSubview:self.submitBtn];
}

- (void)setSuperVc:(UIViewController *)superVc{
    _superVc =  superVc;
    _tableHeader.superVc = superVc;
}

//获取认证所需要的必要信息
- (void)getAuthorityInfo{
    kWeakSelf(self);
    [HttpApiAnchorAuthenticationController authInfo:^(int code, NSString *strMsg, AnchorAuthVOModel *model) {
        if (code == 1) {
            weakself.authModel = model;
            [weakself dealWithData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)dealWithData{
    [self.dataArray removeAllObjects];
    ///1.基本信息
    EditUserListSectionModel *section0 = [[EditUserListSectionModel alloc]init];
    section0.title = kLocalizationMsg(@"基本信息");
    __block NSMutableArray *baseInfoArr = [NSMutableArray array];
    //昵称
    [self isContain:@"nickname" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 0;
            model.title = doModel.name;
            model.content = self.authModel.nickName;
            model.placeHolder = kLocalizationMsg(@"请输入您的昵称");
            [baseInfoArr addObject:model];
        }
    }];
    //个性签名
    [self isContain:@"signature" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 1;
            model.title = doModel.name;
            model.content = self.authModel.signature;
            model.placeHolder = kLocalizationMsg(@"请输入您的签名");
            [baseInfoArr addObject:model];
        }
    }];
    
    //生日星座
    [self isContain:@"birthday" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model1 = [[EditUserInfoListModel alloc]init];
            model1.isReauired = doModel.isRequired;
            model1.type = 2;
            model1.title = doModel.name;
            model1.content = self.authModel.birthday;
            model1.placeHolder = kLocalizationMsg(@"请选择您的生日");
            [baseInfoArr addObject:model1];
            
            EditUserInfoListModel *model2 = [[EditUserInfoListModel alloc]init];
            model2.isReauired = doModel.isRequired;
            model2.type = 3;
            model2.title = kLocalizationMsg(@"星座");
            model2.content = self.authModel.constellation;
            model2.placeHolder = kLocalizationMsg(@"请选择生日");
            [baseInfoArr addObject:model2];
        }
    }];
    //职业
    [self isContain:@"vocation" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 4;
            model.title = doModel.name;
            model.content = self.authModel.vocation;
            model.placeHolder = kLocalizationMsg(@"请输入您的职业");
            [baseInfoArr addObject:model];
        }
    }];
    
    //身高
    [self isContain:@"height" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 5;
            model.title = doModel.name;
            model.content = [NSString stringWithFormat:@"%dcm",self.authModel.height];
            model.placeHolder = kLocalizationMsg(@"请选择您的身高");
            [baseInfoArr addObject:model];
        }
    }];
    
    //体重
    [self isContain:@"weight" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 6;
            model.title = doModel.name;
            model.content = [NSString stringWithFormat:@"%dkg",(int)self.authModel.weight];
            model.placeHolder = kLocalizationMsg(@"请选择您的体重");
            [baseInfoArr addObject:model];
        }
    }];
    //三围
    [self isContain:@"sanwei" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 7;
            model.title = doModel.name;
            model.content = self.authModel.sanwei;
            model.placeHolder = kLocalizationMsg(@"请选择您的三围");
            [baseInfoArr addObject:model];
        }
    }];
    section0.list = baseInfoArr;
    if (baseInfoArr.count > 0) {
        [self.dataArray addObject:section0];
    }
    
    ///2.联系信息
    EditUserListSectionModel *section1 = [[EditUserListSectionModel alloc]init];
    section1.title = kLocalizationMsg(@"联系信息");
    NSMutableArray *contactArr = [NSMutableArray array];
    [self isContain:@"wechat" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model1 = [[EditUserInfoListModel alloc]init];
            model1.isReauired = doModel.isRequired;
            model1.type = 8;
            model1.title = doModel.name;
            model1.content = self.authModel.wechat;
            model1.placeHolder = kLocalizationMsg(@"请输入您的微信号");
            [contactArr addObject:model1];
            
            EditUserInfoListModel *model2 = [[EditUserInfoListModel alloc]init];
            model2.isReauired = doModel.isRequired;
            model2.type = 9;
            model2.title = [NSString stringWithFormat:kLocalizationMsg(@"查看微信号(%@/次)"),[KLCAppConfig unitStr]];
            model2.content = [NSString stringWithFormat:@"%d%@",(int)self.authModel.wechatPrice,[KLCAppConfig unitStr]];
            model2.placeHolder = kLocalizationMsg(@"请选择您的被查看微信号金额");
            [contactArr addObject:model2];
        }
    }];
    section1.list = contactArr;
    if (contactArr.count > 0) {
        [self.dataArray addObject:section1];
    }
    
    ///3.身份信息
    EditUserListSectionModel *section2 = [[EditUserListSectionModel alloc]init];
    section2.title = kLocalizationMsg(@"身份信息");
    NSMutableArray *IdArr = [NSMutableArray array];
    [self isContain:@"realName" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 10;
            model.title = doModel.name;
            model.content = self.authModel.realName;
            model.placeHolder = kLocalizationMsg(@"请输入您的真实姓名");
            [IdArr addObject:model];
        }
    }];
    
    [self isContain:@"cerNo" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 11;
            model.title = doModel.name;
            model.content = self.authModel.cerNo;
            model.placeHolder = kLocalizationMsg(@"请填写您的身份证号");
            [IdArr addObject:model];
        }
    }];
    
    [self isContain:@"IDPhoto" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 12;
            model.title = doModel.name;
            if (self.authModel.idCardFrontView.length > 0 && self.authModel.idCardBackView.length  > 0 && self.authModel.idCardHandView.length  > 0) {
                model.content = kLocalizationMsg(@"已上传");
            }else{
                model.content = kLocalizationMsg(@"请上传完整证件照");
            }
            model.placeHolder = kLocalizationMsg(@"请上传证件照片");
            [IdArr addObject:model];
        }
    }];
    
    [self isContain:@"videoAuth" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
        if (isContain) {
            EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
            model.isReauired = doModel.isRequired;
            model.type = 13;
            model.title = doModel.name;
            model.content = self.authModel.videoAuth.length == 0?kLocalizationMsg(@"去视频认证"):kLocalizationMsg(@"已上传");
            model.placeHolder = kLocalizationMsg(@"请上传视频认证");
            [IdArr addObject:model];
        }
    }];
    section2.list = IdArr;
    if (IdArr.count > 0) {
        [self.dataArray addObject:section2];
    }
    
    ///4.通话设置
    if ([ProjConfig isContain1v1]) {//包含1v1
        EditUserListSectionModel *section3 = [[EditUserListSectionModel alloc]init];
        section3.title = kLocalizationMsg(@"通话设置");
        
        __block NSMutableArray *callArr = [NSMutableArray array];

        [self isContain:@"anchorClassfiy" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
            if (isContain) {
                EditUserInfoListModel *model1 = [[EditUserInfoListModel alloc]init];
                model1.isReauired = YES;
                model1.type = 31;
                model1.title = kLocalizationMsg(@"主播分类");
                
                __block NSString *showStr = @"";
                if (self.authModel.oooOneClassifyId > 0) {
                    [self.authModel.oooOneClassifyList enumerateObjectsUsingBlock:^(AppLiveChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (obj.id_field == self.authModel.oooOneClassifyId) {
                            showStr = obj.title;
                            [obj.oooTwoClassifyVOList enumerateObjectsUsingBlock:^(OooTwoClassifyVOModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                if (obj.id_field == self.authModel.oooTwoClassifyId) {
                                    showStr = [showStr stringByAppendingFormat:@" %@",obj.oooTowTypeName];
                                    *stop = YES;
                                }
                            }];
                            *stop = YES;
                        }
                    }];
                }
                
                model1.content = showStr.length > 0 ? showStr:kLocalizationMsg(@"请设置主播分类");
                model1.placeHolder = kLocalizationMsg(@"请设置主播分类");
                [callArr addObject:model1];
            }
        }];
        
        [self isContain:@"otoVideoFee" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
            if (isContain) {
                EditUserInfoListModel *modelV = [[EditUserInfoListModel alloc]init];
                modelV.isReauired = YES;
                modelV.type = 14;
                modelV.title = kLocalizationMsg(@"视频接听收费");
                modelV.content = [NSString stringWithFormat:kLocalizationMsg(@"%d%@/分钟"),(int)self.authModel.payCall.videoCoin,[KLCAppConfig unitStr]];
                modelV.placeHolder = kLocalizationMsg(@"请设置您的视频接听收费");
                [callArr addObject:modelV];
            }
        }];
        
        [self isContain:@"otoAudioFee" callBack:^(BOOL isContain, AnchorAuthDOModel *doModel) {
            if (isContain) {
                EditUserInfoListModel *modelA = [[EditUserInfoListModel alloc]init];
                modelA.isReauired = YES;
                modelA.type = 15;
                modelA.title = kLocalizationMsg(@"语音接听收费");
                modelA.content = [NSString stringWithFormat:kLocalizationMsg(@"%d%@/分钟"),(int)self.authModel.payCall.voiceCoin,[KLCAppConfig unitStr]];
                modelA.placeHolder = kLocalizationMsg(@"请设置您的语音接听收费");
                [callArr addObject:modelA];
            }
        }];
        section3.list = callArr;
        if (callArr.count > 0) {
            [self.dataArray addObject:section3];
        }
    }
    
    ///5.形象设置
    if ([ProjConfig isContain1v1]) {//包含1v1
        EditUserListSectionModel *section4 = [[EditUserListSectionModel alloc]init];
        section4.title = kLocalizationMsg(@"形象设置");
        NSMutableArray *faceArr = [NSMutableArray array];
        EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
        model.isReauired = YES;
        model.type = 16;
        model.title = kLocalizationMsg(@"形象展示");
        if (self.authModel.payCall.poster.length > 0) {
            model.content = kLocalizationMsg(@"已上传");
        }else{
            model.content = kLocalizationMsg(@"去上传形象照片");
        }
        model.placeHolder = kLocalizationMsg(@"请进行完整形象设置");
        [faceArr addObject:model];
        section4.list = faceArr;
        [self.dataArray addObject:section4];
    }
    
    
    ///6.其他信息
    EditUserListSectionModel *section5 = [[EditUserListSectionModel alloc]init];
    section5.title = kLocalizationMsg(@"其他信息");
    NSMutableArray *otherInfoArr = [NSMutableArray array];
    EditUserInfoListModel *modelOther = [[EditUserInfoListModel alloc]init];
    modelOther.isReauired = NO;
    modelOther.type = 17;
    modelOther.title = kLocalizationMsg(@"附加信息");
    modelOther.content = self.authModel.remarks;
    modelOther.placeHolder = kLocalizationMsg(@"请填写附加信息");
    [otherInfoArr addObject:modelOther];
    
    EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
    model.isReauired = NO;
    model.type = 18;
    model.title = kLocalizationMsg(@"兴趣标签");
    if (self.authModel.interestList.count == 0) {
        model.content = kLocalizationMsg(@"选择兴趣标签");
    }else{
        model.content = @"";
    }
    [otherInfoArr addObject:model];
    
    section5.list = otherInfoArr;
    if (otherInfoArr.count > 0) {
        [self.dataArray addObject:section5];
    }
    
    ///刷新
    [self.authorityTable reloadData];
    
    ///更兴趣标签
    CGFloat height = 60+kSafeAreaBottom;
    if (self.authModel.interestList.count > 0) {
        height += (self.authModel.interestList.count/4+1)*40;
    }
    self.tableFooter.height = height;
    self.tableFooter.myMarkArr = self.authModel.myInterestList;
    self.authorityTable.tableFooterView = self.tableFooter;
}


- (void)isContain:(NSString *)identification callBack:(void(^)(BOOL isContain,AnchorAuthDOModel *doModel))callBack{
    if ([identification isEqualToString:@"otoVideoFee"]) {
        callBack(([[ProjConfig shareInstence].baseConfig getOtoType] == 1 || [[ProjConfig shareInstence].baseConfig getOtoType] == 0)?YES:NO, nil);
    }else if ([identification isEqualToString:@"otoAudioFee"]){
        callBack(([[ProjConfig shareInstence].baseConfig getOtoType] == 2 || [[ProjConfig shareInstence].baseConfig getOtoType] == 0)?YES:NO, nil);
    }else if ([identification isEqualToString:@"anchorClassfiy"]){
        callBack([[ProjConfig shareInstence].baseConfig userSelectAnchorClassfiy], nil);
    }else{
        for (AnchorAuthDOModel *model in self.authModel.auchorAuthShowList) {
            if ([model.identification isEqual:identification]) {
                if (model.isShow) {
                    callBack(YES,model);
                }else{
                    callBack(NO,model);
                }
                return;
            }
        }
        callBack(NO,nil);
    }
}


#pragma mark - 提交审核
- (void)submitCheckCallBack:(void(^)(BOOL canSubmit))callBack{
    BOOL canSubMit = YES;
    for (EditUserListSectionModel *section in self.dataArray) {
        for (EditUserInfoListModel *model in section.list) {
            if (model.isReauired) {
                BOOL isFinish = [self isFinish:model.type];
                if (!isFinish) {
                    canSubMit = NO;
                    [SVProgressHUD showInfoWithStatus:model.placeHolder];
                    break;
                }
            }
        }
        if (!canSubMit) {
            break;
        }
    }
    callBack(canSubMit);
}

- (BOOL)isFinish:(int)type{
    switch (type) {
        case 0:{//昵称
            if (self.authModel.nickName.length == 0) {
                return NO;
            }
        }
            break;
        case 1:{//个性签名
            if (self.authModel.signature.length == 0) {
                return NO;
            }
        }
            break;
        case 4:{//职业
            if (self.authModel.vocation.length == 0) {
                return NO;
            }
        }
            break;
        case 8:{//微号
            if (self.authModel.wechat.length == 0) {
                return NO;
            }
        }
            break;
        case 10:{//真实姓名
            if (self.authModel.realName.length == 0) {
                return NO;
            }
        }
            break;
        case 11:{//身份证号
            if (self.authModel.cerNo.length == 0) {
                return NO;
            }
        }
            break;
        case 17:{//附加信息
            if (self.authModel.remarks.length == 0) {
                return NO;
            }
        }
            break;
        case 2:{//生日
            if (self.authModel.birthday.length == 0) {
                return NO;
            }
        }
            break;
        case 5:{//身高
            if (self.authModel.height == 0) {
                return NO;
            }
        }
            break;
        case 6:{//体重
            if (self.authModel.weight == 0) {
                return NO;
            }
        }
            break;
        case 7:{//三围
            if (self.authModel.sanwei.length == 0) {
                return NO;
            }
        }
            break;
        case 9:{//查看微信号
            if (self.authModel.wechatPrice == 0) {
                return NO;
            }
        }
            break;
        case 14:{//视频接听收费
            if (self.authModel.payCall.videoCoin == 0) {
                return NO;
            }
        }
            break;
        case 15:{//语音接听收费
            if (self.authModel.payCall.voiceCoin == 0) {
                return NO;
            }
        }
            
            break;
        case 12:{//上传证件照
            if (self.authModel.idCardBackView.length == 0 || self.authModel.idCardFrontView.length == 0 || self.authModel.idCardHandView.length == 0) {
                return NO;
            }
        }
            break;
        case 13:{//视频认证
            if (self.authModel.videoAuth.length == 0) {
                return NO;
            }
        }
            break;
        case 16:{//形象展示
            if (self.authModel.payCall.poster.length == 0) {
                return NO;
            }
        }
            break;
        case 31:{//主播分类
            if (self.authModel.oooOneClassifyId == 0) {
                return NO;
            }
        }
            break;
        case 18://兴趣标签
        default:
            return YES;
            break;
    }
    return YES;
}
- (void)submitBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    [self submitCheckCallBack:^(BOOL canSubmit) {
        if (canSubmit) {
            [weakself subMitReviewNow];
        }
    }];
}
- (void)subMitReviewNow{
    kWeakSelf(self);
    [HttpApiAnchorAuthenticationController applyAuth:self.authModel callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"提交审核成功，请耐心等候审核结果")];
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(authenticationSuccess)]) {
                [weakself.delegate authenticationSuccess];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    EditUserListSectionModel *sectionM;
    if (section < self.dataArray.count) {
        sectionM = self.dataArray[section];
    }
    return sectionM.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditUserInfoListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[EditUserInfoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EditUserInfoListCellID"];
    }
    EditUserListSectionModel *sectionM;
    if (indexPath.section < self.dataArray.count) {
        sectionM = self.dataArray[indexPath.section];
    }
    EditUserInfoListModel *model;
    if (indexPath.row < sectionM.list.count) {
        model = sectionM.list[indexPath.row];
    }
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [EditUserInfoListCell cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UserInfoGroupTitleView viewHeight]+10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [UserInfoGroupTitleView viewHeight]+10)];
    UserInfoGroupTitleView *sectionHeader = [[UserInfoGroupTitleView alloc] initWithFrame:CGRectMake(0, 5, bgV.width, [UserInfoGroupTitleView viewHeight])];
    [bgV addSubview:sectionHeader];
    EditUserListSectionModel *sectionM;
    if (section < self.dataArray.count) {
        sectionM = self.dataArray[section];
    }
    sectionHeader.sectionL.text = sectionM.title;
    return bgV;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self selectedIndex:indexPath];
}
- (void)selectedIndex:(NSIndexPath*)indexPath{
    EditUserListSectionModel *sectionM;
    if (indexPath.section < self.dataArray.count) {
        sectionM = self.dataArray[indexPath.section];
    }
    EditUserInfoListModel *model;
    if (indexPath.row < sectionM.list.count) {
        model = sectionM.list[indexPath.row];
    }
    kWeakSelf(self);
    switch (model.type) {
            ///填写
        case 0://昵称
        case 1://个性签名
        case 4://职业
        case 8://微号
        case 10://真实姓名
        case 11://身份证号
        case 17:{//附加信息
            CAuthorityUserInfoInputVc *inputVc = [[CAuthorityUserInfoInputVc alloc]init];
            inputVc.authModel = self.authModel;
            inputVc.titleStr = model.title;
            inputVc.placeholder = model.placeHolder;
            inputVc.index = model.type;
            inputVc.completeBlock = ^(AnchorAuthVOModel * _Nonnull authModel) {
                if (authModel) {
                    weakself.authModel = authModel;
                    [weakself dealWithData];
                }
            };
            [self.superVc.navigationController pushViewController:inputVc animated:YES];
        }
            break;
            
            ///选项
        case 2://生日
        case 3://生日
        case 5://身高
        case 6://体重
        case 7://三围
        case 9://查看微信号
        case 31://主播分类
        case 14://视频接听收费
        case 15:{//语音接听收费
            [self.pickerObj showInfoPickerWithType:model.type limit:model.limit model:self.authModel title:model.placeHolder callBack:^(BOOL isSure, AnchorAuthVOModel * _Nonnull authModel) {
                if (isSure && authModel) {
                    weakself.authModel = authModel;
                    [weakself dealWithData];
                    weakself.pickerObj = nil;
                }
            }];
        }
            
            break;
        case 12:{//上传证件照
            CAuthorityUploadPhotoVc *photoVc = [[CAuthorityUploadPhotoVc alloc]initWith:self.authModel];
            photoVc.titleStr = model.title;
            photoVc.completeCallBack = ^(AnchorAuthVOModel * _Nonnull authModel) {
                if (authModel) {
                    weakself.authModel = authModel;
                    [weakself dealWithData];
                }
            };
            [self.superVc.navigationController pushViewController:photoVc animated:YES];
        }
            break;
        case 13:{//视频认证
            CAuthorityVideoRecordVc *recordVc = [[CAuthorityVideoRecordVc alloc]initWith:self.authModel];
            recordVc.completionBlock = ^(AnchorAuthVOModel * _Nonnull authModel) {
                if (authModel) {
                    weakself.authModel = authModel;
                    [weakself dealWithData];
                }
            };
            [self.superVc.navigationController pushViewController:recordVc animated:YES];
        }
            break;
        case 16:{//形象展示
            kWeakSelf(self);
            void(^settingBlock)(NSString *, NSString *, NSString *) = ^ (NSString * _Nullable videoUrl, NSString * _Nullable voiceUrl, NSString * _Nullable poster){
                weakself.authModel.payCall.video = videoUrl;
                weakself.authModel.payCall.poster = poster;
                weakself.authModel.payCall.voice = voiceUrl;
                [weakself updateInfo];
            };
            [RouteManager routeForName:RN_activity_OBOCallSettingAC currentC:self.superVc parameters:@{@"settingBlock":settingBlock}];
        }
            break;
        case 18:{//兴趣标签
            CAuthorityMarkSlectedVc *markVc = [[CAuthorityMarkSlectedVc alloc]init];
            markVc.myMarkArr = [NSMutableArray arrayWithArray:self.authModel.myInterestList];
            markVc.completeBlock = ^(NSMutableArray * _Nonnull interstArr) {
                if (interstArr.count > 0) {
                    weakself.authModel.myInterestList = interstArr;
                    [weakself updateInfo];
                }
            };
            [self.superVc.navigationController pushViewController:markVc animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)updateInfo{
    if (self.authModel) {
        kWeakSelf(self);
        [HttpApiAnchorAuthenticationController authUpdate:self.authModel callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself dealWithData];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}
#pragma mark - lazy
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (CAuthorityInfoPickerObj *)pickerObj{
    if (!_pickerObj) {
        _pickerObj = [[CAuthorityInfoPickerObj alloc] init];
    }
    return _pickerObj;
}

- (UITableView *)authorityTable{
    if (!_authorityTable) {
        _authorityTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _authorityTable.delegate = self;
        _authorityTable.dataSource = self;
        _authorityTable.estimatedRowHeight = 0.0;
        _authorityTable.estimatedSectionFooterHeight = 0.0;
        _authorityTable.estimatedSectionHeaderHeight = 0.0;
        _authorityTable.sectionHeaderHeight = 0.0;
        _authorityTable.sectionFooterHeight = 0.0;
        if (@available(iOS 11.0, *)) {
            _authorityTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _authorityTable.tableHeaderView = self.tableHeader;
        _authorityTable.backgroundColor = [UIColor whiteColor];
        _authorityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _authorityTable;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height-60-kSafeAreaBottom, 150, 40)];
        _submitBtn.centerX = kScreenWidth/2.0;
        [_submitBtn setBackgroundImage:[UIImage createImageSize:_submitBtn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.layer.cornerRadius = 20;
        _submitBtn.clipsToBounds = YES;
        _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_submitBtn setTitle:kLocalizationMsg(@"提交认证") forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitBtn;
}

- (UserInfoEditTableHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[UserInfoEditTableHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
        _tableHeader.backgroundColor = [UIColor whiteColor];
    }
    return _tableHeader;
}
- (CAuthorityInfoFooter *)tableFooter{
    if (!_tableFooter) {
        _tableFooter = [[CAuthorityInfoFooter alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _tableFooter.backgroundColor = [UIColor whiteColor];
    }
    return _tableFooter;
}
@end
