//
//  MedalListViewController.m
//  UserInfo
//
//  Created by ssssssss on 2020/1/3.
//

#import "MedalListViewController.h"
#import <LibProjModel/AppMedalModel.h>
#import <LibProjModel/HttpApiMedal.h>
#import "MedalTableViewCell.h"

@interface MedalListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)MedalDtoModel *medalModel;
@end

@implementation MedalListViewController
 
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"勋章墙");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    //获取勋章
    [self loadMedalData];
}

- (void)loadMedalData{
    kWeakSelf(self);
    [HttpApiMedal getMyAllMedal:[self.userId longLongValue] callback:^(int code, NSString *strMsg, MedalDtoModel *model) {
        if (code == 1) {
            weakself.medalModel = model;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MedalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell  = [[MedalTableViewCell alloc]initWithIndexPath:indexPath];
    }
    if (indexPath.section == 0) {//已经拥有的勋章
        cell.medalsArr = self.medalModel.myAllMedals;
    }else if (indexPath.section == 1){//未拥有用户勋章
        cell.medalsArr = self.medalModel.noUserMedals;
    }else if (indexPath.section == 2){//未拥有财富勋章
        cell.medalsArr = self.medalModel.noWealthMedals;
    }else if (indexPath.section == 3){//未拥有贵族勋章
        cell.medalsArr = self.medalModel.noNobleMedals;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
         UIView *headeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,40)];
         headeView.backgroundColor = [UIColor whiteColor];
         headeView.backgroundColor = [UIColor whiteColor];
         UILabel *headerL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 40)];
         headerL.textColor =kRGB_COLOR(@"#333333");
         headerL.textAlignment = NSTextAlignmentCenter;
         headerL.font = [UIFont boldSystemFontOfSize:14];
         headerL.text = kLocalizationMsg(@"已拥有的勋章");
         [headeView addSubview:headerL];
         return headeView;
    }else if (section == 1) {
        UIView *headeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,60)];
        headeView.backgroundColor = [UIColor whiteColor];
        UILabel *headerL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 30)];
        headerL.textColor =kRGB_COLOR(@"#333333");
        headerL.textAlignment = NSTextAlignmentCenter;
        headerL.font = [UIFont boldSystemFontOfSize:14];
        headerL.text = kLocalizationMsg(@"未获得的勋章");
        [headeView addSubview:headerL];
        UILabel *subL = [[UILabel alloc]initWithFrame:CGRectMake(12, 30, kScreenWidth-24, 30)];
        subL.textColor =kRGB_COLOR(@"#333333");
        subL.textAlignment = NSTextAlignmentCenter;
        subL.font = [UIFont systemFontOfSize:14];
        subL.text = kLocalizationMsg(@"用户勋章");
        [headeView addSubview:subL];
        return headeView;
    }else{
        UIView *headeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,40)];
        headeView.backgroundColor = [UIColor whiteColor];
        headeView.backgroundColor = [UIColor whiteColor];
        UILabel *headerL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 40)];
        headerL.textColor =kRGB_COLOR(@"#333333");
        headerL.textAlignment = NSTextAlignmentCenter;
        headerL.font = [UIFont systemFontOfSize:14];
        if (section == 2) {
             headerL.text = kLocalizationMsg(@"财富勋章");
        }else{
             headerL.text = kLocalizationMsg(@"贵族勋章");
        }
        [headeView addSubview:headerL];
        return headeView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat scale = 68/51.0;
    CGFloat width =  (kScreenWidth - 24-60)/4.0;
    CGFloat height = width/scale+20;
    NSInteger num;
    if (indexPath.section == 0) {
        num = self.medalModel.myAllMedals.count;
    }else if (indexPath.section == 1){
        num = self.medalModel.noUserMedals.count;
    }else if (indexPath.section == 2){
        num = self.medalModel.noWealthMedals.count;
    }else{
        num = self.medalModel.noNobleMedals.count;
    }
    if (num > 0) {
        NSInteger row = (num-1)/4+1;
        return row*(height+10)+40;
    }else{
       return 140;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 60;
    }else{
        return 40;
    }
}

@end
