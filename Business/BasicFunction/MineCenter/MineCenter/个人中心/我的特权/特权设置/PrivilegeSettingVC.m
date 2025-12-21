//
//  PrivilegeSettingVC.m
//  MineCenter
//
//  Created by ssssssss on 2020/8/19.
//

#import "PrivilegeSettingVC.h"
#import <LibProjView/ForceAlertController.h>
#import "PrivilegeSettingTableViewCell.h"
#import <LibProjModel/HttpApiNobleController.h>

@interface PrivilegeSettingVC ()<UITableViewDelegate,UITableViewDataSource,PrivilegeSettingTableViewCellDelegate
>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *dataArray;

@property (nonatomic, strong)PrivilegeShowInfoModel *privilegeInfoM;

@end

@implementation PrivilegeSettingVC

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSettingData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"特权设置");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}


- (void)getSettingData{
    kWeakSelf(self);
    [HttpApiNobleController getPrivilegeShowInfo:^(int code, NSString *strMsg, PrivilegeShowInfoModel *model) {
        if (code == 1) {
            weakself.privilegeInfoM = model;
            [weakself showPrivilegenInfoData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        
    }];
}

///显示特权
- (void)showPrivilegenInfoData{
    
    NSArray *titles = [[ProjConfig shareInstence].businessConfig getPrivilegeSettingTitleArray];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *sectionDic in titles) {
        
        BOOL hasPrivilegen = NO;
        
        switch ([sectionDic[@"section"] intValue]) {
            case 0: ///隐身特权
            {   hasPrivilegen = self.privilegeInfoM.stealthPrivileges>0?YES:NO;  }
                break;
            case 1: ///全站广播
            {   hasPrivilegen = self.privilegeInfoM.totalStation>0?YES:NO;  }
                break;
            default:
                break;
        }
        
        ///有该项特权
        if (hasPrivilegen) {
            PrivilegeSettingSectionModel *sectionModel = [[PrivilegeSettingSectionModel alloc]init];
            NSString *title = sectionDic[@"title"];
            int section = [sectionDic[@"section"] intValue];
            NSArray *list = sectionDic[@"list"];
            sectionModel.title = title;
            sectionModel.section = section;
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in list) {
                int openStatus = 0;
                switch ([dic[@"tag"] intValue]) {
                    case 101: ///贡献榜设置
                    {
                        openStatus = self.privilegeInfoM.devoteShow;
                    }
                        break;
                    case 102: ///进入直播间隐身
                    {
                        openStatus = self.privilegeInfoM.joinRoomShow;
                    }
                        break;
                    case 103: ///充值隐身
                    {
                        openStatus = self.privilegeInfoM.chargeShow;
                    }
                        break;
                    case 201: ///直播间发消息全站广播
                    {
                        openStatus = self.privilegeInfoM.broadCast;
                    }
                        break;
                    default:
                        break;
                }
                if (hasPrivilegen) {
                    PrivilegeSettingModel *model = [[PrivilegeSettingModel alloc]init];
                    model.tag = [dic[@"tag"] intValue];
                    model.openStatus = openStatus;
                    model.title = dic[@"title"];
                    model.type = [dic[@"type"] intValue];
                    model.tip = dic[@"tip"];
                    model.section = sectionModel.section;
                    [arr addObject:model];
                }
            }
            sectionModel.titleArray = arr;
            [tempArr addObject:sectionModel];
        }
    }
    self.dataArray = [NSArray arrayWithArray:tempArr];
    
    [self.tableView reloadData];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < self.dataArray.count) {
        PrivilegeSettingSectionModel *sectionModel = self.dataArray[section];
        return sectionModel.titleArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PrivilegeSettingTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PrivilegeSettingSectionModel *sectionModel;
    
    if (indexPath.section < self.dataArray.count) {
        sectionModel = self.dataArray[indexPath.section];
    }
    PrivilegeSettingModel *model;
    if (sectionModel && indexPath.row < sectionModel.titleArray.count) {
        model = sectionModel.titleArray[indexPath.row];
    }
    if (!cell) {
        cell = [[PrivilegeSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrivilegeSettingTableViewCell"];
    }
    
    if (indexPath.row == sectionModel.titleArray.count-1) {
        cell.lastOne = YES;
    }else{
        cell.lastOne = NO;
    }
    
    cell.delegate = self;
    if (model) {
        cell.model = model;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PrivilegeSettingSectionModel *sectionModel;
    if (section < self.dataArray.count) {
        sectionModel = self.dataArray[section];
    }
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    header.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth-24, 20)];
    tipL.textColor = kRGB_COLOR(@"#999999");
    tipL.font = [UIFont systemFontOfSize:13];
    tipL.textAlignment = NSTextAlignmentLeft;
    if (sectionModel) {
        tipL.text = sectionModel.title;
    }
    [header addSubview:tipL];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


#pragma mark - PrivilegeSettingTableViewCellDelegate
- (void)PrivilegeSettingTableViewCell:(PrivilegeSettingTableViewCell *)cell swithBarValueChange:(BOOL)openStatus{
    
    ///隐身特权
    if (cell.model.section == 0 && self.privilegeInfoM.stealthPrivileges == 1) {
        [SVProgressHUD showInfoWithStatus:self.privilegeInfoM.stealthLowesGradeName];
        [self.tableView reloadData];
        return;
    }
    
    ///全站广播
    if (cell.model.section == 1 && self.privilegeInfoM.totalStation == 1) {
        [SVProgressHUD showInfoWithStatus:self.privilegeInfoM.stationLowesGradeName];
        [self.tableView reloadData];
        return;
    }
    
    BOOL isTip = NO;
    if (cell.model.type == 1 && openStatus) {
        isTip = YES;
    }
    if (cell.model.type == 0 && !openStatus) {
        isTip = YES;
    }
    kWeakSelf(self);
    if (isTip) {
        ForceAlertController *alertVC = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:cell.model.tip];
        [alertVC addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:^{
            [weakself.tableView reloadData];
        }];
        [alertVC addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
            [weakself swithDoWith:cell.model status:openStatus];
        }];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
        [self swithDoWith:cell.model status:openStatus];
    }
}

- (void)swithDoWith:(PrivilegeSettingModel*)settingModel status:(BOOL)openStatus{
    [self setUserPrivilege:settingModel.tag openStatus:openStatus];
}


///设置用户等级
- (void)setUserPrivilege:(int)changeType openStatus:(BOOL)openStatus{
    
    ///先设置基本数据
    int broadCast = self.privilegeInfoM.broadCast;
    int chargeShow = self.privilegeInfoM.chargeShow;
    int devoteShow = self.privilegeInfoM.devoteShow;
    int joinRoomShow = self.privilegeInfoM.joinRoomShow;
    
    ///再设置修改数据
    switch (changeType) {
        case 101:{//贡献榜设置
            devoteShow = openStatus;
        }
            break;
        case 102:{//清进入直播间隐身
            joinRoomShow = openStatus;
        }
            break;
        case 103:{//充值隐身
            chargeShow = openStatus;
        }
            break;
        case 201:{//广播设置
            broadCast = openStatus;
        }
            break;
        default:
            break;
    }
    kWeakSelf(self);
    [HttpApiNobleController upPrivilegeShowInfo:broadCast chargeShow:chargeShow devoteShow:devoteShow joinRoomShow:joinRoomShow callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself getSettingData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark - lazy load
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        if (kiOS(15.0)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

@end
