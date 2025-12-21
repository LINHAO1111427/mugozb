//
//  ChangeRoomTypeView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "ChangeRoomTypeView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/OpenAuthDataVOModel.h>
#import <Masonry.h>
#import "SelectRoomTypeCell.h"


@interface ChangeRoomTypeView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, copy)NSArray<RoomTypeModel *> *itemArr;

@property (nonatomic, copy)void (^selectRoomTypeBlock)(RoomTypeModel *);

@property (nonatomic, assign)BOOL isModify;  ///是否为改变房间类型模式

@property (nonatomic, strong) RoomTypeModel *selectRoomMode;  ///选择的房间模式

@property (nonatomic, copy) RoomTypeModel *currentRoomMode;  ///当前的房间模式

@property (nonatomic, weak) SelectRoomTypeCell *selectCell;

@end

@implementation ChangeRoomTypeView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)selectRoomTypeIsModify:(BOOL)isModify roomTypeSelect:(void (^)(RoomTypeModel * _Nonnull))selectBlock{
    
    [ChangeRoomTypeView loadRoomDataForSuccess:^(NSArray<LiveRoomTypeDTOModel *> *arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ChangeRoomTypeView *typeV = [[self alloc] init];
            typeV.isModify = isModify;
            typeV.selectRoomTypeBlock = selectBlock;
            [typeV show:arr];
        });
    }];
    

}

+ (RoomTypeModel *)getCurrentRoomType{
    ///保存房间类型
    OpenAuthDataVOModel *openModel =  [LiveManager liveInfo].openData;
    int roomType = openModel.roomType;
    NSString *roomTypeStr = openModel.roomTypeName;
    if (openModel.roomTypeName.length == 0) {
        roomType = 0;
        roomTypeStr = kLocalizationMsg(@"普通模式");
    }
    RoomTypeModel *currentRoomType = [[RoomTypeModel alloc] initWithId:0 roomType:roomType roomTypeStr:roomTypeStr];
    currentRoomType.roomTypeValue = openModel.roomTypeVal;
    return currentRoomType;
}

- (void)saveSelectRoomType{
    OpenAuthDataVOModel *openModel =  [LiveManager liveInfo].openData;
    openModel.roomType = _selectRoomMode.roomType;
    openModel.roomTypeVal = _selectRoomMode.roomTypeValue;
    openModel.roomTypeName = _selectRoomMode.roomTypeStr;
    [LiveManager liveInfo].openData = openModel;
}

+ (void)loadRoomDataForSuccess:(void(^)(NSArray<LiveRoomTypeDTOModel *> *arr))successBlock{
    int liveType = 0;
    ///1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForMPVideoLive:
        case LiveTypeForShoppingLive:
            liveType = 1;
            break;
        case LiveTypeForMPAudioLive:
            liveType = 2;
            break;
        case LiveTypeForOneToOne:
            liveType = 3;
            break;
        default:
            break;
    }
    [HttpApiPublicLive getLiveRoomType:liveType showId:[LiveManager liveInfo].serviceShowId>0?[LiveManager liveInfo].serviceShowId:@"-1" callback:^(int code, NSString *strMsg, NSArray<LiveRoomTypeDTOModel *> *arr) {
        if (code == 1) {
            if (successBlock && arr.count) {
                successBlock(arr);
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}


- (void)clickContentView:(UIGestureRecognizer *)tap{
    [self endEditing:YES];
}

- (void)show:(NSArray<LiveRoomTypeDTOModel *> *)arr{
    
    ///先设置当当房间模式
    _currentRoomMode = [ChangeRoomTypeView getCurrentRoomType];
    ///设置当前房间显示的数据
    self.itemArr = [self getShowLiveRoomType:arr];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContentView:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillChange:) name:UIKeyboardWillHideNotification object:nil];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-30, 17)];
    titleL.text = [NSString stringWithFormat:kLocalizationMsg(@"当前房间模式 : %@"),_currentRoomMode.roomTypeStr];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = [UIColor darkGrayColor];
    [self addSubview:titleL];
    
    self.tableV.y = titleL.maxY+10;
    [self.tableV reloadData];
    
    UIButton *sureBtn = [UIButton buttonWithType:0];
    sureBtn.frame = CGRectMake(30, self.tableV.maxY+20, kScreenWidth-60, 40);
    [sureBtn setTitle:kLocalizationMsg(@"修改房间模式") forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"live_btn_purple"] forState:UIControlStateNormal];
    
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 20;
    [self addSubview:sureBtn];
    
    kWeakSelf(self);
    [sureBtn klc_whenTapped:^{
        if (!self.selectRoomMode) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择房间模式")];
        }else{
            [weakself changeType];
        }
    }];

    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(sureBtn.x, sureBtn.maxY+10, sureBtn.width, 30)];
    textLab.text = kLocalizationMsg(@"修改为普通模式时，新用户可自由无限制进入直播间;\n修改为其他模式时，当前直播间用户将自动退出直播间");
    textLab.textColor = [UIColor lightGrayColor];
    textLab.font = [UIFont systemFontOfSize:10];
    textLab.textAlignment = NSTextAlignmentCenter;
    textLab.numberOfLines = 0;
    [self addSubview:textLab];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, textLab.maxY+20);
    if (_isModify) {
        [FunctionSheetBaseView showTitle:kLocalizationMsg(@"修改房间模式") detailView:self cover:NO btnImage:[UIImage imageNamed:@"back_fanhui_gray"] isLeft:YES clickBlock:^{
            [FunctionSheetBaseView deletePopView:weakself];
        } cancelBack:nil];
    }else{
        [FunctionSheetBaseView showTitle:kLocalizationMsg(@"修改房间模式") detailView:self cover:NO];
    }
}


