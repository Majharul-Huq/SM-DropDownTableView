//
//  KHFlatButton.m
//  SM-DropDownTableView
//
//  Created by Huq Majharul on 1/10/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import "KHFlatButton.h"
#import <QuartzCore/QuartzCore.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

static CGFloat const kDefaultCornerRadius = 2.0;
static CGFloat const kMinimumFontSize = 14.0;
static CGFloat const kHighlightDelta = 0.2;

@interface KHFlatButton()
@property (strong, nonatomic) UIColor *originalBackgroundColor;
@end

@implementation KHFlatButton
@dynamic cornerRadius;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cornerRadius = kDefaultCornerRadius;
    
    [self addTarget:self action:@selector(wasPressed) forControlEvents:(UIControlEventTouchDown       |
                                                                        UIControlEventTouchDownRepeat |
                                                                        UIControlEventTouchDragInside |
                                                                        UIControlEventTouchDragEnter)];
    [self addTarget:self action:@selector(endedPress) forControlEvents:(UIControlEventTouchCancel      |
                                                                        UIControlEventTouchDragOutside |
                                                                        UIControlEventTouchDragExit    |
                                                                        UIControlEventTouchUpInside    |
                                                                        UIControlEventTouchUpOutside)];
}

- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor
{
    return [self initWithFrame:frame withTitle:nil backgroundColor:backgroundColor cornerRadius:kDefaultCornerRadius];
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor*)backgroundColor cornerRadius:(CGFloat)radius;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = backgroundColor;
        self.cornerRadius = radius;
        [self setTitle:title forState:UIControlStateNormal];
        
        CGFloat fontSize = floorf(CGRectGetHeight(self.bounds) / 2.5);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:MAX(kMinimumFontSize, fontSize)];
        
        [self addTarget:self action:@selector(wasPressed) forControlEvents:(UIControlEventTouchDown       |
                                                                            UIControlEventTouchDownRepeat |
                                                                            UIControlEventTouchDragInside |
                                                                            UIControlEventTouchDragEnter)];
        [self addTarget:self action:@selector(endedPress) forControlEvents:(UIControlEventTouchCancel      |
                                                                            UIControlEventTouchDragOutside |
                                                                            UIControlEventTouchDragExit    |
                                                                            UIControlEventTouchUpInside    |
                                                                            UIControlEventTouchUpOutside)];
    }
    return self;
}

+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)radius
{
    KHFlatButton *btn = [[KHFlatButton alloc] initWithFrame:frame
                                                  withTitle:title
                                            backgroundColor:backgroundColor
                                               cornerRadius:radius];
    return btn;    
}

+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    KHFlatButton *btn = [[KHFlatButton alloc] initWithFrame:frame
                                                  withTitle:title
                                            backgroundColor:backgroundColor
                                               cornerRadius:kDefaultCornerRadius];
    return btn;
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    KHFlatButton *btn = [[KHFlatButton alloc]initWithFrame:CGRectZero withTitle:title backgroundColor:backgroundColor cornerRadius:kDefaultCornerRadius];
    
    // Add padding to button label
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn sizeToFit];
    CGRect frame = btn.frame;
    frame.size.width += 20;
    btn.frame = frame;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    super.backgroundColor = backgroundColor;
    self.originalBackgroundColor = backgroundColor;
}

- (void)wasPressed
{
    CGFloat red, grn, blu, white, alpha = 0.0;
    [self.originalBackgroundColor getRed:&red green:&grn blue:&blu alpha:&alpha];
    [self.originalBackgroundColor getWhite:&white alpha:&alpha];
    super.backgroundColor = [UIColor colorWithRed:red - kHighlightDelta
                                            green:grn - kHighlightDelta
                                             blue:blu - kHighlightDelta
                                            alpha:alpha];
}

- (void)endedPress
{
    super.backgroundColor = self.originalBackgroundColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

@end
