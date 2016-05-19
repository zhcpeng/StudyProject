//
//  YYLabelViewController.m
//  Project
//
//  Created by zhcpeng on 16/5/16.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "YYLabelViewController.h"

#import "YYText.h"
#import "YYImage.h"
#import "NSBundle+YYAdd.h"


@interface YYLabelViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) YYLabel *label;

@end

@implementation YYLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    NSMutableAttributedString *text = [NSMutableAttributedString new];
//    UIFont *font = [UIFont systemFontOfSize:16];
//    
//    NSString *title = @"This is Animated Image atta [微笑]";
//    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
//    
//    
////    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:kREGULAR options:NSRegularExpressionCaseInsensitive error:nil];
////    NSArray *list = [regular matchesInString:title options:NSMatchingWithTransparentBounds range:NSMakeRange(0, title.length)];
////    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////        
////    }];
//    
//
//    
//    
//
//
////    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_link_blue@2x" ofType:@"png" inDirectory:@"Image.bundle"];
//    NSString *path = [[NSBundle mainBundle] pathForScaledResource:@"image_link_blue" ofType:@"png" inDirectory:@"Image.bundle"];
//
//    
////    YYImage *image = [YYImage imageNamed:@"image_link_blue"];
//    YYImage *image = [YYImage imageWithContentsOfFile:path];
//    image.preloadAllAnimatedImageFrames = YES;
//    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
//    imageView.autoPlayAnimatedImage = NO;
//    [imageView startAnimating];
//    
//    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentBottom];
//    [text appendAttributedString:attachText];
//    
//    [text appendAttributedString:[[NSAttributedString alloc]initWithString:@"[LinkBlue]网页链接" attributes:nil]];
//    
//    [text yy_setTextHighlightRange:NSMakeRange(text.length - 4, 4)
//                            color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
//                  backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
//                        tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//                            NSLog(@"LinK::");
////                            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
//                        }];
//    
//    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
//    
//
//    text.yy_font = font;
//    
//    _label = [YYLabel new];
//    _label.userInteractionEnabled = YES;
//    _label.numberOfLines = 0;
//    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
//    _label.size = CGSizeMake(260, 260);
//    _label.center = CGPointMake(self.view.width / 2, self.view.height / 2);
//    _label.attributedText = text;
//    
//    NSDictionary *emo = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expressionImage_custom_extend" ofType:@"plist"]];
//    NSMutableDictionary *list = [NSMutableDictionary new];
//    for (NSString *key in emo.allKeys) {
//        NSString *value = emo[key];
//        NSString *path = [[NSBundle mainBundle] pathForScaledResource:value ofType:@"png" inDirectory:@"Image.bundle"];
//        YYImage *image = [YYImage imageWithContentsOfFile:path];
//        list[key] = image;
//    }
//    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
//    parser.emoticonMapper = list;
//    _label.textParser = parser;
//
//    [self.view addSubview:_label];
    
    
    
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    
    NSString *title = @"This is Animated Image atta [微笑][微笑][微笑][微笑]";
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];

    [text appendAttributedString:[[NSAttributedString alloc]initWithString:@"[LinkBlue]网页链接" attributes:nil]];
    [text yy_setTextHighlightRange:NSMakeRange(text.length - 4, 4)
                             color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             NSLog(@"LinK！！！");
                         }];
    
    text.yy_font = font;
    
    _label = [[YYLabel alloc]initWithFrame:CGRectMake(50, 150, kScreenWidth - 100, 200)];
    _label.userInteractionEnabled = YES;
    _label.numberOfLines = 0;
    _label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _label.attributedText = text;
    
    NSDictionary *emoji = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expressionImage_custom_extend" ofType:@"plist"]];
    NSMutableDictionary *emojiList = [NSMutableDictionary new];
    for (NSString *key in emoji.allKeys) {
        NSString *value = emoji[key];
        NSString *path = [[NSBundle mainBundle] pathForScaledResource:value ofType:@"png" inDirectory:@"Image.bundle"];
        YYImage *image = [YYImage imageWithContentsOfFile:path];
        emojiList[key] = image;
    }
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = emojiList;
    _label.textParser = parser;
    
    [self.view addSubview:_label];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
