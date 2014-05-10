//
//  TriversiViewController.m
//  Triversi
//
//  Created by Luda on 4/13/14.
//  Copyright (c) 2014 ivonski. All rights reserved.
//

#import "TriversiViewController.h"
#import "GameScene.h"

@interface TriversiViewController() {
    
}

@property (nonatomic, strong) SKView *skView;

@end

@implementation TriversiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    self.skView = (SKView *)self.view;
    self.skView.showsFPS = NO;
    self.skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    GameScene * scene = [[GameScene alloc] initWithSize:self.view.bounds.size];
    scene.backgroundColor = [SKColor whiteColor];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:scene];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (SKTexture *)createTriangleTextureForPieceType:(kTRTrianglePieceType)pieceType
                                   withDirection:(kTRTriangleDirection)direction {
    
    SKTexture *text = [SKTexture textureWithImageNamed:@"foo"];
    
    
    
    return text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end







