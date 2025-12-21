//
//  MusicPlayVC.m
//  LiveCommon
//
//  Created by klc on 2020/8/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MusicPlayVC.h"
#import <LibTools/LibTools.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayingCell.h"
#import "MusicSouceCell.h"
#import <LibProjModel/HttpApiAppMusic.h>
#import <LibProjView/ForceAlertController.h>
#import <MJRefresh.h>
#import "MiniPlayerView.h"
#import <LiveCommon/LiveManager.h>

@interface MusicPlayVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong)UISearchBar *searchBar; ///搜索框
@property (nonatomic, strong)UILabel *playingCountLab; ///播放列表的歌曲个数
@property (nonatomic, strong)UILabel *sourceCountLab; ///搜索资源的文字
@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, strong)UITableView *playingTbView;
@property (nonatomic, strong)UITableView *sourceTbView;
@property (nonatomic, strong)UIView *slider;
@property (nonatomic, copy) NSArray<UIButton *> *btnArr;  ///标题

kStrong(NSMutableArray, playingDataArray) ///播放的列表数据
kStrong(NSMutableArray, sourceDataArray) ///资源数据

kAssign(NSUInteger, pageIndex)
kAssign(CGFloat, sliderTotalDistance)


kAssign(PlayMusicMode, playMode) ///当前的播放模式


@property (nonatomic, copy)NSArray *modeArray;  ///播放模式

///----------------音乐相关-----
@property (nonatomic, strong) AppUserMusicDTOModel *currentMusicModel; ///当前播放的音乐
@property (nonatomic, assign) BOOL isCurrentPause;   ///当前音乐是否是暂停状态（默认不暂停）


@end

@implementation MusicPlayVC

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self createUI];
    [self loadPlayListRequestData:YES];
    ///已在马上显示的页面中刷新数据
//    [self loadSourceRequestDataIsRefresh:YES];
}

#pragma mark - view -

-(void)setup{
    
    _playingDataArray = [NSMutableArray array];
    _sourceDataArray = [NSMutableArray array];
    
    _modeArray = @[@(playModeListLoop),@(playModeRandom)];
    _playMode = [_modeArray[0] integerValue];
    _volume = 100;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _bgScrollView.contentSize = CGSizeMake(_playingTbView.frame.size.width*2, _playingTbView.frame.size.height);
    _sliderTotalDistance = _btnArr.lastObject.centerX-_btnArr.firstObject.centerX;
}


-(void)createUI{
    kWeakSelf(self);
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *topBgView = [Maker viewWithShadow:NO backColor:[UIColor whiteColor] superView:self.view constraints:^(MASConstraintMaker * _Nonnull make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    UIView *line = [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#DEDEDE") superView:topBgView constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.height.mas_equalTo(1);
        make.bottom.left.right.equalTo(topBgView);
    }];
    NSArray *titles = @[kLocalizationMsg(@"播放列表"),kLocalizationMsg(@"音乐库")];
    NSMutableArray *btnMuArr = [[NSMutableArray alloc] init];
    for (int i=0; i<2; i++) {
        
        UIButton *btn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:titles[i] textColor:[UIColor blackColor] font:kFont(13) superView:topBgView constraints:^(MASConstraintMaker * _Nonnull make) {
            make.centerY.equalTo(topBgView);
            if (i==0) {
                make.left.equalTo(topBgView).offset(85);
            }else{
                
                make.right.equalTo(topBgView).inset(85);
            }
        }];
        [btnMuArr addObject:btn];
        [btn addTarget:self action:@selector(topMenuTapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _btnArr = btnMuArr;
    CGSize size = [kLocalizationMsg(@"播放列表") sizeWithAttributes:@{NSFontAttributeName:kFont(13)}];
    _slider = [Maker viewWithShadow:NO backColor:[UIColor blackColor] superView:topBgView constraints:^(MASConstraintMaker * _Nonnull make) {
        make.size.mas_equalTo(SIZE(26, 2));
        make.bottom.equalTo(line.mas_top);
        make.centerX.equalTo(self.view.mas_left).offset(85+size.width/2);
    }];
    _slider.layer.cornerRadius = 1;
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _bgScrollView.contentSize = SIZE(kScreenWidth*2, 0);
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.delegate = self;
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_bgScrollView];
    
    [_bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBgView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    _playingTbView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (kiOS11) {
        _playingTbView.insetsContentViewsToSafeArea = NO;
    }
    if (kiOS(15)) {
        _playingTbView.sectionHeaderTopPadding = 0;
    }
    _playingTbView.delegate = self; _playingTbView.dataSource = self;
    [_bgScrollView addSubview:_playingTbView];
    [_playingTbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_bgScrollView);
        make.height.equalTo(_bgScrollView).mas_offset(_bgScrollView.height);
        make.center.equalTo(_bgScrollView);
        make.top.equalTo(_bgScrollView);
    }];
    _playingTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _playingTbView.tableFooterView = [UIView new];
    _playingTbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadPlayListRequestData:YES];
    }];
    _playingTbView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadPlayListRequestData:NO];
    }];
    _playingTbView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    
    _sourceTbView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (kiOS11) {
        _sourceTbView.insetsContentViewsToSafeArea = NO;
    }
    if (kiOS(15)) {
        _sourceTbView.sectionHeaderTopPadding = 0;
    }
    _sourceTbView.delegate = self; _sourceTbView.dataSource = self;
    [_bgScrollView addSubview:_sourceTbView];
    [_sourceTbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_bgScrollView);
        make.height.equalTo(_bgScrollView).mas_offset(_bgScrollView.height);
        make.centerX.equalTo(_bgScrollView).offset(kScreenWidth);
        make.top.equalTo(_bgScrollView);
    }];
    _sourceTbView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _sourceTbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _sourceTbView.tableFooterView = [UIView new];
    _sourceTbView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadSourceRequestDataIsRefresh:NO];
    }];
    _sourceTbView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    
}

