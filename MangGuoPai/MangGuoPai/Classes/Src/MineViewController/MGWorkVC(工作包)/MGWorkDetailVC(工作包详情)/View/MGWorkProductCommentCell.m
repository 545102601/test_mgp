//
//  MGWorkProductCommentCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/10/16.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGWorkProductCommentCell.h"
#import "MGWorkProductCommentColletionViewCell.h"
#import "SDPhotoBrowser.h"

@interface MGWorkProductCommentCell ()<SDPhotoBrowserDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

/// 奖金bg
@property (nonatomic, strong) UIView *awardBgView;
@property (nonatomic, strong) UIView *leftBgView;
@property (nonatomic, strong) UILabel *awardLabel;

@property (nonatomic, strong) UILabel *teamNameLabel;
@property (nonatomic, strong) UILabel *teamMemberLabel;
@property (nonatomic, strong) UILabel *personLabel;

/// 作品列表
@property (nonatomic, strong) UICollectionView *colletionView;


/// 查看其它方案
@property (nonatomic, strong) UIButton *looOtherFileButton;

@property (nonatomic, strong) UIView *looOtherFileLineView;

@property (nonatomic, strong) UILabel *tutorTipLabel;

@property (nonatomic, strong) UILabel *tutorLabel;

@property (nonatomic, strong) UIView *centerLineView;

@property (nonatomic, strong) UILabel *companyTipLabel;

@property (nonatomic, strong) UILabel *companyLabel;


@end

@implementation MGWorkProductCommentCell

- (void)preapreCellUI {
    
    /// 初始化奖品
    [self setupAwardView];
    /// 初始化作品
    [self setupProductionView];
    /// 初始化评论
    [self setupCommentView];
    
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)looOtherFileButtonOnClick {
    
    if (_lookOtherFileButtonBlock) {
        _lookOtherFileButtonBlock(self.actorModel);
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate
#pragma mark - UIColletionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGWorkProductCommentColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGWorkProductCommentColletionViewCellID" forIndexPath:indexPath];
    cell.url = self.actorModel.works_phote_rsurls[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.actorModel.works_phote_rsurls.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.item;
    photoBrowser.imageCount = self.actorModel.works_phote_rsurls.count;
    photoBrowser.sourceImagesContainerView = self.colletionView;
    [photoBrowser show];
}
#pragma mark - SDPhotoBrowserDelegate
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return nil;
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return [NSURL URLWithString:self.actorModel.works_phote_rsurls[index]];
}
#pragma mark - Public Function

#pragma mark - Private Function

- (void)setupAwardView {
    
    _awardBgView = [[UIView alloc] initWithFrame:CGRectMake(SW(72), SH(10), kScreenWidth - SW(144), SH(114))];
    _awardBgView.backgroundColor = RGB(251, 251, 251);
    
    _leftBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW(150), SH(114))];
    _leftBgView.backgroundColor = RGB(255, 203, 94);
    
    
    _awardLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(36) textAlignment:NSTextAlignmentCenter];
    _awardLabel.frame = CGRectMake(0, 0, _leftBgView.width, _awardLabel.fontLineHeight);
    _awardLabel.centerY = _leftBgView.centerY;
    
    _teamNameLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(28) textAlignment:NSTextAlignmentCenter];
    _teamNameLabel.frame = CGRectMake(_leftBgView.right + SW(20), 0, _awardBgView.width - _leftBgView.width  - SW(40), _teamNameLabel.fontLineHeight);
    _teamNameLabel.centerY = _leftBgView.centerY - SH(20);
    
    _teamMemberLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(28) textAlignment:NSTextAlignmentCenter];
    _teamMemberLabel.frame = CGRectMake(_leftBgView.right + SW(20), 0, _awardBgView.width - _leftBgView.width - SW(40), _teamMemberLabel.fontLineHeight);
    _teamMemberLabel.centerY = _leftBgView.centerY + SH(20);
    
    _personLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(28) textAlignment:NSTextAlignmentCenter];
    _personLabel.frame = CGRectMake(_leftBgView.right + SW(20), 0, _awardBgView.width - _leftBgView.width - SW(40), _personLabel.fontLineHeight);
    _personLabel.centerY = _leftBgView.centerY;
    
    
    
    [_awardBgView sd_addSubviews:@[_leftBgView,
                                   _awardLabel,
                                   _teamMemberLabel,
                                   _teamNameLabel,
                                   _personLabel]];
    
}

- (void)setupProductionView {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat itemWidth = kScreenWidth;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(itemWidth, kMGWorkProductCommentColletionViewCellHeight);
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _awardBgView.bottom, kScreenWidth, 0.001) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.showsVerticalScrollIndicator = NO;
    _colletionView.showsHorizontalScrollIndicator = NO;
    _colletionView.scrollEnabled = NO;
    [_colletionView registerClass:[MGWorkProductCommentColletionViewCell class] forCellWithReuseIdentifier:@"MGWorkProductCommentColletionViewCellID"];
    
    [self.contentView addSubview:_awardBgView];
    [self.contentView addSubview:_colletionView];
    
}

