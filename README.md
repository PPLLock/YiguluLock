# YiguluLock
 
This project demonstrates the use of the libPPL Lock.a static library SDK

Manual integration

Drag the libPPLLock.a and PPLLock.h files into your Xcode project

Introduction

Import the header file in the class you need to use

import "PPLLock.h"

Create a PPLLock object and set the delegate object

PPLLock * PPObject =  [[PPLLock alloc] initWithDelegate:self];

Please refer to the documentation for detailed use.

