//
//  ChatSetUpVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import "ChatSetUpVC.h"

#import "ChatSetUpCell.h"
#import "SquareGroupMsgMemberVC.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiUserController.h>
#import "ChatSetInfoModel.h"

@interface ChatSetUpVC ()<UITableViewDelegate,UITableViewDataSource,ChatSetUpCellDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray<ChatSetInfoModel *> *showDataArr;

@property (nonatomic,copy)NSArray *baseDataArr;
@end

@implementation ChatSetUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"聊天设置");
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
}

- (NSMutableArray<ChatSetInfoModel *> *)showDataArr{
    if (!_showDataArr) {
        _showDataArr = [[NSMutableArray alloc] init];
    }
    return _showDataArr;
}

-(void)creatSubView{
    ///是群聊
    if (self.chatType > 0) {
        [self getFansGroupData];
    }else{
        NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary *subDic in [[ProjConfig shareInstence].businessConfig getSingleChatSetupArray]) {
            ChatSetInfoModel *model = [[ChatSetInfoModel alloc] init];
            model.title = subDic[@"name"];
            model.typeId = [subDic[@"id"] intValue];
            model.showType = [subDic[@"type"] intValue];
            model.isBlack = NO;
            [muArr addObject:model];
        }
        self.baseDataArr = [muArr copy];
        [self getBlockinfoData];
    }
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ChatSetUpCell class] forCellReuseIdentifier:@"ChatSetUpCellID"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatSetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatSetUpCellID" forIndexPath:indexPath];
    cell.delegate = self;
    cell.infoModel = self.showDataArr[indexPath.row];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChatSetInfoModel *infoModel = self.showDataArr[indexPath.row];
    if (infoModel.typeId == 111) { ///粉丝团
        SquareGroupMsgMemberVC *listVc =  [[SquareGroupMsgMemberVC alloc] init];
        listVc.groupId = self.msgId;
        [self.navigationController pushViewController:listVc animated:YES];
    }
    if (infoModel.typeId == 3) {///备注
        [RouteManager routeForName:RN_user_setUserRemark currentC:self parameters:@{@"id":@(self.msgId),@"remark":infoModel.title.length > 0?infoModel.title:@""}];
    }
    if (infoModel.typeId == 4) {///个人资料
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(self.msgId)}];
    }
    
}


//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



-(void)getBlockinfoData{
    kWeakSelf(self);
    [HttpApiUserController getBlockinfo:self.msgId callback:^(int code, NSString *strMsg, ApiUsersVideoBlackVOModel *model) {
        if (code == 1) {
            NSMutableArray *compareArr = [[NSMutableArray alloc] init];
            for (ChatSetInfoModel *obj in weakself.baseDataArr) {
                if (obj.typeId == 0) {
                    obj.isBlack = model.userBlack;
                    [compareArr addObject:obj];
                }else if (obj.typeId == 1) {
                    if (model.userBlack == 0) {
                        obj.isBlack = model.voiceBlack;
                        [compareArr addObject:obj];
                    }
                }else if (obj.typeId == 2) {
                    if (model.userBlack == 0){
                        obj.isBlack = model.videoBlack;
                        [compareArr addObject:obj];
                    }
                }else{
                    [compareArr addObject:obj];
                }
            }
            [self.showDataArr removeAllObjects];
            [self.showDataArr addObjectsFromArray:compareArr];
            [weakself.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)getFansGroupData{

    NSArray *chatSetupArr =  @[@{@"id":@"111",@"name":kLocalizationMsg(@"查看粉丝团成员"),@"type":@"0"},
    ];
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *subDic in chatSetupArr) {
        ChatSetInfoModel *model = [[ChatSetInfoModel alloc] init];
        model.title = subDic[@"name"];
        model.typeId = [subDic[@"id"] intValue];
        model.showType = [subDic[@"type"] intValue];
        model.isBlack = NO;
        [muArr addObject:model];
    }
    self.baseDataArr = [muArr copy];
    
    [self.showDataArr removeAllObjects];
    [self.showDataArr addObjectsFromArray:self.baseDataArr];
    
    [self.tableView reloadData];
}

-(void)getBlockOperation:(int)type{
    [SVProgressHUD show];
    kWeakSelf(self);
    [HttpApiUserController blockOperation:type userId:self.msgId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            [weakself getBlockinfoData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}

//加入黑名单
-(void)addUsersToBlacklist{
    kWeakSelf(self);
//    [JMSGUser addUsersToBlacklist:@[username] completionHandler:^(id resultObject, NSError *error) {
//        if (error) {
//           // NSLog(@"过滤文字error==%@"),error);
//            [weakself getBlockOperation:0];
//            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"设置失败")];
//        }else{
//            [weakself getBlockinfoData];
//        }
//    }];
}

//取消黑名单
-(void)delUsersFromBlacklist{
    kWeakSelf(self);
//    [JMSGUser delUsersFromBlacklist:@[username] completionHandler:^(id resultObject, NSError *error) {
//        if (error) {
//           // NSLog(@"过滤文字error==%@"),error);
//            [weakself getBlockOperation:0];
//            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"设置失败")];
//        }else{
//            [weakself getBlockinfoData];
//        }
//        
//    }];
}


- (void)clickPullBlack:(BOOL )isOn andType:(int)type{
    if (isOn) {
       // NSLog(@"过滤文字打开"));
    }else {
       // NSLog(@"过滤文字关闭"));
    }
    if (type == 10) { ///分组
        //        JMSGGroup
        kWeakSelf(self);
#warning mark 消息免打扰
//        id target = self.conversation.target;
//        if ([target isKindOfClass:[JMSGGroup class]]) {
//            JMSGGroup *group = (JMSGGroup *)target;
//            [group setIsNoDisturb:isOn handler:^(id resultObject, NSError *error) {
//                if (error) {
//                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"设置失败")];
//                }else{
//                    [weakself getFansGroupData];
//                }
//            }];
//        }
    }else{  ///一对一
        [SVProgressHUD show];
        kWeakSelf(self);
        [HttpApiUserController blockOperation:type userId:self.msgId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            
            if (code == 1) {
                if (type == 0) {
                    ///用户的IM加入黑名单操作
                    if (isOn) {
                        [weakself addUsersToBlacklist];
                    }else{
                        [weakself delUsersFromBlacklist];
                    }
                }
                
                [weakself getBlockinfoData];
                
            }else{
                [weakself.tableView reloadData];
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}




@end
