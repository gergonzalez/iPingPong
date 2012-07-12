//
//  ViewController.m
//  iPingPong
//
//  Created by Germán González Rodríguez on 11/07/12.
//  Copyright (c) 2012 . All rights reserved.
//

//New
#define kBallSpeedX 3
#define kBallSpeedY 2

#define kFPS 0.01

//New
#define kPlayer2Speed 3

//New
#define kScoreToWin 5

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize ball, player1, player2, player1Score, player2Score;
@synthesize startLabel, ballVelocity;//New
@synthesize player1ScoreValue, player2ScoreValue;//New

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Create the main view and assign a black color to background
    CGRect backgroundFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *view = [[UIView alloc] initWithFrame:backgroundFrame];
    view.backgroundColor = [UIColor blackColor];
    self.view = view;
    [view release];
    
    //Create the net
    for (int i=0; i<20; i++) {
        UIView *net = [[UIView alloc] initWithFrame:
                       CGRectMake(16*i, self.view.center.y-2, 8, 4)];
        net.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:net];
        [net release];
    }
    
    //Create the Score
    player1Score = [[UILabel alloc] initWithFrame:
                    CGRectMake(10, 190, 30, 30)];
    player1Score.font = [UIFont fontWithName:@"Helvetica" size:30];
    player1Score.text = @"0";
    player1Score.textColor = [UIColor whiteColor];
    player1Score.backgroundColor = [UIColor blackColor];
    [self.view addSubview:player1Score];
    
    player2Score = [[UILabel alloc] initWithFrame:
                    CGRectMake(10, 260, 30, 30)];
    player2Score.font = [UIFont fontWithName:@"Helvetica" size:30];
    player2Score.text = @"0";
    player2Score.textColor = [UIColor whiteColor];
    player2Score.backgroundColor = [UIColor blackColor];
    [self.view addSubview:player2Score];
    
    //Create our elements
    player1 =[[UIView alloc] initWithFrame:
              CGRectMake(self.view.center.x-25, 420, 50, 10)];
    player1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:player1];
    
    player2 =[[UIView alloc] initWithFrame:
              CGRectMake(self.view.center.x-25, 50, 50, 10)];
    player2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:player2];
    
    ball =[[UIView alloc] initWithFrame:
           CGRectMake(self.view.center.x-4, self.view.center.y-4, 8, 8)];
    ball.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ball];
    
    
    //New
	//Tap to Start Label
	startLabel = [[UILabel alloc] initWithFrame:
                  CGRectMake(self.view.center.x-50, 200, 100, 15)];
	startLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
	startLabel.text = @"TAP TO START GAME";
	startLabel.textColor = [UIColor whiteColor];
	startLabel.backgroundColor = [UIColor blackColor];
	[self.view addSubview:startLabel];
    
	//Game start Paused
	gameRunning = NO;
    
	ballVelocity = CGPointMake(kBallSpeedX, kBallSpeedY);
    
	[NSTimer scheduledTimerWithTimeInterval:kFPS target:self 
                                   selector:@selector(gameLoop) userInfo:nil repeats:YES];    

}

-(void)gameLoop{
    
	if (gameRunning) {
        
        //AI
		if(ball.center.y <= self.view.center.y) {
			if(ball.center.x < player2.center.x) {
				player2.center = 
                CGPointMake(player2.center.x - kPlayer2Speed, player2.center.y);
			}
            
			if(ball.center.x > player2.center.x) {
				player2.center = 
                CGPointMake(player2.center.x + kPlayer2Speed, player2.center.y);
			}
		}

        
		ball.center = 
        CGPointMake(ball.center.x + ballVelocity.x, ball.center.y + ballVelocity.y);
        
		//Collision Detection
		if(ball.center.x>self.view.bounds.size.width || ball.center.x < 0){
            
			ballVelocity.x = -ballVelocity.x;	
		}
        
		if(ball.center.y>self.view.bounds.size.height || ball.center.y < 0){
            
			ballVelocity.y = -ballVelocity.y;
		}
        
		if (CGRectIntersectsRect (ball.frame, player1.frame)){
			if (ball.center.y < player1.center.y){
				ballVelocity.y = -ballVelocity.y-0.1;
			}
            
		}
        
		if (CGRectIntersectsRect (ball.frame, player2.frame)){
			if (ball.center.y < player2.center.y){
				ballVelocity.y = -ballVelocity.y+0.1;
			}
            
		}	
        
		if(ball.center.y <= 0) {
			player1ScoreValue++;
			ballVelocity = CGPointMake(kBallSpeedX, kBallSpeedY);
			[self playAgain:(player1ScoreValue >= kScoreToWin)];
		}
        
		if(ball.center.y > self.view.bounds.size.height) {
			player2ScoreValue++;
			ballVelocity = CGPointMake(kBallSpeedX, kBallSpeedY);
			[self playAgain:(player2ScoreValue >= kScoreToWin)];
		}
        
    } else {
        
        if (startLabel.hidden) {
            startLabel.hidden = NO;
        }
        
    }
    
}

-(void)playAgain:(BOOL) newGame {
	gameRunning = NO;
	ball.center = self.view.center;
	if(newGame) {
		if(player2ScoreValue > player1ScoreValue) {
			startLabel.text = @"PLAYER 2 WINS!";
		} else {
			startLabel.text = @"PLAYER 1 WINS!";
		}
        
		player2ScoreValue = 0;
		player1ScoreValue = 0;
	} else {
		startLabel.text = @"TAP TO START GAME";
	}
    
	player1Score.text = [NSString stringWithFormat:@"%d",player1ScoreValue];
	player2Score.text = [NSString stringWithFormat:@"%d",player2ScoreValue];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    [player1 release];
	[player2 release];
	[ball release];
	[player1Score release];
	[player2Score release];
    [startLabel release];//New
    [super dealloc];
}

//New
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	if(!gameRunning) {
		startLabel.hidden = YES;
		gameRunning = YES;
	} else if(gameRunning) {
		[self touchesMoved:touches withEvent:event];
	}	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:self.view];
	player1.center = CGPointMake(location.x, player1.center.y);;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{    
    return NO;
}

@end
