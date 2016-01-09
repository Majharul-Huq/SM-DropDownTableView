//
//  KHFlatButton.h
//  SM-DropDownTableView
//
//  Created by Huq Majharul on 1/10/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHFlatButton : UIButton

+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)radius;
+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor;
+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor;

@property (nonatomic)           CGFloat                 cornerRadius;

@end
