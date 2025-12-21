//
//  AudioMicSeatView.m
//  MPAudioLive
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 klc. All rights reserved.
//

#import "AudioMicSeatView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import "MPAudioUserCell.h"
#import "MicSeatManagerObj.h"

#import <LibProjModel/ApiUsersVoiceAssistanModel.h>
#import <LibProjModel/PkUserVoiceAssistanModel.h>

@interface AudioMicSeatView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)UICollectionView *ownCollV;  ///显示视图

@property (nonatomic, weak)UICollectionView *pkOtherCollV;  ///PK中对方的视图

@property (nonatomic, copy)MicSeatManagerObj *managerObj;

@property (nonatomic, assign)LiveInfo_PKType cellType;

///是否为准备中的房间PK
@property (nonatomic, assign)BOOL isPerpareRoomPk;

/// PK中我方战队
@property(nonatomic,copy) NSArray <PkUserVoiceAssistanModel *> *ownPKData;
/// PK中对方战队
@property(nonatomic,copy) NSArray <PkUserVoiceAssistanModel *> *otherPKData;


/// 普通基本的麦位基本麦位排序
@property(nonatomic,copy) NSArray <ApiUsersVoiceAssistanModel *> *normalData;



@end


@implementation AudioMicSeatView

- (void)changePKViewFrame:(CGRect)frame showType:(LiveInfo_PKType)cellType{
    self.frame = frame;
    _cellType = cellType;
    
    CGFloat viewHeight = self.height;
    
    if (cellType > 0) {
        self.pkOtherCollV.hidden = NO;
        self.ownCollV.hidden = NO;
        
        CGFloat space = 50;
        CGFloat viewWidth = (self.width-space)/2.0;
        
        _ownCollV.frame = CGRectMake(0, (self.height-viewHeight)/2.0, viewWidth, viewHeight);
        _pkOtherCollV.frame = CGRectMake(_ownCollV.maxX+space, (self.height-viewHeight)/2.0, viewWidth, viewHeight);
        
    }else{
        self.pkOtherCollV.hidden = YES;
        self.ownCollV.hidden = NO;
        
        _ownCollV.frame = CGRectMake(0, (self.height-viewHeight)/2.0, self.width, viewHeight);
        _pkOtherCollV.frame = CGRectMake(self.width, (self.height-viewHeight)/2.0 , 0, viewHeight);
    }
    [self.ownCollV reloadData];
    [self.pkOtherCollV reloadData];
}


- (void)changeRoomPerparePKFrame:(CGRect)frame{
    _isPerpareRoomPk = YES;
    if (_cellType == LivePKTypeForNormal) {
        [self changePKViewFrame:frame showType:LivePKTypeForRoom];
        NSMutableArray *muArr1 = [[NSMutableArray alloc] init];
        NSMutableArray *muArr2 = [[NSMutableArray alloc] init];
        for (ApiUsersVoiceAssistanModel *assModel in _normalData) {
            if (assModel.no == 1 || assModel.no == 2 ||assModel.no == 5 ||assModel.no == 6) {
                PkUserVoiceAssistanModel *pkModel = [[PkUserVoiceAssistanModel alloc] init];
                pkModel.usersVoiceAssistan = assModel;
                [muArr1 addObject:pkModel];
            }else{
                PkUserVoiceAssistanModel *pkModel = [[PkUserVoiceAssistanModel alloc] init];
                pkModel.usersVoiceAssistan = assModel;
                [muArr2 addObject:pkModel];
            }
        }
        [self setPKOwnData:muArr1 otherData:muArr2];
    }
}


- (void)userSpeaking:(NSInteger)volume uid:(int64_t)uid{
    [_ownCollV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj isKindOfClass:[MPAudioUserCell class]]?[(MPAudioUserCell *)obj speakIng:volume uid:uid]:nil;
    }];
    [_pkOtherCollV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj isKindOfClass:[MPAudioUserCell class]]?[(MPAudioUserCell *)obj speakIng:volume uid:uid]:nil;
    }];
}


- (void)addEmojiPicture:(NSString *)emojiCode withIndex:(NSInteger)index{
   // NSLog(@"过滤文字麦位表情"));
    
    //    MPAudioUserCell *cell = (MPAudioUserCell *)[_collV cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    //    cell.emojiCode = emojiCode;
}

