//
//  ViewController.h
//  Janken_game
//
//  Created by 小野 正太郎 on 13/07/19.
//  Copyright (c) 2013年 小野 正太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

//数字をじゃんけんのキーとして登録
typedef enum {
	rockKey = 789,
	scissorsKey = 123,
	paperKey = 456,
    errorKey = 999,
} jankenKey;

//数字を勝ち負けのキーとして登録
typedef enum {
    winKey = 10,
    loseKey,
    drawKey,
} resultKey;

//UIに表示される日本語をまとめて登録
NSString* const rematchButtonInitialMessage = @"もういっかい";
NSString* const messageLabelInitialMessage = @"じゃんけん・・・　　　　";
NSString* const messageLabelGameMessage = @"じゃんけん・・・ぽんっ！";
NSString* const winMessage = @"あなたの勝ち！";
NSString* const loseMessage = @"あなたの負け！";
NSString* const drawMessage = @"あいこで・・・";
NSString* const errorMessage = @"不正な値が入力されました";

//結果表示時の文字のカラー変更を登録
#define winColor blueColor
#define loseColor redColor
#define drawColor blackColor


@interface ViewController : UIViewController {
    IBOutlet UIButton *rockButton;
    IBOutlet UIButton *scissorsButton;
    IBOutlet UIButton *paperButton;
    IBOutlet UIButton *rematchButton;
    IBOutlet UILabel *messageLabel;
    IBOutlet UILabel *resultLabel;
    IBOutlet UIImageView *enemySelectImage;
    
    UIImage *rockImage;
    UIImage *scissorsImage;
    UIImage *paperImage;
}

//じゃんけんのボタンを押したときに呼び出されるメソッド
- (IBAction)playerSelectTactics:(id)sender;
//相手の手の選択と表示を行うメソッド
- (jankenKey) enemySelectTactics;
//入力された手に応じて勝敗を判定して指定のメソッドを呼び出すメソッド
- (void) judgeWinOrLosePlayer:(jankenKey)playerTacticsKey AndEnemy:(jankenKey)enemyTacticsKey;
//勝ち、負け、またはあいこの場合の処理を行うメソッド
- (void) winViewSetting;
- (void) loseViewSetting;
- (void) drawViewSetting;
//じゃんけんボタンの表示と有効化を行い画面を初期化するメソッド
- (void) initializeView;
//再戦ボタンの押したときに呼び出されるメソッド
- (IBAction)hopeRematch:(id)sender;
@end