-(void)topMenuTapAction:(UIButton *)sender{
    _pageIndex = [_btnArr indexOfObject:sender];
    [_bgScrollView setContentOffset:POINT(kScreenWidth*_pageIndex, 0) animated:YES];
}

-(void)updateTopBarBy:(CGFloat)ratio{
    UIButton *sender = _btnArr[_pageIndex];
    CGFloat center_x = [kLocalizationMsg(@"播放列表") sizeWithAttributes:@{NSFontAttributeName:kFont(13)}].width/2+85;
    [UIView animateWithDuration:0.6 animations:^{
        [self->_slider mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_left).offset(center_x+self->_sliderTotalDistance*ratio);
        }];
    }];
    [self.view layoutIfNeeded];
    for (UIButton *btn in _btnArr) {
        BOOL isChoosed = btn==sender;
        [btn setTitleColor:isChoosed?[UIColor blackColor]:[UIColor grayColor] forState:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_bgScrollView) {
        CGFloat ratio = scrollView.contentOffset.x/kScreenWidth;
        NSUInteger index = scrollView.contentOffset.x/kScreenWidth;
        _pageIndex = index;
        [self updateTopBarBy:ratio];
        [_searchBar resignFirstResponder];
    }
}

#pragma mark  - tableviewDelegate  -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView==_playingTbView?_playingDataArray.count:_sourceDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    if (tableView==_playingTbView) {
        NSString * cellIdentifier = @"music_playing_cell";
        MusicPlayingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[MusicPlayingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (_playingDataArray.count > indexPath.row) {
            AppUserMusicDTOModel *model = _playingDataArray[indexPath.row];
            cell.model = model;
            cell.sort = indexPath.row+1;
            cell.isPlaying = (model.id_field == _currentMusicModel.id_field)?YES:NO;
            cell.isPause = _isCurrentPause;
            cell.removeFromListHandler = ^(NSUInteger index) {
                [weakself removeAlertShow:model];
            };
        }
        return cell;
    }else{
        NSString * cid = @"music_souce_cell";
        MusicSouceCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
        if (!cell) {
            cell = [[MusicSouceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (_sourceDataArray.count > indexPath.row) {
            AppMusicDTOModel *currentModel = _sourceDataArray[indexPath.row];
            cell.model = currentModel;
            cell.addToListHandler = ^(AppMusicDTOModel * _Nonnull model) {
                [weakself addToPlayingList:model];
            };
        }
        return cell;
    }
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView ==_playingTbView) {
        UIView *header = [[UIView alloc] initWithFrame:RECT(0, 0, kScreenWidth, 34)];
        header.backgroundColor = kRGB_COLOR(@"#F7F7F7");
        _playingCountLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:kStringFormat(kLocalizationMsg(@"共%lu首"),(unsigned long)_playingDataArray.count) textColor:kRGB_COLOR(@"#BBBBBB") font:kFont(14) superView:header constraints:^(MASConstraintMaker * _Nonnull make) {
            
            make.left.equalTo(header).offset(12);
            make.centerY.equalTo(header);
        }];
        return header;
        
    }else{
        UIView *header = [[UIView alloc] initWithFrame:RECT(0, 0, kScreenWidth, 54)];
        header.backgroundColor = [UIColor whiteColor];
        [header addSubview:self.searchBar];
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header).offset(12);
            make.left.equalTo(header).offset(15);
            make.centerX.equalTo(header);
            make.height.mas_equalTo(30);
        }];
        [header addSubview:self.sourceCountLab];
        [self.sourceCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header).offset(12);
            make.top.equalTo(self.searchBar.mas_bottom).offset(8);
        }];
        return header;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableView == _playingTbView?35:54;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==_playingTbView) {
        [self changePlayingIndex:indexPath.row tableView:tableView];
    }
}


