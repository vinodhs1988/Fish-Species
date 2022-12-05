# Fish-Species

This project was developed in MVVM architecture 

This project loads the data from the API `https://www.fishwatch.gov/api/species`

### Xcode version used
XCode 13.4.1

### Minimum iOS version Supported

iOS 13

### Devices Supported
  iPhone

### 3rd Party Dependency
`https://github.com/SDWebImage/SDWebImage`
This library provides an async image downloader with cache support. For convenience, we added categories for UI elements like `UIImageView`

To run this project you need to follow these steps:
 1. Need to install cocopods `https://cocoapods.org`
 2. Then open terminal and navigate to the folder `~/Fish-Species/FishSpecies` then use command `pod install`
 3. If any error occured during installation use command `pod install --repo-udpate`
 3. After pod installation open `~/Fish-Species/FishSpecies/FishSpecies.xcworkspace` in xcode, will be able to run the project 

### Concepts Covered 
1. MVVM
2. SOLID principles
3. Secutiy measures 
   - Jail break detection (  Jail break detection code added as extension of `UIDevice`)

### Steps to Test Jail Break code 
  1. Navigate to `CommonExtensions.swift` file and `return TRUE` in that method. 
  2. To test in simulator comment out the line `if UIDevice.current.isSimulator { return false }`. 
  3. Now run the app, you will see alert without okay button, user will be not be able to use the app.
  
### Logic used to detect device is JailBroken
 1. Jail broken app like Cydia app is installed in Device or not
 2. Able to open/write system related file or not


### System Requirement
 1. mac OS Monterey
 2. XCode 13

### Upcoming improvements
 1. Snapshot for UI testing 
 2. Creating seperate package/pod for maintaining UI components and networking
 3. Maintain screen navigation in one place (coordinator pattern)
 4. Async/await or PromiseKit for handling structured async operation  

### Screenshots

  1. Test Case Execution
  
<img width="268" alt="Screenshot 2022-12-05 at 4 23 21 PM" src="https://user-images.githubusercontent.com/108928613/205621785-670f6880-30d0-4f48-af71-2e68d37be367.png">

  2. Test Case Coverage

<img width="982" alt="Screenshot 2022-12-05 at 4 23 50 PM" src="https://user-images.githubusercontent.com/108928613/205621951-bd440cf1-1e6b-4020-8231-f4db0c20731d.png">


  3. App Landing Screen
  
  <img width="982" alt="Simulator Screen Shot - iPhone 8 - 1" src="https://user-images.githubusercontent.com/108928613/205622086-96dfb3c5-21f9-48ff-b931-37b6db706257.png">
  
  4. App Description Screen
  
  <img width="982" alt="Simulator Screen Shot - iPhone 8 - 2" src="https://user-images.githubusercontent.com/108928613/205622178-d533911d-5bef-4bbb-ba74-bfeaf07c00f3.png">
  
  5. Screen Recording

https://user-images.githubusercontent.com/108928613/205629354-11b436d0-5f65-4926-ac55-bd14f92262e4.mov






