//
//  EmotionView.m
//  keyboard
//
//  Created by 满艺网 on 2017/8/15.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#define randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define rowCount 3
#define colCount 7
#define perPageCount (colCount*rowCount-1)

#import "EmotionView.h"
#import "LvEmotionButton.h"
#import "LvMagnifierWindow.h"
@interface EmotionView ()

@property (nonatomic ,strong) UIButton *backFoward;
@property (nonatomic ,strong) NSMutableArray *buttonsArray;
@property (nonatomic ,strong) LvMagnifierWindow *magnifierView;

@end

@implementation EmotionView
#pragma mark - lazy Load
- (LvMagnifierWindow *)magnifierView {
    if (!_magnifierView) {
        _magnifierView = [LvMagnifierWindow magnifierView];
    }
    return _magnifierView;
}
- (NSMutableArray *)buttonsArray {
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *backFoward = [UIButton buttonWithType:UIButtonTypeCustom];
        [backFoward setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [backFoward setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        backFoward.backgroundColor = [UIColor clearColor];
        [backFoward addTarget:self action:@selector(deleteCharacter:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backFoward];
        self.backFoward = backFoward;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressState:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

/**
 *  @des 数组存放的是表情模型
 */
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    //
    [emotions enumerateObjectsUsingBlock:^(EmotionModel *emotionModel, NSUInteger idx, BOOL * _Nonnull stop) {
        //创建对应的view
        LvEmotionButton *btn = nil;
        if (idx < self.buttonsArray.count) {
            btn = self.buttonsArray[idx];
        }else {
            btn = [LvEmotionButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
            [self addSubview:btn];
            [self.buttonsArray addObject:btn];
        }
        btn.emotion = emotionModel;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    CGFloat width = [UIScreen mainScreen].bounds.size.width/colCount;
    CGFloat height = self.frame.size.height / rowCount;
    [self.buttonsArray enumerateObjectsUsingBlock:^(LvEmotionButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger row = idx / colCount;
        int col = idx % colCount;
        CGFloat x = width * col;
        CGFloat y = height * row;
        btn.frame = CGRectMake(x, y, width, height);
    }];
    self.backFoward.frame = CGRectMake(self.frame.size.width - width, self.frame.size.height - height, width, height);
}


#pragma mark - Notefication Method
- (void)buttonClick:(LvEmotionButton *)sender {
    [self.magnifierView showEmotion:sender];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.magnifierView dismiss];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNoteficationSendEmotion object:sender.emotion];
}

- (void)deleteCharacter:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNoteficationDeleteEmotion object:nil];
}

#pragma mark - Inner Method
- (void)longPressState:(UILongPressGestureRecognizer *)longPress {
    //
    if (longPress.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [longPress locationInView:self];
        LvEmotionButton *emotionButton = [self emotionWithPoint:point];
        if (emotionButton) {
            [self buttonClick:emotionButton];
        }else {
            [self.magnifierView dismiss];
        }
    }else {
        CGPoint point = [longPress locationInView:self];
        LvEmotionButton *emotionButton = [self emotionWithPoint:point];
        [self.magnifierView showEmotion:emotionButton];
    }
}

#pragma mark -
- (LvEmotionButton *)emotionWithPoint:(CGPoint)point {
    __block LvEmotionButton *emotionButton = nil;
    
    [self.buttonsArray enumerateObjectsUsingBlock:^(LvEmotionButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            //显示对应的弹窗
            emotionButton = obj;
            *stop = YES;
        }
    }];
    return emotionButton;
}
#pragma mark - 另外的方式
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    UIButton *btn = [self touchWithPoint:point];
//    NSLog(@"touchesBegan%@",btn.currentTitle);
//}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    UIButton *btn = [self touchWithPoint:point];
//    NSLog(@"touchesMoved%@",btn.currentTitle);
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    UIButton *btn = [self touchWithPoint:point];
//    NSLog(@"touchesEnded%@",btn.currentTitle);
//    //发出对应的消息
//    if (btn) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"key" object:btn];
//    }
//}
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    
//}
//遍历出这个控件所有的子控件
//- (UIButton *)touchWithPoint:(CGPoint)point {
//    //
//    __block UIButton *btn = nil;
//    [self.subviews enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (CGRectContainsPoint(button.frame, point) && !btn.hidden) {
//            btn = button;
//            *stop = YES;
//        }
//    }];
//    return btn;
//}


@end
