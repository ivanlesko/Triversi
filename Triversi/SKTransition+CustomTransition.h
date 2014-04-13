//
//  SKTransition+CustomTransition.h
//  iota
//
//  Created by Ivan Lesko on 3/28/14.
//  Copyright (c) 2014 Ivan Lesko. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKTransition (CustomTransition)

/*
 * Returns a one second black fade transition.
 * Use this transition between all scenes to stay consistent.
 */
+ (SKTransition *)fadeToBlackOneSecondDuration;

@end
