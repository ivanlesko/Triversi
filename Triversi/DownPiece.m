//
//  DownPiece.m
//  Triversi
//
//  Created by Luda on 4/16/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "DownPiece.h"

@implementation DownPiece

+ (id)placePieceAtRow:(int)row
                 andColumn:(int)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction
                 withBoard:(Board *)board {
    
    DownPiece *newPiece = [Piece placePieceAtRow:row
                                       andColumn:column
                                      atPosition:position
                                   withPieceType:pieceType
                                   withDirection:kTRTriangleDirectionDown
                                       withBoard:board];
    
    // If the new piece is at the top of the board..
//    if (newPiece.row > 0) {
//        newPiece.abovePiece.row = newPiece.row;
//        newPiece.abovePiece.column = newPiece.column - 1;
//    } else {
//        newPiece.abovePiece = nil;
//    }
    
    return newPiece;
}

- (NSString *)adjacentPieces {
    return [NSString stringWithFormat:@"%@, %@, %@", self.leftPiece, self.rightPiece, self.abovePiece];
}

@end
