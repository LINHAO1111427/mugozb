//
//  DYCommentListView.m
//  ShortVideo
//
//  Created by ssssssss on 2020/6/22.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DYCommentListView.h"
#import "DYCommentCell.h"
#import <LibTools/LibTools.h>
#import <LibProjView/EmptyView.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjView/ChatInputView.h>
#import <LibProjModel/HttpApiDynamicController.h>

NSString *const DYCommentMoreItemCellIdentifier = @"DYCommentMoreItemCellIdentifier";
@interface DYCommentListView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong)ApiUserVideoModel *model;

@property (nonatomic, assign)__block int page;
@property(nonatomic, strong)NSMutableArray *allMuArray;
@property(nonatomic, weak)UITableView *weakTableV;
@property (nonatomic, weak)EmptyView *emptyV;


@property (nonatomic, strong)UILabel *allCommentLabels;
@property (nonatomic, weak)UIView *contentBgView;
@end

@implementation DYCommentListView

- (instancetype)initWithCommentModel:(ApiUserVideoModel *)model{
    self = [super init];
    if (self) {
        self.tag = [self commentlistTag];
        _model = model;
        self.contentBgView.hidden = NO;
        UIButton *clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        clearBtn.backgroundColor = [UIColor clearColor];
        [clearBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:clearBtn atIndex:0];
        [self loadDataNow:YES];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(commentListRefresh) name:@"sv_commentListRefresh" object:nil];
        [self getCommentNum];
    }
    return self;
}

- (void)show{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}
- (void)commentListRefresh{
    [self loadDataNow:YES];
}
- (void)loadDataNow:(BOOL)refresh{
    kWeakSelf(self);
    [weakself loadData:refresh callback:^(BOOL success) {
        
    }];
    
}
- (void)showInView:(UIView *)superView{
    UIView *selfV = [superView viewWithTag:[self commentlistTag]];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    if (selfV) {
        return;
    }
    self.frame = superView.bounds;
    [superView addSubview:self];
    [self show:YES];
    
    
}

- (void)dealloc
{
    _allMuArray = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sv_commentListRefresh" object:nil];
}

- (NSInteger)commentlistTag{
    return 6744852;
}

- (NSMutableArray *)allMuArray{
    if (_allMuArray == nil) {
        _allMuArray = [[NSMutableArray alloc] init];
    }
    return _allMuArray;
}

- (void)removeSelf{
    self.hidden = YES;
    [self endEditing:YES];
    [self show:NO];
}

- (void)show:(BOOL)isShow{
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakself.backgroundColor = [weakself.backgroundColor colorWithAlphaComponent:isShow?0.3:0.0];
        CGRect rc = weakself.contentBgView.frame;
        rc.origin.y = kScreenHeight - (isShow?rc.size.height:0);
        weakself.contentBgView.frame = rc;
    } completion:^(BOOL finished) {
        if (!isShow) {
            [weakself.contentBgView removeFromSuperview];
            weakself.contentBgView = nil;
            [weakself removeFromSuperview];
        }
    }];
}

-(void)resignFirst{
    [self removeSelf];
}


#pragma mark - 初始化UI -
- (UIView *)contentBgView{
    if (_contentBgView == nil) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight*0.7)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        _contentBgView = bgView;
        
        //        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirst)];
        //           [self addGestureRecognizer:Tap];
        
        ///切两个上圆角
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(7,7)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask = maskLayer;
        
        ///头部视图
        UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, 44)];
        [bgView addSubview:headerV];
        
        //显示评论的数量
        UILabel *allCommentLabels = [[UILabel alloc]initWithFrame:CGRectMake(20,0,headerV.frame.size.width/2,headerV.frame.size.height)];
        allCommentLabels.textColor =kRGB_COLOR(@"#333333");
        allCommentLabels.font = [UIFont systemFontOfSize:15];
        self.allCommentLabels = allCommentLabels;
        [headerV addSubview:self.allCommentLabels];
        
        //关闭按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(headerV.frame.size.width - 45,0,headerV.frame.size.height,headerV.frame.size.height);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.imageEdgeInsets = UIEdgeInsetsMake(12.5,12.5,12.5,12.5);
        [btn setImage:[UIImage imageNamed:@"dynamic_photo_delete"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        [headerV addSubview:btn];
        
        //tableview顶部横线 和 顶部 view分割开
        UILabel *lines = [[UILabel alloc]initWithFrame:CGRectMake(0,headerV.frame.size.height-1,headerV.frame.size.width,1)];
        lines.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [headerV addSubview:lines];
        
        ///评论
        kWeakSelf(self);
        UIView *commentV = [ChatInputView getInputViewWithPlaceholder:kLocalizationMsg(@"说点什么...")];
        [commentV klc_whenTapped:^{
            [ChatInputView showInput:kLocalizationMsg(@"说点什么...") inputText:^(NSString * _Nullable inputText) {
                [weakself commentToId:weakself.model.id_field replay:NO msg:inputText];
                [weakself loadDataNow:YES];
                [weakself removeSelf];
            }];
        }];
        
        CGRect rc = commentV.frame;
        rc.origin = CGPointMake(0, bgView.frame.size.height-rc.size.height-kSafeAreaBottom);
        commentV.frame = rc;
        [bgView addSubview:commentV];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, commentV.maxY, kScreenWidth, kSafeAreaBottom)];
        bottomLine.backgroundColor = kRGB_COLOR(@"#eeeeee");
        [bgView addSubview:bottomLine];
        ///数据聊表
        UITableView *tableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerV.frame), bgView.frame.size.width, bgView.frame.size.height-kSafeAreaBottom-CGRectGetMaxY(headerV.frame)-commentV.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource  = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _weakTableV = tableView;
        [tableView registerClass:[DYCommentCell class] forCellReuseIdentifier:DYCommentMoreItemCellIdentifier];
        [bgView addSubview:tableView];
        [tableView preloadHandle:^{
            [weakself loadDataNow:NO];
        }];
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataNow:YES];
        }];
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataNow:NO];
        }];
        _weakTableV = tableView;
    }
    return _contentBgView;
}

