//
//  OpenRedPacketResultView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OpenRedPacketResultView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/RedPacketVOModel.h>
#import <LibProjModel/HttpApiRedPacketController.h>
#import <LibProjModel/RedPacketReceiveRecordVOModel.h>
#import <LibProjBase/PopupTool.h>

#pragma mark    - 显示领取红包的结果 -
@interface ShowRedPacketResultView : UIView

@property (nonatomic, weak)UIImageView *userIconV;

@property (nonatomic, weak)UILabel *userNameL;

- (void)showResult:(RedPacketVOModel *)voModel;

@end

@implementation ShowRedPacketResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    ///分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(18, self.height-1, self.width-36, 1)];
    line.backgroundColor = kRGBA_COLOR(@"#EEEEEE", 1.0);
    [self addSubview:line];
    ///红发发送人信息
    UIView *centerHeaderV = [[UIView alloc] init];
    [self addSubview:centerHeaderV];
    UIImageView *userIconV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    userIconV.layer.masksToBounds = YES;
    userIconV.layer.cornerRadius = 10;
    [centerHeaderV addSubview:userIconV];
    _userIconV = userIconV;
    UILabel *userNameL = [[UILabel alloc] init];
    userNameL.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    userNameL.textColor= kRGBA_COLOR(@"#333333", 1.0);
    [centerHeaderV addSubview:userNameL];
    _userNameL = userNameL;
    [centerHeaderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(16);
        make.centerX.equalTo(self);
    }];
    [userIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.top.bottom.equalTo(centerHeaderV);
        make.right.equalTo(userNameL.mas_left).mas_offset(-10);
    }];
    [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerHeaderV);
        make.centerY.equalTo(userIconV);
    }];
}


- (void)showResult:(RedPacketVOModel *)voModel {
    [_userIconV sd_setImageWithURL:[NSURL URLWithString:voModel.sendUserAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    _userNameL.text = [NSString stringWithFormat:kLocalizationMsg(@"%@的红包"),voModel.sendUserName];
    ///结果数据显示
    
    ///简单的一行文字
    UILabel *coinText = [[UILabel alloc] init];
    coinText.numberOfLines = 0;
    coinText.font = [UIFont systemFontOfSize:13];
    coinText.textColor= kRGBA_COLOR(@"#999999", 1.0);
    coinText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:coinText];
    [coinText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(15);
        make.right.equalTo(self).mas_offset(-15);
        make.bottom.equalTo(self).mas_offset(-30);
    }];

    switch (voModel.isReceive) {
        case 1:///新领到
        case 2:///已成功领取
        {
            NSString *unitStr = kUnitStr;
            NSString *showRecevie = [NSString stringWithFormat:@"%.2lf %@",voModel.myReceivedValue,unitStr];
            NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showRecevie];
            [muStr setAttributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"#D3A200", 1.0),NSFontAttributeName:[UIFont boldSystemFontOfSize:30]} range:NSMakeRange(0, showRecevie.length-unitStr.length)];
            [muStr setAttributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"#D3A200", 1.0),NSFontAttributeName:[UIFont systemFontOfSize:12],NSBaselineOffsetAttributeName:@(0.1 * (30-12))} range:NSMakeRange(showRecevie.length-unitStr.length, unitStr.length)];
            coinText.attributedText = muStr;
        }
            break;
        case 0: ///未领
            coinText.text = kLocalizationMsg(@"还未被领取");
            break;
        case 3: ///领完了
            if (voModel.redPacketRange == 1) {
                coinText.text = [NSString stringWithFormat:kLocalizationMsg(@"共%d个大奖，粉丝热火朝天的领完啦!"),voModel.redPacketAmount];
            }else{
                if (voModel.sendUserId == [ProjConfig userId]) { ///自己是发红包的人
                    coinText.text = kLocalizationMsg(@"已被对方领取");
                }else{
                    coinText.text = kLocalizationMsg(@"已领取对方的红包");
                }
            }
            break;
        case 4: ///已过期
            coinText.text = kLocalizationMsg(@"该红包已过期");
            break;
        default:
            break;
    }
}

