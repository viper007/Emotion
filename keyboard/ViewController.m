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
#import "EmojiTextView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *realTextLabel;
@property (weak, nonatomic) IBOutlet EmojiTextView *textView;
@property (strong, nonatomic) EmotionParentView *emotionView;

@property (strong ,nonatomic) UIToolbar *accessView;

@property (nonatomic ,copy) NSString *totalString;//继续当前的文本对应的字符串
@end

@implementation ViewController

- (UIToolbar *)accessView {
    if (!_accessView) {
        _accessView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        _accessView.opaque = NO;
        _accessView.barStyle = UIBarStyleDefault;
        _accessView.backgroundColor = [UIColor redColor];
        _accessView.clearsContextBeforeDrawing = YES;
    }
    return _accessView;
}

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
    //self.textView.inputAccessoryView = self.accessView;
    
    [self emotionView];//需要在主线程去更新UI
}

#pragma mark - 选中与删除表情
- (void)selectedEmotion:(NSNotification *)note {
    EmotionModel *emotion = (EmotionModel *)(note.object);
    self.textView.emotionModel = emotion;
}
- (void)deleteEmotion:(NSNotification *)note {
    [self.textView deleteBackward];
}

#pragma mark - 获取发送文本型
- (IBAction)getServerText {
    self.realTextLabel.text = self.textView.realText;
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
