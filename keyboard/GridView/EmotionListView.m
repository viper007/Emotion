//
//  EmotionListView.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/6.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define rowCount 3
#define colCount 7
#define perPageCount (colCount*rowCount-1)

#import "EmotionListView.h"
#import "EmotionView.h"

@interface EmotionListView () <UIScrollViewDelegate>
@property (nonatomic ,weak) UIScrollView   *scrollView;
@property (nonatomic ,weak) UIPageControl  *pageControl;

@end

@implementation EmotionListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = true;
    scrollView.alwaysBounceHorizontal = true;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.backgroundColor = [UIColor whiteColor];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];//_currentPageImage
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = 30;
    CGFloat y = self.frame.size.height - height;
    self.pageControl.frame = CGRectMake(0, y, self.frame.size.width, height);
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, y);
    //
    CGFloat count = self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.frame.size.width;
    CGFloat gridH = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        EmotionView *gridView = self.scrollView.subviews[i];
        gridView.frame = CGRectMake(i * gridW, 0, gridW, gridH);
    }
}
#pragma mark - 数据源
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    NSUInteger totalPage = (emotions.count + perPageCount - 1)/perPageCount;
    NSUInteger loc = 0;
    NSUInteger len = perPageCount;
    for (int i = 0; i < totalPage; i++) {
        EmotionView *emotionView = nil;
        if (i < self.scrollView.subviews.count) {
            emotionView = self.scrollView.subviews[i];
        }else {
            emotionView = [[EmotionView alloc] init];
            
            emotionView.frame = CGRectMake(i * self.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [self.scrollView addSubview:emotionView];
        }
        loc = i * perPageCount;
        if (loc + len > emotions.count) {
            len = emotions.count - loc;
        }
        NSRange range = NSMakeRange(loc, len);
        emotionView.emotions = [emotions subarrayWithRange:range];
        emotionView.hidden = NO;
    }
    //
    for (NSUInteger i = totalPage; i < self.scrollView.subviews.count; i++) {
        EmotionView *emotionView = self.scrollView.subviews[i];
        emotionView.hidden = YES;
    }

    self.pageControl.numberOfPages = totalPage;
    self.pageControl.currentPage = 0;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*totalPage, 0);
    [self setNeedsLayout];
    self.scrollView.contentOffset = CGPointZero;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
}
#pragma mark - Inner Method
- (void)pageChanged:(UIPageControl *)pageControl {
    //根据对应
    [self.scrollView setContentOffset:CGPointMake(pageControl.currentPage * self.frame.size.width, 0) animated:YES];
}
@end
