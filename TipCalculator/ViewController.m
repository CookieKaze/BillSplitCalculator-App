//
//  ViewController.m
//  TipCalculator
//
//  Created by Erin Luu on 2016-11-11.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISlider *peopleSlider;
@property (weak, nonatomic) IBOutlet UILabel *splitAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *peopleNumTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}
- (IBAction)updatePeopleNumber:(UISlider *)sender {
    [self checkForNil];
    int peopleNum = (int)self.peopleSlider.value;
    self.peopleNumTextField.text = [NSString stringWithFormat:@"%d",peopleNum];
    NSDecimalNumber * billAmount = [NSDecimalNumber decimalNumberWithString:self.billAmountTextField.text];
    NSDecimalNumber * tipPercentage = [NSDecimalNumber decimalNumberWithString:self.tipPercentageTextField.text];
    NSDecimalNumber * totaTip = [billAmount decimalNumberByMultiplyingBy:tipPercentage];
    NSDecimalNumber * totalAmount = [billAmount decimalNumberByAdding: totaTip];
    self.tipAmountLabel.text = [NSString stringWithFormat: @"Tip Amounts: %@",[NSNumberFormatter localizedStringFromNumber:totaTip numberStyle:NSNumberFormatterCurrencyStyle]];
    NSDecimalNumber * numberOfPeople = [[NSDecimalNumber alloc] initWithInt:peopleNum];
    NSDecimalNumber * totalAfterSplit = [totalAmount decimalNumberByDividingBy:numberOfPeople];
    self.splitAmountLabel.text = [NSString stringWithFormat: @"Everyone Pays: %@",[NSNumberFormatter localizedStringFromNumber:totalAfterSplit numberStyle:NSNumberFormatterCurrencyStyle]];
}
- (IBAction)onPeopleChange:(UITextField *)sender {
    if ([self.peopleNumTextField.text intValue]<9 && [self.peopleNumTextField.text intValue]>0){
        self.peopleSlider.value = [self.peopleNumTextField.text intValue];
    }
}
-(void) checkForNil {
    if (self.billAmountTextField.text.length <= 0) {
        self.billAmountTextField.text = @"0";
    }
    if (self.tipPercentageTextField.text.length <= 0) {
        self.tipPercentageTextField.text = @"0";
    }
}

#pragma Keyboard Show Hide Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)scrollViewTapRecognizer:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:0.6 animations:^{
        [self.billAmountTextField resignFirstResponder];
        [self.tipPercentageTextField resignFirstResponder];
        [self.peopleNumTextField resignFirstResponder];
    }];
}

-(void) keyboardWillShow: (NSNotification *) sender {
    CGSize keyboardSize = [[[sender userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.scrollView.frame;
        f.size.height -= keyboardSize.height;
        self.scrollView.frame = f;
    }];
    
}
-(void) keyboardWillHide: (NSNotification *) sender {
    CGSize keyboardSize = [[[sender userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.scrollView.frame;
        f.size.height += keyboardSize.height;
        self.scrollView.frame = f;
    }];
}
@end
