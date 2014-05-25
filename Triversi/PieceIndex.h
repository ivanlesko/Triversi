//
//  PieceIndex.h
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The PieceIndex object contains a row and column.  It is a model object used to represent a piece's coordinates on the board.
 *  This is used to easily determine the adjacent pieces on any given piece
 */
@interface PieceIndex : NSObject


@property (nonatomic) NSNumber *row;
@property (nonatomic) NSNumber *column;

/**
 *  This is the default way to create a piece index.
 *
 *  @param row    an NSNumber for the row.
 *  @param column an NSNumber for the column.
 *
 *  @return A new pieceindex with for given row/x and column/y values.
 */
+ (PieceIndex *)createPieceIndexWithRow:(NSNumber *)row withColumn:(NSNumber *)column;

@end
