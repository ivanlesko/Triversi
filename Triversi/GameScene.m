//
//  GameScene.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "GameScene.h"
#import "Triangle.h"

@implementation GameScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.triTouch = NO;
        
        SKNode *grid = [SKNode node];
        grid.position = CGPointMake(size.width / 2.0, size.height / 2.0);
        NSLog(@"grid position: %@", NSStringFromCGPoint(grid.position));
        
        [self addChild:grid];
        
        int rows = 8;
        int columns = 9;
        
        Triangle *placeholderTri = [Triangle createTriangleAtPosition:CGPointMake(0, 0) upSideDown:YES];
        CGFloat spacing = placeholderTri.frame.size.width / 2.0;
        
        [self addChild:placeholderTri];
        CGPoint origin = CGPointMake(-rows / 2.0 * spacing, rows / 2.0 * spacing + placeholderTri.frame.size.height);
        CGPoint newOrigin = origin;
        
        BOOL upSideDown = NO;
        
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                Triangle *newTri;
                if (j % 2 == 0) {
                    // even numbered row
                    newTri = [Triangle createTriangleAtPosition:newOrigin upSideDown:upSideDown];
                }
                else {
                    // odd number row
                    newTri = [Triangle createTriangleAtPosition:newOrigin upSideDown:upSideDown];
                }
                newTri.name = [NSString stringWithFormat:@"triangle%d%d", i, j];
                upSideDown = !upSideDown;
                [grid addChild:newTri];
                newOrigin = CGPointMake(newOrigin.x + spacing, newOrigin.y);
            }
            newOrigin = CGPointMake(origin.x, newOrigin.y - placeholderTri.frame.size.height);
        }
        
        [placeholderTri removeFromParent];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end

















