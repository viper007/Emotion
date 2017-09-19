//
//  EmojiTextView.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/19.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "EmojiTextView.h"

@implementation EmojiTextView

- (void)setEmotionModel:(EmotionModel *)emotionModel {
    _emotionModel = emotionModel;
    //拼接字符串
    if (emotionModel.code) {
        [self insertText:emotionModel.emoj];
    }else {
        [self insertText:emotionModel.chs];
    }
}

- (void)insertText:(NSString *)text {
    [super insertText:text];
    
    NSString *pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error;
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *result = [exp matchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)];
    NSLog(@"%@",result);
    //
    [result enumerateObjectsUsingBlock:^(NSTextCheckingResult   *textResult, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    //1.拼接表情
    //    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //    //EmotionModel *emotion = (EmotionModel *)(note.object);
    //    NSRange selectedRange;
    //    if (emotionModel.code) {//说明是emoji直接拼接
    //        [text insertAttributedString:[[NSAttributedString alloc] initWithString:emotionModel.emoj] atIndex:self.selectedRange.location];
    //        selectedRange = NSMakeRange(self.selectedRange.location+emotionModel.emoj.length, self.selectedRange.length);
    //    }else {//说明是其他的内容不可以直接拼接
    //        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    //        NSString *fileName = [NSString stringWithFormat:@"%@%@",emotionModel.direc,emotionModel.png];
    //        textAttachment.image = [UIImage imageWithContentsOfFile:fileName];
    //        textAttachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
    //        NSAttributedString *attributedText = [NSAttributedString attributedStringWithAttachment:textAttachment];
    //        [text insertAttributedString:attributedText atIndex:self.selectedRange.location];
    //        selectedRange = NSMakeRange(self.selectedRange.location+1, self.selectedRange.length);
    //    }
    //    [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    //    self.attributedText = text;
    //    self.selectedRange = selectedRange;
}

@end