- (void)setNormalSeatData:(NSArray<ApiUsersVoiceAssistanModel *> *)normalData{
    if (_cellType == LivePKTypeForNormal) {
        if (normalData.count > 0) {
            _normalData = normalData;
        }
        [self.ownCollV reloadData];
    }else{
        _normalData = nil;
    }
}

- (void)setPKOwnData:(NSArray<PkUserVoiceAssistanModel *> *)ownModel otherData:(NSArray<PkUserVoiceAssistanModel *> *)otherModel{
    
    if (_cellType!= LivePKTypeForNormal) {
        _ownPKData = ownModel;
        _otherPKData = otherModel;
        [self.ownCollV reloadData];
        [self.pkOtherCollV reloadData];
    }else{
        _ownPKData = nil;
        _otherPKData = nil;
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.cellType) {
        case LivePKTypeForSingle:  ///单人PK
            return self.ownPKData.count;
        case LivePKTypeForRoom:  ///房间PK
            return self.ownPKData.count;
        case LivePKTypeForTeam: ///激情团战
            return self.ownPKData.count;
        default:        ///普通模式
            return self.normalData.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ApiUsersVoiceAssistanModel *seatModel = nil;
    MPAudioUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MPAudioUserCellIdentifier" forIndexPath:indexPath];
    ///cell外部只修改名称和火力值
    switch (self.cellType) {
        case LivePKTypeForSingle:  ///单人PK
        {
            PkUserVoiceAssistanModel *pkSeat;
            if (collectionView == _ownCollV) {
                pkSeat = self.ownPKData[indexPath.row];
                seatModel = pkSeat.usersVoiceAssistan;
                
            }else{
                pkSeat = self.otherPKData[indexPath.row];
                seatModel = pkSeat.usersVoiceAssistan;
            }
            cell.userNameL.text = nil;
            cell.hotL.text = nil;
        }
            break;
        case LivePKTypeForRoom:  ///房间PK
        {
            PkUserVoiceAssistanModel *pkSeat;
            if (collectionView == _ownCollV) {
                pkSeat = self.ownPKData[indexPath.row];
                seatModel = pkSeat.usersVoiceAssistan;
                
            }else{
                pkSeat = self.otherPKData[indexPath.row];
                seatModel = pkSeat.usersVoiceAssistan;
            }
            cell.userNameL.text = nil;
            NSString *hotStr = [NSString stringWithFormat:@"%.0lf",pkSeat.giftVotes];
            cell.hotL.attributedText = [hotStr attachmentForImage:[UIImage imageNamed:@"mg_audio_hot"] bounds:CGRectMake(0, -0.6, 7, 9) before:YES];
        }
            break;
        case LivePKTypeForTeam: ///激情团战
        {
            PkUserVoiceAssistanModel *pkSeat;
            if (collectionView == _ownCollV) {
                pkSeat = self.ownPKData[indexPath.row];
                seatModel = pkSeat.usersVoiceAssistan;
                
            }else{
                pkSeat = self.otherPKData[indexPath.row];
                seatModel = pkSeat.usersVoiceAssistan;
            }
            cell.userNameL.text = nil;
            NSString *hotStr = [NSString stringWithFormat:@"%.0lf",pkSeat.giftVotes];
            cell.hotL.attributedText = [hotStr attachmentForImage:[UIImage imageNamed:@"mg_audio_hot"] bounds:CGRectMake(0, -0.6, 7, 9) before:YES];
        }
            break;
        default:        ///普通模式
        {
            seatModel = self.normalData[indexPath.row];
            cell.userNameL.text = seatModel.status == 1 ? seatModel.userName:seatModel.assistanName;
            NSString *hotStr = [NSString stringWithFormat:@"%.0lf",seatModel.coin];
            cell.hotL.attributedText = [hotStr attachmentForImage:[UIImage imageNamed:@"mg_audio_hot"] bounds:CGRectMake(0, -0.6, 7, 9) before:YES];
            seatModel = self.normalData[indexPath.row];
        }
            break;
    }
    [cell speakIng:0 uid:seatModel.uid];
    cell.seatModel = seatModel;
    return cell;
}




#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellType == LivePKTypeForNormal) {  ///普通模式下
        
        ApiUsersVoiceAssistanModel *seatModel = [self.normalData objectAtIndex:indexPath.row];
        [self.managerObj clickMicSeat:seatModel];
        
    }else{ ///PK模式中
        if (collectionView == _ownCollV) {  ///自己房间的麦位
            PkUserVoiceAssistanModel *pkSeat = self.ownPKData[indexPath.row];
            [self.managerObj clickMicSeat:pkSeat.usersVoiceAssistan];
        }else{
            /// 点了对方的麦位
            PkUserVoiceAssistanModel *pkSeat = self.otherPKData[indexPath.row];
            if (_cellType == LivePKTypeForRoom) {   ///自己自己房间PK
                [self.managerObj clickMicSeat:pkSeat.usersVoiceAssistan];
            }else{
                [self.managerObj showOtherRoomUserInfo:pkSeat.usersVoiceAssistan];
            }
        }
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    switch (self.cellType) {
        case LivePKTypeForSingle:  ///单人PK
        {
            return 1;
        }
            break;
        case LivePKTypeForRoom:  ///房间PK
        {
            CGFloat height = (collectionView.height-160-2)/2.0;
            return height;
        }
            break;
        case LivePKTypeForTeam: ///激情团战
        {
            return 3;
        }
            break;
        default:        ///普通模式
        {
            CGFloat height = (collectionView.height-160-2)/2.0;
            return height;
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    switch (self.cellType) {
        case LivePKTypeForSingle:  ///单人PK
        {
            return UIEdgeInsetsMake(1, 1, 1, 1);
        }
            break;
        case LivePKTypeForRoom:  ///房间PK
        {
            return UIEdgeInsetsMake(5, 1, 1, 1);
        }
            break;
        case LivePKTypeForTeam: ///激情团战
        {
            return UIEdgeInsetsMake(8, 12, 1, 12);
        }
            break;
        default:        ///普通模式
        {
            return UIEdgeInsetsMake(12, 1, 1, 1);
        }
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellWidth = collectionView.frame.size.width-5;
    CGFloat cellHeight = collectionView.frame.size.height-10;
    
    switch (self.cellType) {
        case LivePKTypeForSingle:  ///单人PK
        {
            cellWidth = cellWidth -1;
            cellHeight = cellHeight -1;
        }
            break;
        case LivePKTypeForRoom:  ///房间PK
        {
            cellWidth = (cellWidth)/2.0;
            
            //            cellHeight = cellHeight * 4/5.0;
            //            cellHeight = (cellHeight-4)/2.0;
            cellHeight = 85.0;
        }
            break;
        case LivePKTypeForTeam: ///激情团战
        {
            CGFloat contentW = collectionView.frame.size.width-25;
            if (indexPath.item > 0) { ///其他人
                cellWidth = (contentW)/2.0;
                cellHeight = cellHeight /3.6;
                
            }else{   ///主播
                cellWidth = contentW *2.0/3.0;
                cellHeight = cellHeight /2.45;
            }
        }
            break;
        default:        ///普通模式
        {
            cellWidth = (cellWidth)/4.0;
            
            //            cellHeight = cellHeight * 4/5.0;
            //            cellHeight = (cellHeight-4)/2.0;
            cellHeight = 85.0;
        }
            break;
    }
    
    return CGSizeMake(cellWidth, cellHeight);
}


- (UICollectionView *)ownCollV{
    if (!_ownCollV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collView.delegate = self;
        collView.dataSource = self;
        collView.backgroundColor = [UIColor clearColor];
        [collView registerClass:[MPAudioUserCell class] forCellWithReuseIdentifier:@"MPAudioUserCellIdentifier"];
        [self addSubview:collView];
        _ownCollV = collView;
    }
    return _ownCollV;
}


- (UICollectionView *)pkOtherCollV{
    if (!_pkOtherCollV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collView.delegate = self;
        collView.dataSource = self;
        collView.backgroundColor = [UIColor clearColor];
        [collView registerClass:[MPAudioUserCell class] forCellWithReuseIdentifier:@"MPAudioUserCellIdentifier"];
        [self addSubview:collView];
        _pkOtherCollV = collView;
    }
    return _pkOtherCollV;
}


- (MicSeatManagerObj *)managerObj{
    if (!_managerObj) {
        _managerObj = [[MicSeatManagerObj alloc] init];
    }
    return _managerObj;
}
@end
