//
//  PieceIndex.m
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "PieceIndex.h"

@implementation PieceIndex

+ (PieceIndex *)createPieceIndexWithRow:(NSInteger)row withColumn:(NSInteger)column {
    PieceIndex *newIndex = [[PieceIndex alloc] init];
    newIndex.row = row;
    newIndex.column = column;
    
    return newIndex;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%d, %d)", self.row, self.column];
}

@end
