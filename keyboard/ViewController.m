//
//  ViewController.m
//  keyboard
//
//  Created by 满艺网 on 2017/8/15.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "ViewController.h"
#import "EmotionParentView.h"
#import "LoadEmojTool.h"
#import "EmotionModel.h"
#import <objc/runtime.h>
#import "PlaceHolderTextView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet PlaceHolderTextView *textView;
@property (strong, nonatomic) EmotionParentView *emotionView;

@end

@implementation ViewController

- (EmotionParentView *)emotionView {
    if (!_emotionView) {
        _emotionView = [[EmotionParentView alloc] init];
        _emotionView.frame = CGRectMake(0, 0, self.view.frame.size.width, 260);
    }
    return _emotionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedEmotion:) name:NSNoteficationSendEmotion object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEmotion:) name:NSNoteficationDeleteEmotion object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:NULL];
    //[self testRuntime];
    self.textView.placeholderTextBlock(@"我是占位文字").placeholderColorBlock([UIColor yellowColor]);
    self.textView.tintColor = [UIColor redColor];//修改光标的颜色
    
}

#pragma mark - 选中与删除表情
- (void)selectedEmotion:(NSNotification *)note {
//    EmotionModel *emotion = (EmotionModel *)(note.object);
//    [self.textView insertText:emotion.chs];
    //1.拼接表情
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    EmotionModel *emotion = (EmotionModel *)(note.object);
    if (emotion.code) {//说明是emoji直接拼接
        [text insertAttributedString:[[NSAttributedString alloc] initWithString:emotion.emoj] atIndex:self.textView.selectedRange.location];
    }else {//说明是其他的内容不可以直接拼接
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        NSString *fileName = [NSString stringWithFormat:@"%@%@",emotion.direc,emotion.png];
        textAttachment.image = [UIImage imageWithContentsOfFile:fileName];
        textAttachment.bounds = CGRectMake(0, -3, self.textView.font.lineHeight, self.textView.font.lineHeight);
        NSAttributedString *attributedText = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [text insertAttributedString:attributedText atIndex:self.textView.selectedRange.location];
    }
    [text addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, text.length)];
    NSRange selectedRange = NSMakeRange(self.textView.selectedRange.location+1, self.textView.selectedRange.length);
    self.textView.attributedText = text;
    self.textView.selectedRange = selectedRange;
    //发送出去的消息是对应的
}
- (void)deleteEmotion:(NSNotification *)note {
    [self.textView deleteBackward];
}
#pragma mark - keyboard Notification
- (void)keyboardDidChangeFrame:(NSNotification *)note {
//    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    CGFloat frameHeight = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
//    CGFloat originY = self.view.frame.size.height - self.emotionView.frame.size.height;
//    [UIView animateWithDuration:duration animations:^{
//         [self.view layoutIfNeeded];
//    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}
#pragma mark - 键盘切换
- (IBAction)clickButton:(UIButton *)sender {
    [self.textView resignFirstResponder];
    if (self.textView.inputView) {
        self.textView.inputView = nil;
    }else {
        self.textView.inputView = self.emotionView;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}
#pragma mark - 内存释放:析构函数
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 运行时获得类的实例变量
- (void)testRuntime {
    unsigned int outCount = 0;
    Ivar *ivarList = class_copyIvarList([UISegmentedControl class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivarList[i];
        const char *cName = ivar_getName(ivar);
        NSString *ocName = [[NSString alloc] initWithUTF8String:cName];
        const char *cType = ivar_getTypeEncoding(ivar);
        NSString *ocType = [[NSString alloc] initWithUTF8String:cType];
        NSLog(@"%@---%@",ocName,ocType);
    }
    //CFRelease(ivarList);//_currentPageImage  _pageImage
}
@end