@end


#pragma mark    - 红包领取人数 -
@interface GetRedPacketNumView : UIView
@property (nonatomic, weak)UILabel *titleL;
@end

@implementation GetRedPacketNumView
- (UILabel *)titleL{
    if (!_titleL) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = kRGBA_COLOR(@"#999999", 1.0);
        lab.font = [UIFont systemFontOfSize:12];
        [self addSubview:lab];
        _titleL = lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(18);
            make.bottom.equalTo(self).mas_offset(-5);
        }];
    }
    return _titleL;
}
@end

#pragma mark    - 红包领取人数 -
@interface GetRedPacketUserItemCell : UITableViewCell

@property (nonatomic, weak)UILabel *coinL;  ///金币
@property (nonatomic, weak)UIImageView *userIconV;  ///用户头像
@property (nonatomic, weak)UILabel *userNameL;    ///用户名称

@end

@implementation GetRedPacketUserItemCell
- (UIImageView *)userIconV{
    if (!_userIconV) {
        UIImageView *userIcon = [[UIImageView alloc] init];
        userIcon.layer.masksToBounds = YES;
        userIcon.layer.cornerRadius = 15;
        [self.contentView addSubview:userIcon];
        _userIconV = userIcon;
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).mas_offset(18);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return _userIconV;
}

- (UILabel *)userNameL{
    if (!_userNameL) {
        UILabel *nameL = [[UILabel alloc] init];
        nameL.textColor = kRGBA_COLOR(@"#333333", 1.0);
        nameL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:nameL];
        _userNameL = nameL;
        [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userIconV.mas_right).mas_offset(10);
            make.centerY.equalTo(self.userIconV);
            make.right.equalTo(self.coinL.mas_left).offset(3).priorityLow();
        }];
        [nameL setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        [nameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _userNameL;
}

- (UILabel *)coinL{
    if (!_coinL) {
        UILabel *coinL = [[UILabel alloc] init];
        coinL.textColor = kRGBA_COLOR(@"#333333", 1.0);
        coinL.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:coinL];
        _coinL = coinL;
        [coinL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).mas_offset(-18);
            make.centerY.equalTo(self.contentView);
        }];
        [coinL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _coinL;
}



@end





@interface OpenRedPacketResultView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *weakTableV;

@property (nonatomic, weak)UILabel *titleL; ///标题

@property (nonatomic, copy)NSArray<RedPacketReceiveRecordVOModel *> *items;

@property (nonatomic, weak)ShowRedPacketResultView *resultV;

@property (nonatomic, strong)GetRedPacketNumView *numHeaderV;

@property (nonatomic, assign)int redPacketAmount; ///红包数量

@property (nonatomic, strong)RedPacketVOModel *voModel;

@end

@implementation OpenRedPacketResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self createUI];
    }
    return self;
}

