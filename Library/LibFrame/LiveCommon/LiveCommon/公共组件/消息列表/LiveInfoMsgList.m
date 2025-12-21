//
//  LiveInfoMsgList.m
//  TCDemo
//
//  Created by admin on 2019/10/12.
//  Copyright © 2019 CH. All rights reserved.
//

#import "LiveInfoMsgList.h"
#import <TXImKit/TXImKit.h>
#import "MessageTableViewCell.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjBase/ProjConfig.h>
#import <LiveCommon/LiveManager.h>
#import <LibTools/LiveMacros.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjView/ChoiceGiftView.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>

@interface LiveInfoMsgList ()<UITableViewDelegate,UITableViewDataSource,MessageTableViewCellDelegate>

@property (nonatomic, strong) UITableView *listTableV;
@property (nonatomic, strong) NSMutableArray <MessageModel *>*listMuArr;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;//渐变涂层

@end

@implementation LiveInfoMsgList
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        NSArray *colors = @[(id)[UIColor colorWithWhite:0 alpha:0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            (id)[UIColor colorWithWhite:0 alpha:1.0].CGColor,
                            ];
        [_gradientLayer setColors:colors];
        [_gradientLayer setStartPoint:CGPointMake(0, 0)];
        [_gradientLayer setEndPoint:CGPointMake(0, 1)];
        _gradientLayer.hidden = NO;
    }
    return _gradientLayer;
}
 
- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        CGFloat viewH = 210 * kScreenHeight / 640.0 - 40;
        CGFloat viewW = superView.width -liveLinkMicViewW-20;
        self.frame = CGRectMake(0, superView.height -viewH - liveBottomViewH - 5 - kSafeAreaBottom, viewW, viewH);
        [superView addSubview:self];
        self.gradientLayer.frame = self.bounds;
        [self.layer setMask:self.gradientLayer];
        [self createUI];
        
        switch ([LiveManager liveInfo].liveType) {
            case LiveTypeForOneToOne:
            {
                self.y -= 50;
            }
                break;
            default:
                break;
        }
    }
    return self;
}


- (void)addMsg:(MessageModel *)model{
    if (model == nil) {
        return;
    }

    if (self.listMuArr==nil) {
        self.listMuArr = [[NSMutableArray alloc] init];
    }
    
    if (self.listMuArr.count > 30) {
        [self.listMuArr removeObjectAtIndex:0];
    }
    
    [self.listMuArr addObject:model];
    [self.listTableV reloadData];
    
    // 检查当前是否在最后一行的最后位置，如果是，自动滚动，如果不是，不滚动
    [self scrollLastLine];
    
}

- (void)createUI{
    [self addSubview:self.listTableV];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listMuArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell"];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageTableViewCell"];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.model = self.listMuArr[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MessageModel *model = self.listMuArr[indexPath.section];
//    if (model.userId != 0) {
//        [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(model.userId)}];
//    }
}

// MARK: - Public
- (void)scrollLastLine{
    if (self.listMuArr.count > 1) {
        [_listTableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                               inSection:(self.listMuArr.count - 2)]
                           atScrollPosition:UITableViewScrollPositionNone animated:NO];
        
        [_listTableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                               inSection:(self.listMuArr.count - 1)]
                           atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}

// MARK: - Private
- (void)checkShowLastLineAndScroll{
    // 检查当前是否在最后一行的最后位置，如果是，自动滚动，如果不是，不滚动
    UITableViewCell *lastCell = _listTableV.visibleCells.lastObject;
    NSIndexPath *lastPath = [_listTableV indexPathForCell:lastCell];
    if ( lastPath.section >= (_listMuArr.count-2)) {

        [_listTableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                               inSection:(self.listMuArr.count - 1)]
                           atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}

// MARK: - Lazy
- (UITableView *)listTableV{
    if (_listTableV == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        [tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"MessageTableViewCell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.estimatedRowHeight = 80.0;
        _listTableV = tableView;
    }
    return _listTableV;
}

//MARK: - MessageTableViewCellDelegate
- (void)messageInfoClickAtMessageTableViewCell:(MessageTableViewCell *)cell{
    MessageModel *model = cell.model;
    if (model.type == 19 && model.userId != [ProjConfig userId]) {
        
        GiftUserModel *userM = [[GiftUserModel alloc] init];
        userM.userId = model.userId;
        userM.userName = model.uname;
        userM.userIcon = model.avatar;
        userM.roomId = [LiveManager liveInfo].roomId;
        userM.anchorId = [LiveManager liveInfo].anchorId;
        userM.showId = [LiveManager liveInfo].serviceShowId;
        [ChoiceGiftView showGift:[LiveManager liveInfo].serviceLiveType giftType:model.msgModel.giftType giftId:model.msgModel.giftId users:@[userM] hasContinue:YES sendSuccess:nil];
    }else{
        if (model.userId != 0) {
            [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(model.userId)}];
        }
    }
}

- (void)userAvaterClickAtMessageTableViewCell:(MessageTableViewCell *)cell{
    MessageModel *model = cell.model;
    if (model.userId != 0) {
        [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(model.userId)}];
    }
}

@end
