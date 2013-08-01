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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // UIイメージにファイルを格納
    rockImage = [UIImage imageNamed:@"gu.png"];
    scissorsImage = [UIImage imageNamed:@"ch.png"];
    paperImage = [UIImage imageNamed:@"pa.png"];
    //ボタンのタグにキーを格納
    //(int)と追加（※エラーが出たら）
    rockButton.tag = Rock_Key;
    scissorsButton.tag = Scissors_Key;
    paperButton.tag = Paper_Key;
    //画面の初期化
    messageLabel.text = Message_Label_Initial_Message;
    enemySelectImage.hidden = YES;
    resultLabel.hidden = YES;
    [rematchButton setTitle:Rematch_Button_Initial_Message forState:UIControlStateNormal];
    rematchButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playerSelectTactics:(id)sender {
    messageLabel.text = Message_Label_Game_Message;
    
    UIButton *Player_Select_Button = (UIButton*) sender;
    
    switch (Player_Select_Button.tag) {
        case Rock_Key:
            [rockButton setEnabled:NO];
            scissorsButton.hidden = YES;
            paperButton.hidden = YES;
            break;
        case Scissors_Key:
            [scissorsButton setEnabled:NO];
            rockButton.hidden = YES;
            paperButton.hidden = YES;
            break;
        case Paper_Key:
            [paperButton setEnabled:NO];
            rockButton.hidden = YES;
            scissorsButton.hidden = YES;
            break;
        default:
            messageLabel.text = Error_Message;
            //リターンにするか例外を投げる
            break;
    }
    
    NSInteger Enemy_Select_Button = [self enemySelectTactics];
    
    [self JudgeWinOrLosePlayer:Player_Select_Button.tag AndEnemy:Enemy_Select_Button];
}

-(jankenKey) enemySelectTactics {
    enemySelectImage.hidden = NO;
    jankenKey Enemy_Select_Key = arc4random() % 3;
    
    //数字を使わないようにする
    switch (Enemy_Select_Key) {
        case 0:
            [enemySelectImage setImage:rockImage];
            return Rock_Key;
        case 1:
            [enemySelectImage setImage:scissorsImage];
            return Scissors_Key;
        case 2:
            [enemySelectImage setImage:paperImage];
            return Paper_Key;
        default:
            messageLabel.text = Error_Message;
            return 0;
    }
}

- (void) JudgeWinOrLosePlayer:(jankenKey)playerTacticsKey AndEnemy:(jankenKey)enemyTacticsKey {
    resultLabel.hidden = NO;
    
    //テーブルを作成して判定
    switch (playerTacticsKey) {
        case Rock_Key:
            switch (enemyTacticsKey) {
                case Rock_Key:
                    [self Draw_View_Setting];
                    break;
                case Scissors_Key:
                    [self Win_View_Setting];
                    break;
                case Paper_Key:
                    [self Lose_View_Setting];
                    break;
                default:
                    messageLabel.text = Error_Message;
                    break;
            }
            break;
        case Scissors_Key:
            switch (enemyTacticsKey) {
                case Rock_Key:
                    [self Lose_View_Setting];
                    break;
                case Scissors_Key:
                    [self Draw_View_Setting];
                    break;
                case Paper_Key:
                    [self Win_View_Setting];
                    break;
                default:
                    messageLabel.text = Error_Message;
                    break;
            }
            break;
        case Paper_Key:
            switch (enemyTacticsKey) {
                case Rock_Key:
                    [self Win_View_Setting];
                    break;
                case Scissors_Key:
                    [self Lose_View_Setting];
                    break;
                case Paper_Key:
                    [self Draw_View_Setting];
                    break;
                default:
                    messageLabel.text = Error_Message;
                    break;
            }
            break;
        default:
            messageLabel.text = Error_Message;
            break;
    }
}

- (void) Win_View_Setting {
    [resultLabel setTextColor:[UIColor Win_Color]];
    resultLabel.text = Win_Message;
    rematchButton.hidden = NO;
}

- (void) Lose_View_Setting {
    [resultLabel setTextColor:[UIColor Lose_Color]];
    resultLabel.text = Lose_Message;
    rematchButton.hidden = NO;
}

- (void) Draw_View_Setting {
    [resultLabel setTextColor:[UIColor Draw_Color]];
    resultLabel.text = Draw_Message;
    [self Initial_View];
}

- (void) Initial_View {
    [rockButton setEnabled:YES];
    [scissorsButton setEnabled:YES];
    [paperButton setEnabled:YES];
    rockButton.hidden = NO;
    paperButton.hidden = NO;
    scissorsButton.hidden = NO;
    rematchButton.hidden = YES;
}

- (IBAction)Hope_Rematch:(id)sender {
    messageLabel.text = Message_Label_Initial_Message;
    [self Initial_View];
    enemySelectImage.hidden = YES;
    [enemySelectImage setImage:nil];
    resultLabel.hidden = YES;
}
@end
