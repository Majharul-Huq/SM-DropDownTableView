//
//  DataSource.m
//  SM-DropDownTableView
//
//  Created by Huq Majharul on 1/10/16.
//  Copyright © 2016 Huq Majharul. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+ (NSArray *)options
{
    return @[
             @{
                 @"title": @"Argentina"
                 },
             @{
                 @"title": @"Bangladesh"
                 },
             @{
                 @"title": @"Denmark"
                 },
             @{
                 @"title": @"Egypt"
                 },
             @{
                 @"title": @"United States"
                 }
             ];
}

@end
