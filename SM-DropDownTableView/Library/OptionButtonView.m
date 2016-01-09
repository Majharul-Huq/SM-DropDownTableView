//
//  OptionButtonView.m
//  SM-DropDownTableView
//
//  Created by Huq Majharul on 1/10/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import "OptionButtonView.h"
#import "DataSource.h"

@implementation OptionButtonView
@synthesize arrTableData;
@synthesize arrBottomViews;

#define DegreesToRadians(x) ((x) * M_PI / 180.0)

- (void)load
{
    UIView *nibView = [[[NSBundle mainBundle] loadNibNamed: @"OptionButtonView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:nibView];
    nibView.backgroundColor                     = [UIColor clearColor];
    
    self.arrTableData                           = [DataSource options];
    
    buttonMain.backgroundColor                  = [UIColor darkGrayColor];
    buttonMain.cornerRadius                     = 2.0f;
    [buttonMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    buttonMain.alpha    = 0.98;
    
    [buttonMain.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [buttonMain setTitle:[[self.arrTableData objectAtIndex:0] valueForKey:@"title"] forState:UIControlStateNormal];
    [buttonMain setTitle:[[self.arrTableData objectAtIndex:0] valueForKey:@"title"] forState:UIControlStateSelected];
    tableViewList.backgroundColor               = [UIColor clearColor];
    tableViewList.tintColor                     = [UIColor darkGrayColor];
    tableViewList.delegate                      = self;
    tableViewList.dataSource                    = self;
    tableViewList.separatorColor                = [UIColor lightGrayColor];
    tableViewList.alpha                         = 0.98;
    tableViewList.layer.borderColor             = [UIColor darkGrayColor].CGColor;
    tableViewList.layer.borderWidth             = 2.0f;
    
    imageViewArrow.tintColor                    = [UIColor whiteColor];
    imageViewArrow.image                        = [imageViewArrow.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    rectTargetTableView                         = tableViewList.frame;
    rectInitTableView                           = CGRectMake(rectTargetTableView.origin.x, -rectTargetTableView.size.height, rectTargetTableView.size.width, rectTargetTableView.size.height);
    
    tableViewList.frame                         = rectInitTableView;
    
    selectedCellIndex                           = 0;
}

- (IBAction)actionPressButton:(id)sender
{
    __block BOOL    doOpen = CGRectEqualToRect(tableViewList.frame, rectInitTableView);
    
    [UIView animateWithDuration:0.3
                            delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                            animations:^{
                                tableViewList.frame = doOpen ? rectTargetTableView : rectInitTableView;
                                
                                float degree = doOpen ? 180 : 0;
                                [UIView beginAnimations:@"rotate" context:nil];
                                [UIView setAnimationDuration:0.2];
                                imageViewArrow.transform = CGAffineTransformMakeRotation(DegreesToRadians(degree));
                                [UIView commitAnimations];
                                
                                for (UIView *v in self.arrBottomViews) {
                                    CGRect rect     = v.frame;
                                    rect.origin.y   += doOpen ? tableViewList.frame.size.height : -tableViewList.frame.size.height;
                                    v.frame         = rect;
                                }
                                
                            }completion:^(BOOL finished){
                            }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrTableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary    *dict   = [self.arrTableData objectAtIndex:indexPath.row];
    cell.textLabel.text     = [dict valueForKey:@"title"];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0f]];
    
    cell.accessoryType      = indexPath.row == selectedCellIndex ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [theTableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell     *cell = [tableViewList cellForRowAtIndexPath:indexPath];
    
    NSArray *cells            = [theTableView visibleCells];
    for (UITableViewCell *c in cells) {
        c.accessoryType = UITableViewCellAccessoryNone;
    }
    selectedCellIndex         = indexPath.row;
    cell.accessoryType        = UITableViewCellAccessoryCheckmark;
    
    [buttonMain setTitle:[[self.arrTableData objectAtIndex:indexPath.row] valueForKey:@"title"] forState:UIControlStateNormal];
    [buttonMain setTitle:[[self.arrTableData objectAtIndex:indexPath.row] valueForKey:@"title"] forState:UIControlStateSelected];
    [self actionPressButton:buttonMain];
}
@end
