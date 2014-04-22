//
//  PieceIndex.h
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PieceIndex : NSObject

/*
 * The PieceIndex class contains a row and column.
 * This is used to easily determine the adjacent pieces on any given piece
 */
@property (nonatomic) NSNumber *row;
@property (nonatomic) NSNumber *column;

+ (PieceIndex *)createPieceIndexWithRow:(NSNumber *)row withColumn:(NSNumber *)column;

@end
