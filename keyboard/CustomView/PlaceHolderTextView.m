//
//  PlaceHolderTextView.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/7.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "PlaceHolderTextView.h"

@interface PlaceHolderTextView ()

@property (nonatomic ,copy)   NSString *placeHoldtext;
@property (nonatomic ,strong) UIColor *placeHoldColor;

@end

@implementation PlaceHolderTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configueBaseInfo];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configueBaseInfo];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if ([self hasText]) {
        [@"" drawInRect:rect withAttributes:@{NSForegroundColorAttributeName : self.placeHoldColor , NSFontAttributeName : self.font}];
    } else {
        CGRect frame = rect;
        frame.origin.x = 5;
        frame.origin.y = 8;
        rect = frame;
        if (self.placeHoldtext.length == 0 || self.placeHoldtext == nil ) return;
            [self.placeHoldtext drawInRect:rect withAttributes:@{NSForegroundColorAttributeName : self.placeHoldColor , NSFontAttributeName : self.font}];
    }
}

#pragma mark - 配置基本的信息
- (void)configueBaseInfo {
    //添加对应的文本变化的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:NULL];
}

#pragma mark - 监听文字变化的通知
- (void)textDidChange:(NSNotification *)note {
    [self setNeedsDisplay];
}
#pragma mark - 重写父类的方法
- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
#pragma mark - 配置占位文字的属性
- (PlaceHolderTextView *(^)(NSString *))placeholderTextBlock {
    return ^(NSString *text) {
        self.placeHoldtext = text;
        [self setNeedsDisplay];
        return self;
    };
}
- (PlaceHolderTextView *(^)(UIColor *))placeholderColorBlock {
    return ^(UIColor *color) {
        self.placeHoldColor = color;
        [self setNeedsDisplay];
        return self;
    };
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
