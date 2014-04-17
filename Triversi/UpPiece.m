//
//  UpPiece.m
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "UpPiece.h"

@implementation UpPiece

+ (id)placePieceAtRow:(int)row
                 andColumn:(int)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction
                 withBoard:(Board *)board {
    
    UpPiece *newPiece = [Piece placePieceAtRow:row
                                   andColumn:column
                                  atPosition:position
                               withPieceType:pieceType
                               withDirection:kTRTriangleDirectionUp
                                   withBoard:board];
    
    // If the new piece is at the top of the board..
//    if (newPiece.row < ROWS) {
//        newPiece.bottomPiece.row = newPiece.row + 1;
//        newPiece.bottomPiece.column = newPiece.column;
//    } else {
//        newPiece.bottomPiece = nil;
//    }
    
    return newPiece;
}

- (NSString *)adjacentPieces {
    return [NSString stringWithFormat:@"%@, %@, %@", self.leftPiece, self.rightPiece, self.bottomPiece];
}

@end
