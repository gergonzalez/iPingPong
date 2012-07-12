//
//  ViewController.h
//  iPingPong
//
//  Created by Germán González Rodríguez on 11/07/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
	UIView *player1;
	UIView *player2;
	UIView *ball;
    
	UILabel *player1Score;
	UILabel *player2Score;
    UILabel *startLabel;//New	
    
	CGPoint ballVelocity;//New
    
	BOOL gameRunning;//New
    
    NSInteger player1ScoreValue;//New
	NSInteger player2ScoreValue;//New
}

@property(nonatomic, retain) UIView *ball;
@property(nonatomic, retain) UIView *player1;
@property(nonatomic, retain) UIView *player2;

@property(nonatomic, retain) UILabel *player1Score;
@property(nonatomic, retain) UILabel *player2Score;
@property(nonatomic, retain) UILabel *startLabel;//New

@property (nonatomic) CGPoint ballVelocity;//New

@property (nonatomic) NSInteger player1ScoreValue;//New
@property (nonatomic) NSInteger player2ScoreValue;//New

-(void)playAgain: (BOOL) newGame;//New

@end
