//
//  NSString+FilePaths.m
//  iota
//
//  Created by Ivan on 4/3/14.
//  Copyright (c) 2014 Ivan Lesko. All rights reserved.
//

#import "NSString+FilePaths.h"

@implementation NSString (FilePaths)

+ (NSString *)documentsDirectory {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return path.firstObject;
}

@end
