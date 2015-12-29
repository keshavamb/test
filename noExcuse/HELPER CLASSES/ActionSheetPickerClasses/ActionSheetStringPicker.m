//
//Copyright (c) 2011, Tim Cinel
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are met:
//* Redistributions of source code must retain the above copyright
//notice, this list of conditions and the following disclaimer.
//* Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//* Neither the name of the <organization> nor the
//names of its contributors may be used to endorse or promote products
//derived from this software without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
//DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//åLOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ActionSheetStringPicker.h"

@interface ActionSheetStringPicker()
@property (nonatomic,strong) NSArray *data;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,strong) NSString *key;

@end

@implementation ActionSheetStringPicker

+ (id)showPickerWithTitle:(NSString *)title rows:(NSArray *)data key:(NSString *)key initialSelection:(NSInteger)index doneBlock:(ActionStringDoneBlock)doneBlock cancelBlock:(ActionStringCancelBlock)cancelBlockOrNil origin:(id)origin {
    ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc] initWithTitle:title rows:data key:key initialSelection:index doneBlock:doneBlock cancelBlock:cancelBlockOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (id)initWithTitle:(NSString *)title rows:(NSArray *)data key:(NSString *)key initialSelection:(NSInteger)index doneBlock:(ActionStringDoneBlock)doneBlock cancelBlock:(ActionStringCancelBlock)cancelBlockOrNil origin:(id)origin {
    self = [self initWithTitle:title rows:data key:key initialSelection:index target:nil successAction:nil cancelAction:nil origin:origin];
    if (self) {
        self.onActionSheetDone = doneBlock;
        self.onActionSheetCancel = cancelBlockOrNil;
    }
    return self;
}

+ (id)showPickerWithTitle:(NSString *)title rows:(NSArray *)data key:(NSString *)key initialSelection:(NSInteger)index target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin {
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:title rows:data key:key initialSelection:index target:target successAction:successAction cancelAction:cancelActionOrNil origin:origin];
    [picker showActionSheetPicker];
    return picker;
}

- (id)initWithTitle:(NSString *)title rows:(NSArray *)data key:(NSString *)key initialSelection:(NSInteger)index target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin {
    self = [self initWithTarget:target successAction:successAction cancelAction:cancelActionOrNil origin:origin];
    if (self) {
        self.data = data;
        self.key= key;
        self.selectedIndex = index;
        self.title = title;
    }
    return self;
}


- (UIView *)configuredPickerView {
    if (!self.data)
        return nil;
    CGRect pickerFrame = CGRectMake(0, 40, self.viewSize.width, 216);
    UIPickerView *stringPicker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    stringPicker.delegate = self;
    stringPicker.dataSource = self;
    [stringPicker selectRow:self.selectedIndex inComponent:0 animated:NO];
    if (self.data.count == 0) {
        stringPicker.showsSelectionIndicator = NO;
        stringPicker.userInteractionEnabled = NO;
    } else {
        stringPicker.showsSelectionIndicator = YES;
        stringPicker.userInteractionEnabled = YES;
    }
    
    //need to keep a reference to the picker so we can clear the DataSource / Delegate when dismissing
    self.pickerView = stringPicker;
    
    return stringPicker;
}

- (void)notifyTarget:(id)target didSucceedWithAction:(SEL)successAction origin:(id)origin {
    if (self.onActionSheetDone) {
        if (self.key!=nil&&![self.key isEqualToString:@""]) {
            _onActionSheetDone(self, self.selectedIndex, [[self.data objectAtIndex:self.selectedIndex] objectForKey:self.key]);
        }else
            _onActionSheetDone(self, self.selectedIndex, [self.data objectAtIndex:self.selectedIndex]);
        
        return;
    }
    else if (target && [target respondsToSelector:successAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:successAction withObject:[NSNumber numberWithInt:self.selectedIndex] withObject:origin];
#pragma clang diagnostic pop
        return;
    }
    NSLog(@"Invalid target/action ( %s / %s ) combination used for ActionSheetPicker", object_getClassName(target), (char *)successAction);
}

- (void)notifyTarget:(id)target didCancelWithAction:(SEL)cancelAction origin:(id)origin {
    if (self.onActionSheetCancel) {
        _onActionSheetCancel(self);
        return;
    }
    else if (target && cancelAction && [target respondsToSelector:cancelAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:cancelAction withObject:origin];
#pragma clang diagnostic pop
    }
}




#pragma mark - UIPickerViewDelegate / DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedIndex = row;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.data.count;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [self.data objectAtIndex:row];
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.frame.size.width - 30;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    CGFloat height=30;
    if (component==0) {
        if (self.key!=nil&&![self.key isEqualToString:@""]) {
            height= 20*(([[NSString stringWithFormat:@"%@",[[self.data objectAtIndex:component] objectForKey:self.key]] length]/20)+1);
            
        }else{
            height= 20*(([[NSString stringWithFormat:@"%@",[self.data objectAtIndex:component]] length]/20)+1);
        }
    }
    if (height<30) {
        height=30;
    }
    return height;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    
    if (view == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    if (self.key!=nil&&![self.key isEqualToString:@""]) {
        label.text = [[self.data objectAtIndex:row] objectForKey:self.key];
        
    } else {
        label.text = [self.data objectAtIndex:row];
    }
    
    label.textAlignment=NSTextAlignmentCenter;
    label.numberOfLines=0;
    
    return label;
    
}

@end