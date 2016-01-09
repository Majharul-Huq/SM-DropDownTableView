//
//  ViewController.m
//  SM-DropDownTableView
//
//  Created by Huq Majharul on 1/10/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import "ViewController.h"
#import "OptionButtonView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor   = [UIColor lightGrayColor];
    
    OptionButtonView *optionButtonView                 = [[OptionButtonView alloc]initWithFrame:CGRectMake(0,100, self.view.frame.size.width, ViewHeight)];
    [optionButtonView load];
    [self.view addSubview:optionButtonView];
    optionButtonView.arrBottomViews = [NSMutableArray arrayWithObjects:imageViewFlag,nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
