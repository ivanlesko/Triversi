//
//  Triangle.h
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Triangle : SKShapeNode

+ (Triangle *)createTriangleAtPosition:(CGPoint)position upSideDown:(BOOL)upSideDown;

@end
