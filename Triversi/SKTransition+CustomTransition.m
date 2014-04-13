//
//  SKTransition+CustomTransition.m
//  iota
//
//  Created by Ivan Lesko on 3/28/14.
//  Copyright (c) 2014 Ivan Lesko. All rights reserved.
//

#import "SKTransition+CustomTransition.h"

@implementation SKTransition (CustomTransition)

+ (SKTransition *)fadeToBlackOneSecondDuration {
    SKTransition *transition = [SKTransition fadeWithColor:[SKColor blackColor] duration:1.0];
    
    return transition;
}

@end