///键盘弹起降下
- (void)keyBoardFrameWillChange:(NSNotification *)notify{
    UIView *superV = self.superview;
    CGRect keyBoardRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        CGRect rc = superV.frame;
        rc.origin.y = (keyBoardRc.origin.y < kScreenHeight)?(keyBoardRc.origin.y-(self.maxY)):(kScreenHeight-rc.size.height);
        superV.frame = rc;
    }];
}

- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(30, 0, kScreenWidth-60, _itemArr.count*50) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.bounces = NO;
        tableV.scrollEnabled = YES;
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableV registerClass:[SelectRoomTypeCell class] forCellReuseIdentifier:@"SelectRoomTypeCellIdentifier"];
        [self addSubview:tableV];
        _tableV = tableV;
     }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoomTypeModel *model = _itemArr[indexPath.item];
    SelectRoomTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectRoomTypeCellIdentifier" forIndexPath:indexPath];
    cell.titleL.text = model.roomTypeStr;
    cell.textFV.hidden = !model.hasValue;
    cell.unitL.text = model.unit;
    
    kWeakSelf(self);
    kWeakSelf(model);
    kWeakSelf(indexPath);
    cell.selectItem = ^{
        weakself.selectRoomMode = weakmodel;
        [weakself.selectCell selectItems:NO];
        weakself.selectCell = [weakself.tableV cellForRowAtIndexPath:weakindexPath];
        [weakself.selectCell selectItems:YES];
        weakself.selectRoomMode.roomTypeValue = weakself.selectCell.textFV.text;
    };
    cell.selectItemValueDidChange = ^(NSString * _Nonnull value) {
        if (weakmodel.roomType == weakself.selectRoomMode.roomType) {
            weakself.selectRoomMode.roomTypeValue = value;
        }
    };
    if (_currentRoomMode.roomType == model.roomType) {
        cell.textFV.text = _currentRoomMode.roomTypeValue;
        [cell selectItems:YES];
        _selectCell = cell;
        model.roomTypeValue = _currentRoomMode.roomTypeValue;
        self.selectRoomMode = model;
    }else{
        [cell selectItems:NO];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self endEditing:YES];
}

- (void)changeType{
    
    if (self.selectRoomMode.hasValue && self.selectRoomMode.roomTypeValue.length == 0) {
        [SVProgressHUD showInfoWithStatus:self.selectRoomMode.tips];
        return;
    }
    
    ///是私密房间密码位数判断
    if (self.selectRoomMode.roomType == 1 && self.selectRoomMode.roomTypeValue.length != 6) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入6位数字")];
        return;
    }
    
    ///收费房间或者计时房间
    if (self.selectRoomMode.roomType == 2 || self.selectRoomMode.roomType == 3) {
        if (self.selectRoomMode.roomTypeValue.length>6) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"已经超出最大范围值")];
        }
    }
    
    if (_isModify) { ///如果是修改模式
        kWeakSelf(self);
        [HttpApiPublicLive updateLiveType:[LiveManager liveInfo].roomId roomType:self.selectRoomMode.roomType roomTypeVal:self.selectRoomMode.roomTypeValue callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself blockRoomData:weakself.selectRoomMode];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{
        [self blockRoomData:self.selectRoomMode];
    }
}

- (void)blockRoomData:(RoomTypeModel *)roomTypeModel{
    if (self.selectRoomTypeBlock && roomTypeModel) {
        self.selectRoomTypeBlock(roomTypeModel);
    }
    [self saveSelectRoomType];
    [FunctionSheetBaseView deletePopView:self];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:self.class]) {
        return YES;
    }
    return NO;
}


- (NSArray *)getShowLiveRoomType:(NSArray<LiveRoomTypeDTOModel *> *)arr{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (LiveRoomTypeDTOModel *typeModel in arr) {
        ///0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
        RoomTypeModel *showModel = [[RoomTypeModel alloc] initWithId:typeModel.id_field roomType:typeModel.roomType roomTypeStr:typeModel.roomName];
        switch (typeModel.roomType) {
            case 1:
            {
                showModel.hasValue = YES;
                showModel.tips = kLocalizationMsg(@"请设置房间密码");
            }
                break;
            case 2:
            {
                showModel.hasValue = YES;
                showModel.tips = kLocalizationMsg(@"请设置房间门票价格");
                showModel.unit = [KLCAppConfig unitStr];
            }
                break;
            case 3:
            {
                NSString *unitStr = [NSString stringWithFormat:kLocalizationMsg(@"%@/分钟"),[KLCAppConfig unitStr]];
                showModel.hasValue = YES;
                showModel.tips = kLocalizationMsg(@"请设置收费金额");
                showModel.unit = unitStr;
            }
                break;
            default:
                break;
        }
        
        [muArr addObject:showModel];
    }
    return muArr;
}


@end



@implementation RoomTypeModel

- (instancetype)initWithId:(int64_t)roomTypeId roomType:(int)roomType roomTypeStr:(NSString *)roomTypeStr{
    self = [super init];
    if (self) {
        _roomTypeId = roomTypeId;
        _roomType = roomType;
        _roomTypeStr = roomTypeStr;
        _roomTypeValue = @"";
        
        _hasValue = NO;
        _tips = @"";
        _unit = @"";
    }
    return self;
}
@end
