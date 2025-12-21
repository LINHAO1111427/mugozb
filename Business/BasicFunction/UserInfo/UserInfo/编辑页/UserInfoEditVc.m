//
//  UserInfoEditeVc.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoEditVc.h"

#import "UserInfoEditeInputVc.h"
#import "UserInfoEditPickerObj.h"
#import "UserEditMarkSelectedVc.h"
#import "UserInfoEditTableHeader.h"
#import "UserInfoEditTableFooter.h"
#import "UserInfoGroupDetailView.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/UserInfo2VOModel.h>


@interface UserInfoEditVc ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *userEditTable;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UserInfo2VOModel *userDetailM;
@property (nonatomic, strong)ApiUserInfoModel *userModel;
@property (nonatomic, strong)UserInfoEditTableHeader *tableHeader;//头部
@property (nonatomic, strong)UserInfoEditTableFooter *tableFooter;//尾部

@property (nonatomic, copy)UserInfoEditPickerObj *pickerObj;


@end

@implementation UserInfoEditVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"编辑资料");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userEditTable];
    [self getUserInfoData];
}
 
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     
}
- (void)getUserInfoData{
    kWeakSelf(self);
    [HttpApiUserController getUserInfo2:[ProjConfig userId] callback:^(int code, NSString *strMsg, UserInfo2VOModel *model) {
        if (code == 1) {
            weakself.userModel = model.userInfo;
            weakself.userDetailM = model;
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
    
    NSArray *baseTitleArray = [[ProjConfig shareInstence].businessConfig getEditProfileBaseArray];
    __block NSMutableArray *baseInfoArr = [NSMutableArray array];
    for (NSDictionary *dic in baseTitleArray) {
        NSString *title = dic[@"title"];
        NSString *placeholder = dic[@"placeholder"];
        int type = [dic[@"type"] intValue]-100;
        EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
        model.type = type;
        model.title = title;
        model.placeHolder = placeholder;
        if (type == 0) {
            model.content = self.userModel.username;
        }else if(type == 1){
            model.content = self.userModel.signature;
        }else if(type == 2){
            model.limit = [dic[@"limit"] intValue];
            model.content = self.userModel.birthday;
        }else if(type == 3){
            model.content = self.userModel.constellation;
        }else if(type == 4){
            model.content = self.userModel.vocation;
        }else if(type == 5){
            model.content = [NSString stringWithFormat:@"%dcm",self.userModel.height];
        }else if(type == 6){
            model.content = [NSString stringWithFormat:@"%dkg",(int)self.userModel.weight];
        }else if(type == 7){
            if (self.userModel.sex == 2) {
                model.content = self.userModel.sanwei;
            }else{
                continue;//男人没有三维
            }
        }else if(type == 8){
            NSString *text = @"";
            if (self.userModel.sex == 0) {
                text = kLocalizationMsg(@"其他");
            }else if(self.userModel.sex == 1){
                text = kLocalizationMsg(@"男");
            }else if(self.userModel.sex == 2){
                text = kLocalizationMsg(@"女");
            }
            model.content = text;
        }
        [baseInfoArr addObject:model];
         
    }
     
    section0.list = baseInfoArr;
    if (baseInfoArr.count > 0) {
        [self.dataArray addObject:section0];
    }
    
    
    ///6.其他信息
    EditUserListSectionModel *section1 = [[EditUserListSectionModel alloc]init];
    section1.title = kLocalizationMsg(@"其他信息");
    NSMutableArray *otherInfoArr = [NSMutableArray array];
    {
        EditUserInfoListModel *model = [[EditUserInfoListModel alloc]init];
        model.type = 9;
        model.title = kLocalizationMsg(@"兴趣标签");
        if (self.userDetailM.myInterestList.count == 0) {
            model.content = kLocalizationMsg(@"选择兴趣标签");
        }else{
            model.content = @"";
        }
        [otherInfoArr addObject:model];
        
    }
    section1.list = otherInfoArr;
    if (otherInfoArr.count > 0) {
        [self.dataArray addObject:section1];
    }
    
    
    ///刷新
    [self.userEditTable reloadData];
    
    ///更兴趣标签
    CGFloat height = 60+kSafeAreaBottom;
    if (self.userDetailM.myInterestList.count > 0) {
        height += (self.userDetailM.myInterestList.count/4+1)*40;
    }
    self.tableFooter.height = height;
    self.tableFooter.myMarkArr = self.userDetailM.myInterestList;
    self.userEditTable.tableFooterView = self.tableFooter;
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
        case 4:{//职业
            UserInfoEditeInputVc *inputVc = [[UserInfoEditeInputVc alloc]init];
            inputVc.userModel = self.userModel;
            inputVc.titleStr = model.title;
            inputVc.placeholder = model.placeHolder;
            inputVc.index = model.type;
            inputVc.completeBlock = ^(BOOL sucess) {
                if (sucess) {
                    [weakself getUserInfoData];
                }
            };
            [self.navigationController pushViewController:inputVc animated:YES];
        }
            break;
            
        ///选项
        case 2://生日
        case 3://生日
        case 5://身高
        case 6://体重
        case 7://三围
        case 8:{//性别
            [self.pickerObj showInfoPickerWithType:model.type limit:model.limit model:self.userModel title:model.placeHolder callBack:^(BOOL isSure) {
                if (isSure) {
                    [weakself getUserInfoData];
                }
            }];
        }
            break;
         
        case 9:{//兴趣标签
            UserEditMarkSelectedVc *markVc = [[UserEditMarkSelectedVc alloc]init];
            markVc.myMarkArr = [NSMutableArray arrayWithArray:self.userDetailM.myInterestList];
            markVc.completeBlock = ^(NSMutableArray * _Nonnull interstArr) {
                [weakself getUserInfoData];
            };
            [self.navigationController pushViewController:markVc animated:YES];
        }
            break;
        default:
            break;
    }
}
 
#pragma mark - lazy
 
- (UserInfoEditPickerObj *)pickerObj{
    if (!_pickerObj) {
        _pickerObj = [[UserInfoEditPickerObj alloc] init];
    }
    return _pickerObj;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)userEditTable{
    if (!_userEditTable) {
        _userEditTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _userEditTable.delegate = self;
        _userEditTable.dataSource = self;
        _userEditTable.estimatedRowHeight = 0.0;
        _userEditTable.estimatedSectionFooterHeight = 0.0;
        _userEditTable.estimatedSectionHeaderHeight = 0.0;
        _userEditTable.sectionHeaderHeight = 0.0;
        _userEditTable.sectionFooterHeight = 0.0;
        if (@available(iOS 11.0, *)) {
            _userEditTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_userEditTable registerClass:[EditUserInfoListCell class] forCellReuseIdentifier:@"EditUserInfoListCellID"];
        _userEditTable.tableHeaderView = self.tableHeader;
        _userEditTable.backgroundColor = [UIColor whiteColor];
        _userEditTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _userEditTable;
}
 
- (UserInfoEditTableHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[UserInfoEditTableHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
        _tableHeader.backgroundColor = [UIColor whiteColor];
        _tableHeader.superVc = self;
    }
    return _tableHeader;
}

- (UserInfoEditTableFooter *)tableFooter{
    if (!_tableFooter) {
        _tableFooter = [[UserInfoEditTableFooter alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _tableFooter.backgroundColor = [UIColor whiteColor];
    }
    return _tableFooter;
}


@end
