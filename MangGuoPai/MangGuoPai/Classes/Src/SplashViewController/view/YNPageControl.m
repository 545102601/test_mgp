//
//  YNPageControl.m
//  test
//
//  Created by ZYN on 16/6/25.
//  Copyright © 2016年 Yongneng Zheng. All rights reserved.
//

#define kDotDiameter	4.0f
#define kDotSpace		12.0f

#import "YNPageControl.h"

@implementation YNPageControl

#pragma mark - init
- (instancetype)initWithType:(YNPageControlType)pageType{
    
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _pageType = pageType;

    }
    return self;

}

- (instancetype)init
{
    self = [self initWithFrame: CGRectZero];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame: CGRectZero]))
    {
        _hidesForSinglePage = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


#pragma mark -
#pragma mark drawRect

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGContextSetAllowsAntialiasing(context, TRUE);
    
    
    CGFloat diameter = (_indicatorDiameter > 0) ? _indicatorDiameter : kDotDiameter;
    CGFloat space = (_indicatorSpace > 0) ? _indicatorSpace : kDotSpace;
    
    CGRect currentBounds = self.bounds;
    CGFloat dotsWidth = self.numberOfPages * diameter + MAX(0, self.numberOfPages - 1) * space;
    CGFloat x = CGRectGetMidX(currentBounds) - dotsWidth / 2;
    CGFloat y = CGRectGetMidY(currentBounds) - diameter / 2;
    
    CGColorRef onColorCG = _onColor ? _onColor.CGColor : [UIColor colorWithWhite: 1.0f alpha: 1.0f].CGColor;
    CGColorRef offColorCG = _offColor ? _offColor.CGColor : [UIColor colorWithWhite: 0.7f alpha: 0.5f].CGColor;
    
    
    for (int i = 0; i < _numberOfPages; i++)
    {
        CGRect dotRect = CGRectMake(x, y, diameter, diameter);
        
        if (i == _currentPage)
        {
            if (_pageType == YNPageControlTypeOnFullOffFull || _pageType == YNPageControlTypeOnFullOffEmpty)
            {
                if (self.insetColor) {
                    CGContextSetFillColorWithColor(context, self.insetColor.CGColor);
                    CGContextFillEllipseInRect(context, CGRectInset(dotRect, 0, 0));
                }
                CGContextSetFillColorWithColor(context, onColorCG);
                CGContextFillEllipseInRect(context, CGRectInset(dotRect, -0.5f, -0.5f));
            }
            else
            {
                if (self.insetColor) {
                    CGContextSetFillColorWithColor(context, self.insetColor.CGColor);
                    CGContextFillEllipseInRect(context, CGRectInset(dotRect, 0, 0));
                }
                CGContextSetStrokeColorWithColor(context, onColorCG);
                CGContextStrokeEllipseInRect(context, dotRect);
                
            }
        }
        else
        {
            if (_pageType == YNPageControlTypeOnEmptyOffEmpty || _pageType == YNPageControlTypeOnFullOffEmpty)
            {
                if (self.insetColor) {
                    CGContextSetFillColorWithColor(context, self.insetColor.CGColor);
                    CGContextFillEllipseInRect(context, CGRectInset(dotRect, 0, 0));
                }
                CGContextSetStrokeColorWithColor(context, offColorCG);
                CGContextStrokeEllipseInRect(context, CGRectInset(dotRect, -0.5f, -0.5f));
            }
            else
            {  if (self.insetColor) {
                CGContextSetFillColorWithColor(context, self.insetColor.CGColor);
                CGContextFillEllipseInRect(context, CGRectInset(dotRect, 0, 0));
            }
                CGContextSetFillColorWithColor(context, offColorCG);
                CGContextFillEllipseInRect(context, CGRectInset(dotRect, -0.5f, -0.5f));
            }
        }
        
        x += diameter + space;
    }
    
    
    CGContextRestoreGState(context);
}


#pragma mark - Actions


- (void)setCurrentPage:(NSInteger)currentPage{
    
    if (_currentPage == currentPage) return;
    
    _currentPage = MIN(MAX(0, currentPage), _numberOfPages - 1);
    
    if (!self.defersCurrentPageDisplay) {
        [self setNeedsDisplay];
    }
    
}


- (void)setNumberOfPages:(NSInteger)numberOfPages{
    
    _numberOfPages = MAX(0, numberOfPages);
    
    _currentPage = MIN(MAX(0, _currentPage), _numberOfPages - 1);
    
    self.bounds = self.bounds;
    
    [self setNeedsDisplay];
    
    if (_hidesForSinglePage && (_numberOfPages < 2))
        [self setHidden: YES];
    else
        [self setHidden: NO];
}

- (void)setHidesForSinglePage:(BOOL)hide
{
    _hidesForSinglePage = hide;
    
    if (_hidesForSinglePage && (_numberOfPages < 2))
        [self setHidden: YES];
}


- (void)setType:(YNPageControlType)aType
{
    _pageType = aType;
    
    [self setNeedsDisplay];
}

- (void)setOnColor:(UIColor *)aColor
{
    
    _onColor = aColor;
    
    [self setNeedsDisplay];
}

- (void)setOffColor:(UIColor *)aColor
{
    
    _offColor = aColor;
    
    [self setNeedsDisplay];
}

- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter{
    
    _indicatorDiameter = indicatorDiameter;
    
    self.bounds = self.bounds;
    
    [self setNeedsDisplay];
}

- (void)setIndicatorSpace:(CGFloat)indicatorSpace{

    _indicatorSpace = indicatorSpace;
    
    self.bounds = self.bounds;
    
    [self setNeedsDisplay];
    
}

- (void)setFrame:(CGRect)aFrame
{
    aFrame.size = [self sizeForNumberOfPages: _numberOfPages];
    super.frame = aFrame;
}

- (void)setBounds:(CGRect)aBounds
{
    aBounds.size = [self sizeForNumberOfPages: _numberOfPages];
    super.bounds = aBounds;
}

#pragma mark - 
#pragma mark UIPageControl Methods

- (void)updateCurrentPageDisplay{
    
    if (!self.defersCurrentPageDisplay) return;
    
    [self setNeedsDisplay];

}
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    CGFloat diameter =_indicatorDiameter > 0 ? _indicatorDiameter : kDotDiameter;
    CGFloat space = (_indicatorSpace > 0) ? _indicatorSpace : kDotSpace;
    
    return CGSizeMake(pageCount * diameter + (pageCount - 1) * space + 44.0f, MAX(44.0f, diameter + 4.0f));
}

//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *theTouch = [touches anyObject];
//    CGPoint touchLocation = [theTouch locationInView: self];
//    
//    if (touchLocation.x < (self.bounds.size.width / 2))
//        self.currentPage = MAX(self.currentPage - 1, 0);
//    else
//        self.currentPage = MIN(self.currentPage + 1, _numberOfPages - 1);
//    
//    [self sendActionsForControlEvents: UIControlEventValueChanged];
//}


@end
