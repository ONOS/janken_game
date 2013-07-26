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
    //イメージにファイルを格納
    Rock_Image = [UIImage imageNamed:@"gu.png"];
    Scissors_Image = [UIImage imageNamed:@"ch.png"];
    Paper_Image = [UIImage imageNamed:@"pa.png"];
    //ボタンのタグにキーを格納
    Rock_Button.tag = Rock_Key;
    Scissors_Button.tag = Scissors_Key;
    Paper_Button.tag = Paper_Key;
    //画面の初期化
    Message_Label.text = Message_Label_Initial_Message;
    Enemy_Select_Image.hidden = YES;
    Result_Label.hidden = YES;
    [Rematch_Button setTitle:Rematch_Button_Initial_Message forState:UIControlStateNormal];
    Rematch_Button.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Player_Select_Tactics:(id)sender {
    Message_Label.text = Message_Label_Game_Message;
    
    UIButton *Player_Select_Button = (UIButton*) sender;
    
    switch (Player_Select_Button.tag) {
        case Rock_Key:
            [Rock_Button setEnabled:NO];
            Scissors_Button.hidden = YES;
            Paper_Button.hidden = YES;
            break;
        case Scissors_Key:
            [Scissors_Button setEnabled:NO];
            Rock_Button.hidden = YES;
            Paper_Button.hidden = YES;
            break;
        case Paper_Key:
            [Paper_Button setEnabled:NO];
            Rock_Button.hidden = YES;
            Scissors_Button.hidden = YES;
            break;
        default:
            Message_Label.text = Error_Message;
            break;
    }
    
    NSInteger Enemy_Select_Button = [self Enemy_Select_Tactics];
    
    [self Decide_Win_or_Lose_Player:Player_Select_Button.tag _and_Enemy:Enemy_Select_Button];
}

-(NSInteger) Enemy_Select_Tactics {
    Enemy_Select_Image.hidden = NO;
    NSInteger Enemy_Select_Key = arc4random() % 3;
    
    switch (Enemy_Select_Key) {
        case 0:
            [Enemy_Select_Image setImage:Rock_Image];
            return Rock_Key;
        case 1:
            [Enemy_Select_Image setImage:Scissors_Image];
            return Scissors_Key;
        case 2:
            [Enemy_Select_Image setImage:Paper_Image];
            return Paper_Key;
        default:
            Message_Label.text = Error_Message;
            return 0;
    }
}

- (void) Decide_Win_or_Lose_Player:(NSInteger)Player_Tactics_Key _and_Enemy:(NSInteger)Enemy_Tactics_Key {
    Result_Label.hidden = NO;
    
    switch (Player_Tactics_Key) {
        case Rock_Key:
            switch (Enemy_Tactics_Key) {
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
                    Message_Label.text = Error_Message;
                    break;
            }
            break;
        case Scissors_Key:
            switch (Enemy_Tactics_Key) {
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
                    Message_Label.text = Error_Message;
                    break;
            }
            break;
        case Paper_Key:
            switch (Enemy_Tactics_Key) {
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
                    Message_Label.text = Error_Message;
                    break;
            }
            break;
        default:
            Message_Label.text = Error_Message;
            break;
    }
}

- (void) Win_View_Setting {
    [Result_Label setTextColor:[UIColor Win_Color]];
    Result_Label.text = Win_Message;
    Rematch_Button.hidden = NO;
}

- (void) Lose_View_Setting {
    [Result_Label setTextColor:[UIColor Lose_Color]];
    Result_Label.text = Lose_Message;
    Rematch_Button.hidden = NO;
}

- (void) Draw_View_Setting {
    [Result_Label setTextColor:[UIColor Draw_Color]];
    Result_Label.text = Draw_Message;
    [self Initial_View];
}

- (void) Initial_View {
    [Rock_Button setEnabled:YES];
    [Scissors_Button setEnabled:YES];
    [Paper_Button setEnabled:YES];
    Rock_Button.hidden = NO;
    Paper_Button.hidden = NO;
    Scissors_Button.hidden = NO;
    Rematch_Button.hidden = YES;
}

- (IBAction)Hope_Rematch:(id)sender {
    Message_Label.text = Message_Label_Initial_Message;
    [self Initial_View];
    Enemy_Select_Image.hidden = YES;
    [Enemy_Select_Image setImage:nil];
    Result_Label.hidden = YES;
}
@end
