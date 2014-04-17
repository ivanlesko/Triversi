//
//  UpPiece.h
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Piece.h"

@interface UpPiece : Piece

@property (nonatomic, strong) PieceIndex *bottomPiece;

+ (id)placePieceAtRow:(NSInteger)row
            andColumn:(NSInteger)column
           atPosition:(CGPoint)position
        withPieceType:(kTRTrianglePieceType)pieceType
        withDirection:(kTRTriangleDirection)direction
            withBoard:(Board *)board;

@end
