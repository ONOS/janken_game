//
//  ViewController.m
//  Janken_game
//
//  Created by 小野 正太郎 on 13/07/19.
//  Copyright (c) 2013年 小野 正太郎. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//じゃんけんキーのテーブルとサイズを指定
jankenKey tacticsArray[] = {rockKey,scissorsKey,paperKey};
NSInteger tacticsArrayCount = sizeof(tacticsArray) / sizeof(tacticsArray[0]);

- (void)viewDidLoad
{
    [super viewDidLoad];
    // UIイメージにファイルを格納
    rockImage = [UIImage imageNamed:@"gu.png"];
    scissorsImage = [UIImage imageNamed:@"ch.png"];
    paperImage = [UIImage imageNamed:@"pa.png"];
    //ボタンのタグにキーを格納
    //(int)と追加（※エラーが出たら）
    rockButton.tag = rockKey;
    scissorsButton.tag = scissorsKey;
    paperButton.tag = paperKey;
    //画面の初期化
    messageLabel.text = messageLabelInitialMessage;
    enemySelectImage.hidden = YES;
    resultLabel.hidden = YES;
    [self initializeView];
    [rematchButton setTitle:rematchButtonInitialMessage forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playerSelectTactics:(id)sender {
    messageLabel.text = messageLabelGameMessage;
    
    UIButton *playerSelectButton = (UIButton*) sender;
    
    switch (playerSelectButton.tag) {
        case rockKey:
            [rockButton setEnabled:NO];
            scissorsButton.hidden = YES;
            paperButton.hidden = YES;
            break;
        case scissorsKey:
            [scissorsButton setEnabled:NO];
            rockButton.hidden = YES;
            paperButton.hidden = YES;
            break;
        case paperKey:
            [paperButton setEnabled:NO];
            rockButton.hidden = YES;
            scissorsButton.hidden = YES;
            break;
        default:
            messageLabel.text = errorMessage;
            //リターンにするか例外を投げる
            break;
    }
    
    NSInteger enemySelectButton = [self enemySelectTactics];
    
    [self judgeWinOrLosePlayer:playerSelectButton.tag AndEnemy:enemySelectButton];
}

-(jankenKey) enemySelectTactics {
    enemySelectImage.hidden = NO;
    NSInteger enemySelectKey = arc4random() % tacticsArrayCount;
    
    switch (tacticsArray[enemySelectKey]) {
        case rockKey:
            [enemySelectImage setImage:rockImage];
            return rockKey;
        case scissorsKey:
            [enemySelectImage setImage:scissorsImage];
            return scissorsKey;
        case paperKey:
            [enemySelectImage setImage:paperImage];
            return paperKey;
        default:
            messageLabel.text = errorMessage;
            return errorKey;
    }
}

- (void) judgeWinOrLosePlayer:(jankenKey)playerTacticsKey AndEnemy:(jankenKey)enemyTacticsKey {
    resultLabel.hidden = NO;
    
    NSInteger maxKeysize;
    NSInteger keyCount;
    for (keyCount=1, maxKeysize=tacticsArray[0]; keyCount<tacticsArrayCount; keyCount++) {
        if (maxKeysize - 1 < tacticsArray[keyCount]) {
            maxKeysize = tacticsArray[keyCount] + 1;
        }
    }
    
    resultKey resultArray[maxKeysize][maxKeysize];
    resultArray[rockKey][rockKey] = drawKey;
    resultArray[rockKey][scissorsKey] = winKey;
    resultArray[rockKey][paperKey] = loseKey;
    resultArray[scissorsKey][rockKey] = loseKey;
    resultArray[scissorsKey][scissorsKey] = drawKey;
    resultArray[scissorsKey][paperKey] = winKey;
    resultArray[paperKey][rockKey] = winKey;
    resultArray[paperKey][scissorsKey] = loseKey;
    resultArray[paperKey][paperKey] = drawKey;
    
    switch (resultArray[playerTacticsKey][enemyTacticsKey]) {
        case winKey:
            [self winViewSetting];
            break;
        case loseKey:
            [self loseViewSetting];
            break;
        case drawKey:
            [self drawViewSetting];
            break;
        default:
            messageLabel.text = errorMessage;
            break;
    }
}

- (void) winViewSetting {
    [resultLabel setTextColor:[UIColor winColor]];
    resultLabel.text = winMessage;
    rematchButton.hidden = NO;
}

- (void) loseViewSetting {
    [resultLabel setTextColor:[UIColor loseColor]];
    resultLabel.text = loseMessage;
    rematchButton.hidden = NO;
}

- (void) drawViewSetting {
    [resultLabel setTextColor:[UIColor drawColor]];
    resultLabel.text = drawMessage;
    [self initializeView];
}

- (void) initializeView {
    [rockButton setEnabled:YES];
    [scissorsButton setEnabled:YES];
    [paperButton setEnabled:YES];
    rockButton.hidden = NO;
    paperButton.hidden = NO;
    scissorsButton.hidden = NO;
    rematchButton.hidden = YES;
}

- (IBAction)hopeRematch:(id)sender {
    messageLabel.text = messageLabelInitialMessage;
    [self initializeView];
    enemySelectImage.hidden = YES;
    [enemySelectImage setImage:nil];
    resultLabel.hidden = YES;
}
@end