- (void)setupCommentView {
    
    _looOtherFileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _looOtherFileButton.frame = CGRectMake(0, _colletionView.bottom, kScreenWidth, SH(130));
    _looOtherFileButton.titleLabel.font = MGThemeFont_28;
    [_looOtherFileButton setTitle:@"查看其它方案文档" forState:UIControlStateNormal];
    [_looOtherFileButton setTitleColor:MGThemeColor_Common_Black forState:UIControlStateNormal];
    [_looOtherFileButton addTarget:self action:@selector(looOtherFileButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _looOtherFileLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _looOtherFileButton.bottom, kScreenWidth - SW(48), MGSepLineHeight)];
    _looOtherFileLineView.backgroundColor = MGSepColor;
    
    
    _tutorTipLabel = [MGUITool labelWithText:@"导师点评 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _tutorTipLabel.hidden = YES;
    _tutorTipLabel.frame = CGRectMake(SW(45), _looOtherFileLineView.bottom + SH(30), SW(200), _tutorTipLabel.fontLineHeight);
    _tutorLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _tutorLabel.hidden = YES;
    _tutorLabel.frame = CGRectMake(SW(45), _tutorTipLabel.bottom + SH(20), kScreenWidth - SW(90), _tutorTipLabel.fontLineHeight);
    
    _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(SW(24), _tutorLabel.bottom, kScreenWidth - SW(48), MGSepLineHeight)];
    _centerLineView.backgroundColor = MGSepColor;
    _centerLineView.hidden = YES;
    
    _companyTipLabel = [MGUITool labelWithText:@"企业点评 : " textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _companyTipLabel.hidden = YES;
    _companyTipLabel.frame = CGRectMake(SW(45), _centerLineView.bottom + SH(30), SW(200), _companyTipLabel.fontLineHeight);
    
    _companyLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(28)];
    _companyLabel.hidden = YES;
    _companyLabel.frame = CGRectMake(SW(45), _companyTipLabel.bottom + SH(20), kScreenWidth - SW(90), _companyTipLabel.fontLineHeight);
    
    [self.contentView sd_addSubviews:@[_looOtherFileButton,
                                       _looOtherFileLineView,
                                       _tutorTipLabel,
                                       _tutorLabel,
                                       _centerLineView,
                                       _companyTipLabel,
                                       _companyLabel]];
}


#pragma mark - Getter and Setter

- (void)setActorModel:(MGResProjectActorDataModel *)actorModel {
    _actorModel = actorModel;
    
    [self configureAwardWithModel:actorModel];
    [self configureProductionWithModel:actorModel];
    [self configureCommentWithModel:actorModel];
    
}


- (void)configureAwardWithModel:(MGResProjectActorDataModel *)actorModel {
    
    _awardLabel.text = actorModel.awards;
    
    _teamNameLabel.hidden = YES;
    _teamMemberLabel.hidden = YES;
    _personLabel.hidden = YES;
    
    if ([actorModel.actor_type isEqualToString:@"team"]) { /// 团队
        _teamNameLabel.hidden = NO;
        _teamMemberLabel.hidden = NO;
        
        _teamNameLabel.text = [NSString stringWithFormat:@"%@ ( 团队 ) ", actorModel.actor_name];
        NSMutableString *teamMemberName = @"".mutableCopy;
        for (MGResProjectTeamMemberDataModel *memberDataModel in actorModel.team.members) {
            [teamMemberName appendFormat:@"%@、", memberDataModel.nick_name];
        }
        if (teamMemberName.length > 0) {
            _teamMemberLabel.text = [NSString stringWithFormat:@"成员 : %@", [teamMemberName substringToIndex:teamMemberName.length - 1]];
        }
        
    } else {
        _personLabel.hidden = NO;
       
        _personLabel.text = [NSString stringWithFormat:@"%@ ( 个人 ) ", actorModel.actor_name];
    }
    
}

- (void)configureProductionWithModel:(MGResProjectActorDataModel *)actorModel {
    
    NSArray *urlArray = actorModel.works_phote_rsurls;
    
    self.colletionView.height = kMGWorkProductCommentColletionViewCellHeight * urlArray.count;
    [self.colletionView reloadData];
    
    _looOtherFileButton.top = self.colletionView.bottom;
    _looOtherFileLineView.top = _looOtherFileButton.bottom;
    
}

- (void)configureCommentWithModel:(MGResProjectActorDataModel *)actorModel {

    CGFloat marginTop = _looOtherFileLineView.bottom;
    
    if (actorModel.tutor_comments.length > 0) {
        _tutorTipLabel.hidden = NO;
        _tutorLabel.hidden = NO;
        
        _tutorTipLabel.top = _looOtherFileLineView.bottom + SH(30);
        _tutorLabel.top = _tutorTipLabel.bottom + SH(20);
        _tutorLabel.attributedText = actorModel.tutor_comments_attr;
        _tutorLabel.height = actorModel.tutor_comments_height;
        marginTop = _tutorLabel.bottom;
        
    } else {
        _tutorTipLabel.hidden = YES;
        _tutorLabel.hidden = YES;
    }
    
    if (actorModel.company_comments.length > 0) {
        
        if (actorModel.tutor_comments.length > 0) {
            _centerLineView.hidden = NO;
            _centerLineView.top = marginTop + SH(30);
            marginTop = _centerLineView.bottom;
        } else {
            _centerLineView.hidden = YES;
        }
        _companyTipLabel.hidden = NO;
        _companyLabel.hidden = NO;
        
        _companyTipLabel.top = marginTop + SH(30);
        _companyLabel.top = _companyTipLabel.bottom + SH(20);
        _companyLabel.attributedText = actorModel.company_comments_attr;
        _companyLabel.height = actorModel.company_comments_height;
        marginTop = _companyLabel.bottom;
        
    } else {
        _companyTipLabel.hidden = YES;
        _companyLabel.hidden = YES;
        _centerLineView.hidden = YES;
    }
    self.height = marginTop + SH(30);
    
    
}

@end
