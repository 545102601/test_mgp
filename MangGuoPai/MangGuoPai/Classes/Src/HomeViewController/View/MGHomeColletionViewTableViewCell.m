//
//  MGHomeColletionViewCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/8/28.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeColletionViewTableViewCell.h"

@interface MGHomeColletionViewCell ()
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;


@end

@implementation MGHomeColletionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW(200), SW(140))];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView sd_addSubviews:@[_iconImageView]];
        
    }
    return self;
}


- (void)setIconUrl:(NSString *)iconUrl {
    _iconUrl = iconUrl;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl scaleWidth:_iconImageView.width] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
    
}


@end

@interface MGHomeColletionViewTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) UIView *jobBgView;
@property (nonatomic, strong) UIImageView *jobLineImageView;
@property (nonatomic, strong) UILabel *jobTitleLabel;
@property (nonatomic, strong) UILabel *jobSubTitleLabel;
@property (nonatomic, strong) UICollectionView *colletionView;


@property (nonatomic, copy) NSArray *jobDataDetailArray;

@end

@implementation MGHomeColletionViewTableViewCell


- (void)preapreCellUI {

    /// 工作
    _jobBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(279))];
    _jobLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(16), SH(36), SW(14), SH(42))];
    _jobLineImageView.image = [UIImage imageNamed:@"home_dianzhui"];
    
    _jobTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:MGThemeFont_28];
    _jobTitleLabel.frame = CGRectMake(_jobLineImageView.right + SW(5), SH(42), SW(300), _jobTitleLabel.fontLineHeight);
    _jobTitleLabel.centerY = _jobLineImageView.centerY;
    
    _jobSubTitleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_subTitle_Black font:MGThemeFont_24 textAlignment:NSTextAlignmentRight];
    _jobSubTitleLabel.frame = CGRectMake(kScreenWidth - SW(20) - SH(300), 0, SW(300), _jobSubTitleLabel.fontLineHeight);
    _jobSubTitleLabel.centerY = _jobTitleLabel.centerY;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(SH(15), SW(20), SH(40), SW(20));
    layout.itemSize = CGSizeMake(SW(200), SH(140));
    layout.minimumInteritemSpacing = 0.001;
    layout.minimumLineSpacing = SW(30);
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _jobLineImageView.bottom, kScreenWidth, SH(195)) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.showsVerticalScrollIndicator = NO;
    _colletionView.showsHorizontalScrollIndicator = NO;
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    
    [_colletionView registerClass:[MGHomeColletionViewCell class] forCellWithReuseIdentifier:@"MGHomeColletionViewCellID"];
    
    [_jobBgView sd_addSubviews:@[_jobLineImageView, _jobTitleLabel,
                                 _jobSubTitleLabel, _jobSubTitleLabel,
                                 _colletionView]];
    
    
    [self.contentView sd_addSubviews:@[_jobBgView]];
    
}

#pragma mark - UIColletionViewDelegare

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.jobDataDetailArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MGHomeColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGHomeColletionViewCellID" forIndexPath:indexPath];
    MGResSettingDataDetailModel *model = self.jobDataDetailArray[indexPath.item];
    cell.iconUrl = model.file_path;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self callBackBlockWithIndex:indexPath.item detailModel:self.jobDataDetailArray[indexPath.item]];
}

- (void)callBackBlockWithIndex:(NSInteger)index
                   detailModel:(MGResSettingDataDetailModel *) detailModel{
    if (_didCellItem) {
        _didCellItem(detailModel);
    }
    
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter


- (void)setDataModel:(MGResSettingDataModel *)dataModel {
    _dataModel = dataModel;
    
    MGResSettingDataModel *jobDataModel = dataModel;
    self.jobTitleLabel.text = jobDataModel.title;
    self.jobSubTitleLabel.text = jobDataModel.intro;
    
    
    self.jobDataDetailArray = [jobDataModel.details copy];
    [self.colletionView reloadData];
}



@end
