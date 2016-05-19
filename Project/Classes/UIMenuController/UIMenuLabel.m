//
//  UIMenuLabel.m
//  Project
//
//  Created by zhcpeng on 16/5/4.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "UIMenuLabel.h"

@interface UIMenuLabel ()

@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end

@implementation UIMenuLabel



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self addGestureRecognizer:_longPressGestureRecognizer];
    self.userInteractionEnabled = YES;
}

- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.longPressGestureRecognizer)
    {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        {
            NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot become first responder", self);
            
            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
//            if ([self.copyableLabelDelegate respondsToSelector:@selector(copyMenuTargetRectInCopyableLabelCoordinates:)])
//            {
//                [copyMenu setTargetRect:[self.copyableLabelDelegate copyMenuTargetRectInCopyableLabelCoordinates:self] inView:self];
//            }
//            else
//            {
                [copyMenu setTargetRect:self.bounds inView:self];
//            }
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}


#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return self.showMenuView;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL retValue = NO;
    
    if (action == @selector(copy:))
    {
        if (self.showMenuView)
        {
            retValue = YES;
        }
    }
    else
    {
        // Pass the canPerformAction:withSender: message to the superclass
        // and possibly up the responder chain.
        retValue = [super canPerformAction:action withSender:sender];
    }
    
    return retValue;
}

- (void)copy:(id)sender
{
    if (self.showMenuView)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSString *stringToCopy;
//        if ([self.copyableLabelDelegate respondsToSelector:@selector(stringToCopyForCopyableLabel:)])
//        {
//            stringToCopy = [self.copyableLabelDelegate stringToCopyForCopyableLabel:self];
//        }
//        else
//        {
            stringToCopy = self.text;
//        }
        
        [pasteboard setString:stringToCopy];
    }
}

@end
