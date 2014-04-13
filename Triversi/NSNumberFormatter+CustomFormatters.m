//
//  NSNumberFormatter+CustomFormatters.m
//  iota
//
//  Created by Ivan on 4/3/14.
//  Copyright (c) 2014 Ivan Lesko. All rights reserved.
//

#import "NSNumberFormatter+CustomFormatters.h"

@implementation NSNumberFormatter (CustomFormatters)

+ (NSNumberFormatter *)commaFormattedNumber {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    [numberFormatter setMaximumFractionDigits:2];
    return numberFormatter;
}

@end
