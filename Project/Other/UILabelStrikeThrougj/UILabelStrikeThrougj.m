//
//  UILabelStrikeThrougj.m
//  HuiMaiApplication
//
//  Created by zhcpeng on 15/7/27.
//  Copyright (c) 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

#import "UILabelStrikeThrougj.h"

@implementation UILabelStrikeThrougj

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:rect];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize textSize = [[self text] sizeWithFont:[self font]];
#pragma clang diagnostic pop
    
    CGFloat strikeWidth = textSize.width;
    CGRect lineRect;
    
    if ([self textAlignment] == NSTextAlignmentRight) {
        lineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2, strikeWidth, 1);
    } else if ([self textAlignment] == NSTextAlignmentCenter) {
        lineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2, strikeWidth, 1);
    } else {
        lineRect = CGRectMake(0, rect.size.height/2, strikeWidth, 1);
    }
    
    if (_strikeThroughEnabled) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor darkTextColor].CGColor);
        CGContextFillRect(context, lineRect);
    }
}

- (void)setStrikeThroughEnabled:(BOOL)strikeThroughEnabled {
    _strikeThroughEnabled = strikeThroughEnabled;
    
    NSString *tempText = [self.text copy];
    self.text = @"";
    self.text = tempText;
}

@end
