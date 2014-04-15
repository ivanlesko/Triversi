//
//  Move.h
//  Triversi
//
//  Created by Luda on 4/14/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Move : NSObject

/// A move object contains all of the information about what type of piece was placed where.

@property (nonatomic) int order;
@property (nonatomic) int row;
@property (nonatomic) int column;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) kTRTriangleDirection direction;

+ (Move *)createMoveWithRow:(int)row
                     column:(int)column
                       type:(kTRTrianglePieceType)type
                  direction:(kTRTriangleDirection)direction;

@end
