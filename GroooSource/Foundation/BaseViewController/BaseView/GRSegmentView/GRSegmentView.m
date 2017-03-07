//
//  GRSegmentView.m
//  GroooSource
//
//  Created by Assuner on 2017/3/7.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRSegmentView.h"
#import "GRSegmentHeadView.h"

@interface GRSegmentView () <UIScrollViewDelegate>

@property (nonatomic, strong) GRSegmentHeadView *headView;
@property (nonatomic, strong) UIScrollView *baseView;
@property (nonatomic, assign) CGFloat subviewHight;
@property (nonatomic, assign) NSUInteger scrollCount;

@end

@implementation GRSegmentView

- (instancetype)initWithSubviewArray:(NSArray<UIView *> *)subviewArray titleArray:(NSArray<NSString *> *)titleArray orignY:(CGFloat)orignY {
    if (self = [super init]) {
        self.orignY = orignY;
        self.scrollCount = subviewArray.count;
        if (!self.scrollCount) {
            return nil;
        }
        self.subViewsArray = subviewArray;
        if (subviewArray[0]) {
            self.subviewHight = subviewArray[0].gr_height;
        }
        self.frame = CGRectMake(0, _orignY, SCREEN_WIDTH, _subviewHight + 44);
        [self initHeadView];
        [self initBaseView];
        self.titleArray = titleArray;
    }
    return self;
}

- (void)initHeadView {
    self.headView = [[GRSegmentHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headView];
   }

- (void)initBaseView {
    self.baseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, _subviewHight)];
    self.baseView.contentSize = CGSizeMake(SCREEN_WIDTH * _scrollCount, _subviewHight);
    self.baseView.pagingEnabled = YES;
    self.baseView.alwaysBounceVertical = NO;
    self.baseView.alwaysBounceHorizontal = YES;
    self.baseView.showsVerticalScrollIndicator = NO;
    self.baseView.showsHorizontalScrollIndicator = NO;
    self.baseView.delegate = self;
    [self addSubviews];
    [self addSubview:self.baseView];

}

- (void)addSubviews {
    for (UIView *view in _subViewsArray) {
        if (view) {
            [_baseView addSubview:view];
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.baseView.backgroundColor = backgroundColor;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    if (titleArray.count) {
        _titleArray = titleArray;
        _headView.titleArray = titleArray;
    }
}

#pragma - Scrollview 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect rect = self.headView.slideLine.frame;
    CGFloat offset = scrollView.contentOffset.x / scrollView.contentSize.width * scrollView.frame.size.width + (scrollView.frame.size.width/3 - rect.size.width)/2;
    self.headView.slideLine.frame = CGRectMake(offset, rect.origin.y, rect.size.width, rect.size.height);
}

@end
