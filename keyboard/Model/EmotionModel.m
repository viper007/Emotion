//
//  EmotionModel.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/4.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "EmotionModel.h"

@implementation EmotionModel

//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.chs = [decoder decodeObjectForKey:@"chs"];
//        self.cht = [decoder decodeObjectForKey:@"cht"];
//        self.png = [decoder decodeObjectForKey:@"png"];
//        self.code = [decoder decodeObjectForKey:@"code"];
//      //  self.directory = [decoder decodeObjectForKey:@"directory"];
//    }
//    return self;
//}
//
///**
// *  将对象写入文件的时候调用
// *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
// */
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.chs forKey:@"chs"];
//    [encoder encodeObject:self.cht forKey:@"cht"];
//    [encoder encodeObject:self.png forKey:@"png"];
//    [encoder encodeObject:self.code forKey:@"code"];
//   // [encoder encodeObject:self.directory forKey:@"directory"];
//}

- (void)setCode:(NSString *)code {
    _code = [code copy];
    if (!_code) {
        return;
    }
    self.emoj = [NSString emojiWithStringCode:code];
}

- (NSString *)direc {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    return [NSString stringWithFormat:@"%@/",resourcePath];
}
@end