#pragma mark  - 数据操作 -
///获取用户的播放列表
-(void)loadPlayListRequestData:(BOOL)isRefresh{
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = isRefresh?0:(int)self.playingDataArray.count/pageSize  + (self.playingDataArray.count%pageSize?1:0);
    [HttpApiAppMusic queryMyMusicList:@"" pageIndex:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<AppUserMusicDTOModel *> *arr) {
        [SVProgressHUD dismiss];
        [weakself.playingTbView.mj_header endRefreshing];
        [weakself.playingTbView.mj_footer endRefreshing];
        if (code == 1) {
            if (isRefresh) {
                [weakself.playingDataArray removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.playingDataArray addObjectsFromArray:arr];
            }
            if (arr.count < kPageSize) {
                [weakself.playingTbView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.playingTbView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


///获取音乐库的文件
-(void)loadSourceRequestDataIsRefresh:(BOOL)isRefresh{
    [_searchBar resignFirstResponder];
    kWeakSelf(self);
    int pageSize = kPageSize;
    int pageIndex = isRefresh?0:(int)self.sourceDataArray.count/pageSize + (self.sourceDataArray.count%pageSize?1:0);
    [HttpApiAppMusic queryList:self.searchBar.text pageIndex:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<AppMusicDTOModel *> *arr) {
        [SVProgressHUD dismiss];
        [weakself.sourceTbView.mj_header endRefreshing];
        [weakself.sourceTbView.mj_footer endRefreshing];
        if (code == 1) {
            if (isRefresh) {
                [weakself.sourceDataArray removeAllObjects];
            }
            if (arr.count > 0) {
                [weakself.sourceDataArray addObjectsFromArray:arr];
            }
            if (arr.count < kPageSize) {
                [weakself.sourceTbView.mj_footer endRefreshingWithNoMoreData];
            }
            [weakself.sourceTbView reloadData];
            
            if (weakself.searchBar.text.length > 0) {
                weakself.sourceCountLab.text = [NSString stringWithFormat:kLocalizationMsg(@"搜索到%zi首歌曲"), self.sourceDataArray.count];
            }else{
                weakself.sourceCountLab.text = @"";
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


//点歌/切歌
-(void)changePlayingIndex:(NSInteger)index tableView:(UITableView *)tableView{
    ///如果是当前正在播放的cell
    MusicPlayingCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    ///音乐如果在播放
    if (cell.isPlaying) {
        cell.isPause = !cell.isPause;
        [self pauseMusic:cell.isPause];
        return;
    }
    if (_playingDataArray.count == 0) { return; }
    
    ///不是当前播放的cell
    AppUserMusicDTOModel * theModel = _playingDataArray[index];
    _currentMusicModel = theModel;
    _isCurrentPause = NO;
    
    if (self.delegate) { //开始播放
        [self.delegate musicDidPlay:theModel];
        [self.delegate changePlayMode:_playMode];
        [_playingTbView reloadData];
    }
}


///停止播放
- (void)stopPlaySong{
    _isCurrentPause = NO;
    _currentMusicModel = nil;
    [_playingTbView reloadData];
}

- (void)playCompleted{
    if (_playingDataArray.count == 1) {
        [self stopPlaySong];
    }
    [self playNextSong];
    
}

//下一首
-(void)playNextSong{
    NSInteger playingIndex = [_playingDataArray indexOfObject:_currentMusicModel];
    if (_currentMusicModel == playModeSquence && playingIndex == _playingDataArray.count-1) {
        HudShowString(kLocalizationMsg(@"这是最后一首啦"))
    }
    [self changePlayMusic:YES];
}

//上一首
-(void)playPreviousSong{
    NSInteger playingIndex = [_playingDataArray indexOfObject:_currentMusicModel];
    if (_currentMusicModel == playModeSquence && playingIndex == 0) {
        HudShowString(kLocalizationMsg(@"这是第一首啦"))
    }
    [self changePlayMusic:NO];
}

///改变播放模式
- (void)playModeDidChange{
    NSUInteger index = [_modeArray indexOfObject:@(_playMode)];
    index++;
    if (index == _modeArray.count) {index = 0;}
    _playMode = [_modeArray[index] integerValue];
    
    if (self.delegate) {
        [self.delegate changePlayMode:_playMode];
    }
}


- (void)playStateDidChange:(BOOL)isPlaying {
    if (_currentMusicModel) {
        NSInteger playingIndex = [_playingDataArray indexOfObject:_currentMusicModel];
        MusicPlayingCell *cell = [_playingTbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:playingIndex inSection:0]];
        cell.isPause = !isPlaying;
        [self pauseMusic:!isPlaying];
    }else{
        //若无播放，默认从第一首播放
        [self changePlayingIndex:0 tableView:_playingTbView];
    }
}

///上一首或者下一首歌
- (void)changePlayMusic:(BOOL)isNext{
    if (_playingDataArray.count == 0) {
        return;
    }
    if (_playingDataArray.count == 1 && [self isMusicPlayed]) {
        return;
    }
    
    NSInteger playingIndex = [_playingDataArray indexOfObject:_currentMusicModel];
    switch (_playMode) {
        case playModeListLoop:  ///循环播放
        {
            if (playingIndex < _playingDataArray.count) {
                if (isNext) {
                    if (playingIndex == _playingDataArray.count-1) {
                        playingIndex = 0;
                    }else{ playingIndex++; }
                }else{
                    if (playingIndex == 0) {
                        playingIndex = _playingDataArray.count-1;
                    }else{ playingIndex--; }
                }
            }else{
                playingIndex = 0;
            }
        }
            break;
        case playModeRandom: ///随机播放
        {
            playingIndex = [self playRandomSong:playingIndex];
        }
            break;
        case playModeOneLoop: ///单曲循环
        {
            
        }
            break;
        default:   ///顺序播放
        {
            if (playingIndex < _playingDataArray.count) {
                if (isNext) {
                    if (playingIndex == _playingDataArray.count-1) { return;}
                    playingIndex++;
                }else{
                    if (playingIndex == 0) { return;}
                    playingIndex--;
                }
            }else{
                playingIndex = 0;
            }
        }
            break;
    }
    if (_currentMusicModel == nil) {
        playingIndex = 0;
    }
    [self changePlayingIndex:playingIndex tableView:self.playingTbView];
}


//随机播放(伪随机,暂且做成切上下都随机)
-(NSInteger)playRandomSong:(NSInteger)playIndex{
    
    if (self.playingDataArray.count <2) {
        return playIndex;
    }else{
        NSInteger index =  arc4random()%self.playingDataArray.count;
        if (index == playIndex) {
            index = [self playRandomSong:playIndex];
        }
        return index;
    }
}


//停止播放音乐
-(void)stopPlay{
    [self stopPlaySong];
    if (self.delegate) {
        [self.delegate musicDidStop];
    }
}

-(void)removeAlertShow:(AppUserMusicDTOModel *)model{
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:kLocalizationMsg(@"确认要移除列表吗")];
    [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alert addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_NormalColor clickHandle:^{
        [self removeFromPlayingList:model];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)removeFromPlayingList:(AppUserMusicDTOModel *)model{
    /// 2移除
    kWeakSelf(self);
    [HttpApiAppMusic setMusic:model.musicId type:2 callback:^(int code, NSString *strMsg, HttpNoneModel *noneModel) {
        if (code == 1) {
            if (model.id_field == weakself.currentMusicModel.id_field) {
                [self stopPlay];
            }
            [self loadPlayListRequestData:YES];
            [self loadSourceRequestDataIsRefresh:YES];
        }else{
            
            HudShowError(strMsg)
        }
    }];
}



-(void)addToPlayingList:(AppMusicDTOModel *)model{
    //1添加
    [HttpApiAppMusic setMusic:model.id_field type:1 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [self loadPlayListRequestData:YES];
            [self loadSourceRequestDataIsRefresh:YES];
        }else{
            HudShowError(strMsg)
        }
    }];
}


-(void)pauseMusic:(BOOL)isPause{
    _isCurrentPause = isPause;
    if (self.delegate) {
        isPause?[self.delegate musicDidPause]:[self.delegate musicDidResume];
    }
}


- (BOOL)isMusicPlayed{
    if (_currentMusicModel) {
        NSInteger playingIndex = [_playingDataArray indexOfObject:_currentMusicModel];
        MusicPlayingCell *cell = [_playingTbView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:playingIndex inSection:0]];
        return !cell.isPause;
    }else{
        return NO;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_searchBar resignFirstResponder];
}

- (UILabel *)sourceCountLab{
    if (!_sourceCountLab) {
        _sourceCountLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _sourceCountLab.text = @"";
        _sourceCountLab.textColor = kRGB_COLOR(@"#BBBBBB");
        _sourceCountLab.font = kFont(12);
    }
    return _sourceCountLab;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.placeholder = kLocalizationMsg(@"搜索歌曲或歌手");
        _searchBar.barTintColor = kRGB_COLOR(@"#F1F1F1");
        _searchBar.barStyle = UISearchBarStyleMinimal;
        _searchBar.layer.cornerRadius = 4;
        _searchBar.delegate = self;
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.backgroundImage = [UIImage new];
        if (@available(iOS 13.0, *)) {
            _searchBar.searchTextField.font = kFont(12);
            _searchBar.searchTextField.rightViewMode = UITextFieldViewModeWhileEditing;
        }
        [self setSearchBarCancelBtn:_searchBar];
    }
    return _searchBar;
}


#pragma mark SearchBar Delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    [self setSearchBarCancelBtn:searchBar];
    return YES;
}


-(void)setSearchBarCancelBtn:(UISearchBar *)searchBar{
    for(UIView *view in searchBar.subviews.firstObject.subviews){
        //iOS13 开始多出来的层级
        if ([view isKindOfClass:NSClassFromString(@"_UISearchBarSearchContainerView")]) {
            
            for (UIView *sub in view.subviews) {
                
                if ([sub isKindOfClass:NSClassFromString(@"UINavigationButton")]){
                    
                    UIButton *btn = (UIButton *)sub;
                    [btn setTitle:kLocalizationMsg(@"取消") forState:0];
                    btn.titleLabel.font = kFont(13);
                }
            }
            
        }
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self loadSourceRequestDataIsRefresh:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self loadSourceRequestDataIsRefresh:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    HudShowStatus(kLocalizationMsg(@"搜索中..."))
    [self loadSourceRequestDataIsRefresh:YES];
}

- (void)closeView{
    [self.view endEditing:YES];
    [[PopupTool share] closePopupView:self.view animate:YES];
}

- (void)show{
    self.view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight*2.0/3.0);
    [self.view cornerRadii:CGSizeMake(8, 8) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    [[PopupTool share] createPopupViewWithLinkView:self.view allowTapOutside:YES popupBgViewAction:@selector(closeView) popupBgViewTarget:self cover:NO];
    [[PopupTool share] animationShowPopupView:self.view];
    [self loadSourceRequestDataIsRefresh:YES];
}


- (void)dismiss{
    [_searchBar removeFromSuperview];
    _searchBar = nil;
    [_playingCountLab removeFromSuperview];
    _playingCountLab = nil;
    [_sourceCountLab removeFromSuperview];
    _sourceCountLab = nil;
    [_bgScrollView removeFromSuperview];
    _bgScrollView = nil;
    [_playingTbView removeFromSuperview];
    _playingTbView = nil;
    [_sourceTbView removeFromSuperview];
    _sourceTbView = nil;
    [_slider removeFromSuperview];
    _slider = nil;
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _currentMusicModel = nil;
    _btnArr = nil;
    [_playingDataArray removeAllObjects];
    [_sourceDataArray removeAllObjects];
    _playingDataArray = nil;
    _sourceDataArray = nil;
    [self closeView];
    
}

@end