+ (void)showRedPtInfo:(int64_t)redPtID resultHandle:(void (^)(int))resultHandle{
    UIView *view = [PopupTool getPopupViewForClass:self];
    if (!view) {
        [HttpApiRedPacketController getMyRedPacketReceiveVO:redPtID callback:^(int code, NSString *strMsg, RedPacketVOModel *model) {
            if (code == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [OpenRedPacketResultView showResultInfo:model];
                });
                resultHandle?resultHandle(model.isReceive):nil;
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

+ (void)showResultInfo:(RedPacketVOModel *)voModel{
    CGFloat viewW = kScreenWidth-100;

    OpenRedPacketResultView *resultV = [[OpenRedPacketResultView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewW*(375/275.0))];
    resultV.layer.masksToBounds = YES;
    resultV.layer.cornerRadius = 25;
    [resultV showResult:voModel];
    [[PopupTool share] createPopupViewWithLinkView:resultV allowTapOutside:YES cover:YES];
    resultV.center = CGPointMake(resultV.superview.width/2.0, resultV.superview.height/2.0);
    
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(resultV.width-30-7, 7, 30, 30);
    closeBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [closeBtn setImage:[UIImage imageNamed:@"redpacket_close_yellow"] forState:UIControlStateNormal];
    [closeBtn addTarget:resultV action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [resultV addSubview:closeBtn];
}

///关闭红包
- (void)closeBtnClick:(UIButton *)btn{
    [[PopupTool share] closePopupView:self];
}

- (void)showResult:(RedPacketVOModel *)voModel{
    _voModel = voModel;

    ///0未领 1刚刚领 2 已领到 3领完了 4已过期
    if (voModel.redPacketRange == 2) {
        switch (voModel.isReceive) {
            case 1:
            case 2:
                self.titleL.text = kLocalizationMsg(@"运气冲天!");
                break;
            case 3:
                self.titleL.text = kLocalizationMsg(@"已领取");
                break;
            case 4:
                self.titleL.text = kLocalizationMsg(@"已过期");
                break;
            default:
                self.titleL.text = kLocalizationMsg(@"待领取");
                break;
        }
    }else{
        switch (voModel.isReceive) {
            case 1:
            case 2:
                self.titleL.text = kLocalizationMsg(@"运气冲天!");
                break;
            case 3:
            case 4:
                self.titleL.text = kLocalizationMsg(@"可惜，来晚一步!");
                break;
            default:
                self.titleL.text = kLocalizationMsg(@"待领取");
                break;
        }
    }
    self.titleL.font = [UIFont systemFontOfSize:(voModel.isReceive==1||voModel.isReceive ==2)?30:25 weight:UIFontWeightSemibold];
    [self.resultV showResult:voModel];
    [self getUserList:voModel.id_field];
}


- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *headerImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 120/375.0*self.height)];
    headerImgV.image = [UIImage imageNamed:@"redpacket_header_bg"];
    [self addSubview:headerImgV];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = kRGBA_COLOR(@"#FFE384", 1.0);
    titleL.font = [UIFont systemFontOfSize:30 weight:UIFontWeightSemibold];
    [headerImgV addSubview:titleL];
    _titleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerImgV);
    }];
    
    ///用户抽奖信息
    ShowRedPacketResultView *userInfoBgV = [[ShowRedPacketResultView alloc] initWithFrame:CGRectMake(0, 0, self.width, 115)];
    _resultV = userInfoBgV;
    ///领取列表
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, headerImgV.maxY, self.width, self.height-headerImgV.height) style:UITableViewStyleGrouped];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.tableHeaderView = userInfoBgV;
    [tableV registerClass:[GetRedPacketUserItemCell class] forCellReuseIdentifier:@"GetRedPacketUserItemCell"];
    [self addSubview:tableV];
    _weakTableV = tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RedPacketReceiveRecordVOModel *voModel = _items[indexPath.row];
    GetRedPacketUserItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetRedPacketUserItemCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.userIconV sd_setImageWithURL:[NSURL URLWithString:voModel.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    cell.userNameL.text = voModel.userName;
    cell.coinL.attributedText = [[NSString stringWithFormat:@"%.2lf",voModel.myReceivedValue] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:NO];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_numHeaderV) {
        _numHeaderV = [[GetRedPacketNumView alloc] initWithFrame:CGRectMake(0, 0, self.width, 32.0)];
    }
    _numHeaderV.titleL.text = [NSString stringWithFormat:kLocalizationMsg(@"已领取(%d/%d)"),_voModel.remainingAmount,_voModel.redPacketAmount];
    return _numHeaderV;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}



- (void)getUserList:(int64_t)redPackedId{
    kWeakSelf(self);
    [HttpApiRedPacketController redPacketRecord:redPackedId callback:^(int code, NSString *strMsg, NSArray<RedPacketReceiveRecordVOModel *> *arr) {
        if (code == 1) {
            weakself.items = arr;
            [weakself.weakTableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



@end
