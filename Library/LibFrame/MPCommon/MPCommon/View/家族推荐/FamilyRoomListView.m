//
//  FamilyRoomListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FamilyRoomListView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "FamilyRoomItemCell.h"
#import <LibProjModel/HttpApiApiGuild.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjModel/LiveRoomInfoVOModel.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjView/EmptyView.h>

@interface FamilyRoomListView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)UICollectionView *familyRoomCollV;

@property (nonatomic, weak)EmptyView *emptyV;

@property (nonatomic, copy)NSArray<LiveRoomInfoVOModel *> *liveRooms;

@end


@implementation FamilyRoomListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setFamilyId:(int64_t)familyId {
    _familyId = familyId;
    self.backgroundColor = kRGBA_COLOR(@"#383838", 1.0);
    [self.emptyV removeFromSuperview];
    self.liveRooms = nil;
    [self loadRoomList:familyId];
}

- (void)createUI{
    ///标题
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.width-20, 20)];
    titleL.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    titleL.text = kLocalizationMsg(@"房间列表");
    titleL.textAlignment = NSTextAlignmentRight;
    titleL.textColor = [UIColor whiteColor];
    [self addSubview:titleL];

    self.familyRoomCollV.delegate = self;
    self.familyRoomCollV.dataSource = self;
}

- (UICollectionView *)familyRoomCollV{
    if (!_familyRoomCollV) {
        ///房间列表
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(110, 110);
        flow.minimumLineSpacing = 5;
        flow.minimumInteritemSpacing = 0;
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, kSafeAreaBottom, 0);
        UICollectionView *familyRoomCollV = [[UICollectionView alloc] initWithFrame:CGRectMake(12, 40, self.width-20, self.height-40) collectionViewLayout:flow];
        [familyRoomCollV registerClass:[FamilyRoomItemCell class] forCellWithReuseIdentifier:@"FamilyRoomItemCell"];
        familyRoomCollV.backgroundColor = [UIColor clearColor];
        [self addSubview:familyRoomCollV];
        _familyRoomCollV = familyRoomCollV;
    }
    return _familyRoomCollV;
}

- (void)loadRoomList:(int64_t)familyId{
    kWeakSelf(self);
    [HttpApiApiGuild getGuildLiveRoom:familyId callback:^(int code, NSString *strMsg, NSArray<LiveRoomInfoVOModel *> *arr) {
        if (code == 1) {
            weakself.liveRooms = arr;
            [weakself.familyRoomCollV reloadData];
            if (arr == 0) {
                weakself.emptyV.detailL.text = kLocalizationMsg(@"没有直播的房间");
            }
        }else{
            weakself.emptyV.detailL.text = strMsg;
        }
        weakself.emptyV.hidden = arr.count>0?YES:NO;
    }];
}


- (EmptyView *)emptyV{
    if (!_emptyV) {
        EmptyView *emptyV = [[EmptyView alloc] init];
        emptyV.frame = self.familyRoomCollV.bounds;
        emptyV.detailL.text = kLocalizationMsg(@"暂时没有正在直播的房间");
        [self.familyRoomCollV addSubview:emptyV];
        [self.familyRoomCollV bringSubviewToFront:emptyV];
        _emptyV = emptyV;
    }
    return _emptyV;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _liveRooms.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FamilyRoomItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyRoomItemCell" forIndexPath:indexPath];
    cell.voModel = _liveRooms[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([LiveManager liveInfo].roomRole != RoomRoleForAnchor) {
        LiveRoomInfoVOModel *voModel = _liveRooms[indexPath.row];
        kWeakSelf(self);
        [[CheckRoomPermissions share] joinRoom:voModel.roomId liveDataType:voModel.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
            LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
            req.dataIndex = indexPath.row;
            req.joinPosition = 7;
            req.unionId = weakself.familyId;
            [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:req];
        } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"该房间已关闭")];
        } fail:nil];
    }
}

@end
