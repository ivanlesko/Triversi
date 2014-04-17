//
//  PieceIndex.m
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "PieceIndex.h"

@implementation PieceIndex

- (NSString *)description {
    return [NSString stringWithFormat:@"(%d, %d)", self.row, self.column];
}

@end
