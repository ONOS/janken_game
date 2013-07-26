//
//  ViewController.h
//  Janken_game
//
//  Created by 小野 正太郎 on 13/07/19.
//  Copyright (c) 2013年 小野 正太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
//数字をじゃんけんのキーとして登録
#define Rock_Key 1
#define Scissors_Key 2
#define Paper_Key 3
//UIに表示される日本語をまとめて登録
#define Rematch_Button_Initial_Message @"もういっかい"
#define Message_Label_Initial_Message @"じゃんけん・・・　　　　"
#define Message_Label_Game_Message @"じゃんけん・・・ぽんっ！"
#define Win_Message @"あなたの勝ち！"
#define Lose_Message @"あなたの負け！"
#define Draw_Message @"あいこで・・・"
#define Error_Message @"不正な値が入力されました"
//結果表示時の文字のカラー変更を登録
#define Win_Color blueColor
#define Lose_Color redColor
#define Draw_Color blackColor


@interface ViewController : UIViewController {
    IBOutlet UIButton *Rock_Button;
    IBOutlet UIButton *Scissors_Button;
    IBOutlet UIButton *Paper_Button;
    IBOutlet UIButton *Rematch_Button;
    IBOutlet UILabel *Message_Label;
    IBOutlet UILabel *Result_Label;
    IBOutlet UIImageView *Enemy_Select_Image;
    
    UIImage *Rock_Image;
    UIImage *Scissors_Image;
    UIImage *Paper_Image;
}

//じゃんけんのボタンを押したときに呼び出されるメソッド
- (IBAction)Player_Select_Tactics:(id)sender;
//相手の手の選択と表示を行うメソッド
- (NSInteger) Enemy_Select_Tactics;
//入力された手に応じて勝敗を判定して指定のメソッドを呼び出すメソッド
- (void) Decide_Win_or_Lose_Player:(NSInteger)Player_Tactics_Key _and_Enemy:(NSInteger)Enemy_Tactics_Key;
//勝ち、負け、またはあいこの場合の処理を行うメソッド
- (void) Win_View_Setting;
- (void) Lose_View_Setting;
- (void) Draw_View_Setting;
//じゃんけんボタンの表示と有効化を行い画面を初期化するメソッド
- (void) Initial_View;
//再戦ボタンの押したときに呼び出されるメソッド
- (IBAction)Hope_Rematch:(id)sender;
@end
