//
//  Move.m
//  Triversi
//
//  Created by Luda on 4/14/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Move.h"

@implementation Move

+ (Move *)createMoveWithRow:(int)row
                     column:(int)column
                       type:(kTRTrianglePieceType)type
                  direction:(kTRTriangleDirection)direction {
    Move *newMove = [[Move alloc] init];
    
    newMove.row = row;
    newMove.column = column;
    newMove.type = type;
    newMove.direction = direction;
    
    return newMove;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Move #%d: At index (%d, %d) with player type %d", self.order, self.row, self.column, self.type];
}

@end
