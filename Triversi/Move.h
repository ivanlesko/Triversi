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
@property (nonatomic) NSNumber *row;
@property (nonatomic) NSNumber *column;
@property (nonatomic) kTRTrianglePieceType type;
@property (nonatomic) kTRTriangleDirection direction;

+ (Move *)createMoveWithRow:(NSNumber *)row
                     column:(NSNumber *)column
                       type:(kTRTrianglePieceType)type
                  direction:(kTRTriangleDirection)direction;

@end
