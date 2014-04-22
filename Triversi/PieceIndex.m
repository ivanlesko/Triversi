//
//  PieceIndex.m
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "PieceIndex.h"

@implementation PieceIndex

+ (PieceIndex *)createPieceIndexWithRow:(NSNumber *)row withColumn:(NSNumber *)column {
    PieceIndex *newIndex = [[PieceIndex alloc] init];
    newIndex.row = row;
    newIndex.column = column;
    
    return newIndex;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@, %@)", self.row, self.column];
}

@end
