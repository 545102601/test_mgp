//
//  MGHomeFunctionCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/11.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGHomeFunctionCell.h"
#import "MGResClassifyModel.h"
#import <UIButton+WebCache.h>
#import "MGResSettingModel.h"

/// cell
@interface MGHomeFunctionColletionViewCell () <UIScrollViewDelegate>
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MGHomeFunctionColletionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW(100), SW(100))];
        
        _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(22) textAlignment:NSTextAlignmentCenter];
        _titleLabel.frame = CGRectMake(0, _iconImageView.bottom + SH(14), 0, _titleLabel.fontLineHeight);
        
    
        [self.contentView sd_addSubviews:@[_iconImageView, _titleLabel]];
        
    }
    return self;
}


- (void)setIconUrl:(NSString *)iconUrl {
    _iconUrl = iconUrl;
    if (self.id > 0 ) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl scaleWidth:_iconImageView.width] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
    } else {
        self.iconImageView.image = nil;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    
    self.titleLabel.text = titleText;
    self.titleLabel.width = [_titleText widthForFont:self.titleLabel.font];
    self.titleLabel.centerX = self.contentView.width * 0.5;
}


@end



@interface MGHomeFunctionCell () <UICollectionViewDelegate, UICollectionViewDataSource>

/// 列表
@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) UIPageControl *pageControl;
/// 工作包
@property (nonatomic, strong) UIButton *workButton;
/// 课程
@property (nonatomic, strong) UIButton *classButton;

@end

@implementation MGHomeFunctionCell

- (void)preapreCellUI {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(SH(32), SW(54), SH(68), SW(54));
    layout.itemSize = CGSizeMake(SW(100), SH(240) - SH(68) - SH(32));
    layout.minimumInteritemSpacing = 0.001;
    layout.minimumLineSpacing = SW(78);
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(240)) collectionViewLayout:layout];
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.showsVerticalScrollIndicator = NO;
    _colletionView.showsHorizontalScrollIndicator = NO;
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.pagingEnabled = YES;
    [_colletionView registerClass:[MGHomeFunctionColletionViewCell class] forCellWithReuseIdentifier:@"MGHomeFunctionColletionViewCellID"];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SH(240) - SW(40), _colletionView.width, SH(10))];
    _pageControl.currentPageIndicatorTintColor = MGThemeBackgroundColor;
    _pageControl.pageIndicatorTintColor = MGTextPlaceholderColor;
    _pageControl.currentPage = 0;
    
    
    _workButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(workButtonClick)];
    _workButton.frame = CGRectMake(SW(20), _colletionView.bottom, SW(340), SH(140));
    
    
    _classButton = [MGUITool buttonWithNorBgImage:nil selBgImage:nil norImage:nil selImage:nil target:self selector:@selector(classButtonClick)];
    _classButton.frame = CGRectMake(kScreenWidth - SW(20) - SW(340), _colletionView.bottom, SW(340), SH(140));
    
    [self.contentView sd_addSubviews:@[_colletionView, _pageControl, _workButton , _classButton]];
}
#pragma mark - UIColletionViewDelegare

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MGHomeFunctionColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGHomeFunctionColletionViewCellID" forIndexPath:indexPath];
    MGResClassifyDataModel *model = self.dataArray[indexPath.item];
    cell.id = model.id;
    cell.iconUrl = model.logo_rsurl;
    cell.titleText = model.classify_name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [self callBackBlockWithIndex:indexPath.item];
}

- (void)callBackBlockWithIndex:(NSInteger)index {
    
    if (index == 1000) {
        if (_didCellItemBlock) {
            _didCellItemBlock(index);
        }
    } else if (index == 1001) {
        if (_didCellItemBlock) {
            _didCellItemBlock(index);
        }
    } else {
        
        MGResClassifyDataModel *model = self.dataArray[index];
        if (model.id > 0) {
            if (_didCellItemBlock) {
                _didCellItemBlock(index);
            }
        }
        
    }
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _pageControl.width = Screen_Width;
}
#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response
- (void)workButtonClick {
    if (self.wordAndArray.count > 1) {

        MGResSettingDataDetailModel *detailModel_1 = self.wordAndArray[0];
        if (_wordAndClassBlock) {
            _wordAndClassBlock(detailModel_1);
        }
    }
    
}
- (void)classButtonClick {
    if (self.wordAndArray.count > 1) {
        
        MGResSettingDataDetailModel *detailModel_2 = self.wordAndArray[1];
        if (_wordAndClassBlock) {
            _wordAndClassBlock(detailModel_2);
        }
        
    }
    
}
#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 过一半切换pageControl
    self.pageControl.currentPage = roundf(scrollView.contentOffset.x / scrollView.width);

}
#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter



- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = [dataArray copy];
 
    _pageControl.numberOfPages = ceil(dataArray.count / 4.0);
   
    [_colletionView reloadData];
}

- (void)setWordAndArray:(NSArray *)wordAndArray {
    _wordAndArray = [wordAndArray copy];
    
    if (wordAndArray.count > 1) {
        
        MGResSettingDataDetailModel *detailModel_1 = wordAndArray[0];
        [self.workButton sd_setImageWithURL:[NSURL URLWithString:detailModel_1.file_path scaleWidth:self.workButton.width] forState:UIControlStateNormal placeholderImage:SDWEB_PLACEHODER_IMAGE(self.workButton)];
        
        
        MGResSettingDataDetailModel *detailModel_2 = wordAndArray[1];
        [self.classButton sd_setImageWithURL:[NSURL URLWithString:detailModel_2.file_path scaleWidth:self.classButton.width] forState:UIControlStateNormal placeholderImage:SDWEB_PLACEHODER_IMAGE(self.classButton)];
        
    }
    
    
}


@end
