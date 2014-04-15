//
//  Triangle.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Piece : SKShapeNode

@property (nonatomic) UIBezierPath *touchableArea;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) kTRTriangleDirection direction;
@property (nonatomic) int row;
@property (nonatomic) int column;

+ (Piece *)placePieceAtRow:(int)row
                 andColumn:(int)column
                atPosition:(CGPoint)position
             withPieceType:(kTRTrianglePieceType)pieceType
             withDirection:(kTRTriangleDirection)direction
                  withName:(NSString *)name;

@end
