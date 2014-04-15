//
//  Player.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithPieceColor:(kTRPieceColor)color {
    if (self = [super init]) {
        self.pieceColor = color;
    }
    
    return self;
}

@end
