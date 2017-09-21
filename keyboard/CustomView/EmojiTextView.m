//
//  EmojiTextView.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/19.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "EmojiTextView.h"
#import "LvTextAttachment.h"
@implementation EmojiTextView

- (void)setEmotionModel:(EmotionModel *)emotionModel {
    _emotionModel = emotionModel;
    //拼接字符串
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        //EmotionModel *emotion = (EmotionModel *)(note.object);
        NSRange selectedRange;
        if (emotionModel.emoj) {//说明是emoji直接拼接
            [text insertAttributedString:[[NSAttributedString alloc] initWithString:emotionModel.emoj] atIndex:self.selectedRange.location];
            selectedRange = NSMakeRange(self.selectedRange.location+emotionModel.emoj.length, self.selectedRange.length);
        }else {//说明是其他的内容不可以直接拼接
            LvTextAttachment *textAttachment = [[LvTextAttachment alloc] init];
            textAttachment.emotionModel = emotionModel;
            NSString *fileName = [NSString stringWithFormat:@"%@%@",emotionModel.direc,emotionModel.png];
            textAttachment.image = [UIImage imageWithContentsOfFile:fileName];
            textAttachment.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
            NSAttributedString *attributedText = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [text insertAttributedString:attributedText atIndex:self.selectedRange.location];
            selectedRange = NSMakeRange(self.selectedRange.location+1, self.selectedRange.length);
        }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.firstLineHeadIndent = self.font.lineHeight * 2;
    paragraphStyle.headIndent = 3;
    [text addAttributes:@{NSFontAttributeName : self.font,NSParagraphStyleAttributeName : paragraphStyle} range:NSMakeRange(0, text.length)];
        self.attributedText = text;
        self.selectedRange = selectedRange;
}

- (NSString *)realText {
    NSMutableString *resultText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        //NSLog(@"%@---%@",attrs,NSStringFromRange(range));
        LvTextAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {
            [resultText appendString:attach.emotionModel.chs];
        }else {
           [resultText appendString:[self.attributedText attributedSubstringFromRange:range].string];
        }
    }];
    return resultText;
}

@end
