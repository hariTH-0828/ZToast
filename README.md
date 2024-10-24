<div align="center">
  <h1 align="center">ZToast</h1>
  <p align="center">
  This project provides a customizable <b>ZToast View</b> system for <b>SwiftUI</b>. You can easily display temporary messages in your app, styled using custom or predefined toast styles. It also includes environment-based configuration for consistent styling throughout your app.
</p>
</div>


## Features
 **Custom Toast Styles**: Define your own styles or use predefined ones like `DefaultToastStyle` or `SnackBarToastStyle`. 
 **Environment Integration**: Set a default toast style for the entire view hierarchy using environment values. 
 **Flexible Binding Control**: Use bindings to control when to show or hide the toast.
 
 ---
## Installation 
To integrate **ZToast** into your project, add the following to your `Podfile`: 
```ruby
source 'https://zrepository.zoho.com/zohocorp/user/Harisaravanan/Podspecs.git'

pod 'ZToast'
```

## Usage
### 1. Displaying a Toast
To show a toast message, use the `showToast(message:isShowing:)` method on any `View`:

```Swift
import SwiftUI
struct ContentView: View {
    @State private var isToastVisible: Bool = false

    var body: some View {
        VStack {
            Button("Show Toast") {
                isToastVisible = true
            }
        }
        .showToast(message: "This is a custom toast!", isShowing: $isToastVisible)
    }
}
```
https://github.com/user-attachments/assets/52c1fa5c-f64e-478b-8bfd-7622dfd1628e

https://github.com/user-attachments/assets/33dfb88e-ef4d-4058-8a25-fb463833445d

### 2. Applying a Custom Toast Style
You can customize how your toast looks by using different styles. Here's how to set the `DefaultToastStyle`:

```Swift
struct ContentView: View {
    @State private var isToastVisible: Bool = false

    var body: some View {
        VStack {
            Button("Show Toast") {
                isToastVisible = true
            }
        }
        .showToast(message: "Default style toast!", isShowing: $isToastVisible)
        .toastViewStyle(.defaultToastStyle)  // Applying default toast style
    }
}
```
### 3. Defining a Custom Toast Style
To create your own toast style, conform to the `ToastViewStyle` protocol:

```Swift
struct MyCustomToastStyle: ToastViewStyle {
    func makeBody(message: String?) -> some View {
        Text(message ?? "No message")
            .padding()
            .background(Color.blue.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

extension ToastViewStyle where Self == MyCustomToastStyle {
	static var myCustomToastStyle: MyCustomToastStyle {
		return MyCustomToastStyle()
	}
}
```
Then, apply it to your views like this:
```Swift
struct ContentView: View {
    @State private var isToastVisible: Bool = false

    var body: some View {
        VStack {
            Button("Show Custom Toast") {
                isToastVisible = true
            }
        }
        .showToast(message: "Custom styled toast!", isShowing: $isToastVisible)
        .toastViewStyle(.myCustomToastStyle)  // Applying custom toast style
    }
}
```
