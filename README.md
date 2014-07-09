ios-ui-tools
============

ios-ui-tools is a collection of useful classes and categories that provide a foundation upon which you can build ios apps.

The starting point is the category NSViewController+NCJKeyboardAccessory. This category takes care of most things you initially think a form should automatically do: hiding the keyboard when you tap outside a TextField, resizing the view when the keyboard appears so no fields are hidden by it, and provide an accessory view on top of the keyboard with a "Done" button to hide the keyboard and a "Next" and "Previous" buttons to navigate among text fields.
If you're new to iOS development you will soon find that those features are not provided: you must code them yourself (until now).

However, this category comes with some other useful classes and categories on which it relies and which can also be useful by themselves, like basic theming support.

How to use ios-ui-tools
=======================

Download the source or clone the repository, then add the files in the ios-ui-tools folder to your project.

In your app delegate add this line to the didFinishLaunchingWithOptions method:
<pre>
[[NCJAppSingleton sharedInstance] customizeAppearance:_window];
</pre>

This will setup several UI settings for your app, based on the current selected theme.

To add the automatic keyboard hiding feature, view resizing and basic accessory view over the keyboard with a "Done" button, you need to add 3 lines of code.
First, to the viewDidLoad method:
<pre>
self.ncj_viewToResize = _tableView;
</pre>
Substituting _tableView with the view that contains the text fields and which should be resized when the keyboard is shown.

To the viewDidAppear method:
<pre>
[self ncj_registerKeyboardAccessoryHandler];
</pre>

And to the viewDidDisappear method:
<pre>
[self ncj_unregisterKeyboardAccessoryHandler];
</pre>

And finally, make sure that every UITextField has the view controller as its delegate, either from IB or from your code.
<pre>
textField.delegate = self;
</pre>

That's it. When you tap a TextField and the keyboard is shown:
* the view is resized to the available space (so no fields will be hidden by the keyboard)
* the keyboard has a toolbar on top of it with a Done button which dismisses the keyboard and finishes editing the TextField
* when you tap outside the TextField the keyboard is also hidden
* when the keyboard hides, the view is resized again to its original size

If you want to provide navigation through the fields in your view, you just need to add initialiaze the sorted fields array and add the text fields in the right order to it. For example:
<pre>
self.ncj_sortedTextFields = [NSMutableArray array];
[self.ncj_sortedTextFields addObject:textField1];
[self.ncj_sortedTextFields addObject:textField2];
[self.ncj_sortedTextFields addObject:textField3];
</pre>

That will make the toolbar display a Prev and Next button, which will be enabled or disabled depending on the field currently selected.

You can change the Next and Prev buttons to show an image instead of text, just set the "ncj_prevButtonImageName" and "ncj_nextButtonImageName" to the names of the images you want to use.

This category also takes into account the returnKeyType property of text fields:
* if you set it to UIReturnKeyNext, the keyboard will display a Next button instead of a Return button and when the user taps it, it will do the same as if she taps the Next button on the keyboard accessory view.
* if you set it to UIReturnKeyGo, when the user taps the Go button it will try to execute the block assigned to the ncj_goBlock property. It is a block that receives the text field as a parameter.

Example of the ncj_goBlock property usage:
<pre>
self.ncj_goBlock = ^( UITextField *field ) {
  field.text = NSLocalizedString( @"Go!", nil );
};
</pre>

Other useful things that you can find here:

* UIColor+NCJColorWithARGB category: provides a ncj_colorWithARGB method with a single parameter for creating an UIColor insance. This is very useful when using colors from CSS stylesheets or from graphical design software.
* NSObject+NCJProtocolOptionalMethod category: provides a simple way to safely call optional methods of a category over an object.


You can find a complete example app with the source code. It has a view which uses a TableView to hold a form with a couple of TextFields, and another view which uses a simple view with some text fields in it.