////数据是否为空
-(EmptyView *)emptyV{
    if (_emptyV == nil) {
        EmptyView *empty = [[EmptyView alloc] init];
        empty.titleL.text = kLocalizationMsg(@"暂无评论内容");
        empty.detailL.text = kLocalizationMsg(@"赶紧来评论一下吧～");
        [empty showInView:_weakTableV];
        _emptyV = empty;
    }
    return _emptyV;
}

#pragma mark - 获取数据后显示 -
- (void)loadData:(BOOL)refresh callback:(void(^)(BOOL success))callback{
    if ([[ProjConfig shareInstence].baseConfig onlyDynamicAuthorShowComment] && self.model.uid != [ProjConfig userId]) {
        self.weakTableV.mj_header = nil;
        self.weakTableV.mj_footer = nil;
        self.emptyV.titleL.text = kLocalizationMsg(@"评论内容，仅作者可见～");
        self.emptyV.titleL.textColor = [UIColor blackColor];
        self.emptyV.detailL.text = @"";
        self.emptyV.hidden = NO;
        return;
    }
    
    int pageSize = kPageSize;
    int page = refresh?0:(int)self.allMuArray.count/pageSize  + (self.allMuArray.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiDynamicController getCommentBasicInfo:self.model.id_field page:page pageSize:pageSize callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<ApiUsersVideoCommentsModel *> *arr) {
        if (code == 1) {
            [weakself.weakTableV.mj_header endRefreshing];
            [weakself.weakTableV.mj_footer endRefreshing];
            if (refresh) {
                [weakself.allMuArray removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.allMuArray addObjectsFromArray:arr];
                [weakself.weakTableV reloadData];
            }else{
                [weakself.weakTableV.mj_footer endRefreshingWithNoMoreData];
            }
            callback(YES);
        }else{
            [weakself.weakTableV.mj_header endRefreshing];
            [weakself.weakTableV.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
            callback(NO);
        }
        weakself.emptyV.hidden = weakself.allMuArray.count;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allMuArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:DYCommentMoreItemCellIdentifier forIndexPath:indexPath];
    cell.model = self.allMuArray.count>indexPath.row?self.allMuArray[indexPath.row]:nil;
    kWeakSelf(self);
    cell.userInfo = ^(int64_t touid) {
        if (weakself.showUserInfo) {
            weakself.showUserInfo(touid);
        }else{
            //            if (weakself.userInfo) {
            //                weakself.userInfo(touid);
            //            }
        }
        
        [weakself removeSelf];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApiUsersVideoCommentsModel *model = self.allMuArray.count>indexPath.row?self.allMuArray[indexPath.row]:nil;
    kWeakSelf(self);
    [ChatInputView showInput:[NSString stringWithFormat:kLocalizationMsg(@"回复%@:"),model.userName] inputText:^(NSString * _Nullable inputText) {
        
        [weakself commentToId:model.commentid replay:YES msg:inputText];
        [weakself loadDataNow:YES];
        [weakself removeSelf];
        
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}
#pragma mark-UIGestureRecognizerDelegate
- (void)tap{
    [self removeSelf];
}



///评论动态 type1评论2回复
- (void)commentToId:(int64_t)toId replay:(BOOL)isReplay msg:(NSString *)msg{
    if ([msg isEmpty]) {
        return;
    }
    kWeakSelf(self);
    [HttpApiDynamicController addComment:isReplay?2:1 content:msg objId:toId callback:^(int code, NSString *strMsg, ApiUsersVideoCommentsModel *model) {
        if (code == 1) {
            [weakself getCommentNum];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)getCommentNum{
    kWeakSelf(self);
    [HttpApiDynamicController getCommentCount:self.model.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.model.comments = [model.no_use intValue];
                weakself.allCommentLabels.text = [NSString stringWithFormat:kLocalizationMsg(@"%d 评论"), [model.no_use intValue]];
                if (weakself.commentSuccess) {
                    weakself.commentSuccess(weakself.model.comments);
                }
            });
        }
    }];
}


@end
