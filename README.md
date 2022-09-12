# vgv_assessment

Very Good Coffee App

## Getting Started

To run this app you can run `flutter run` in your terminal and it will target a device/simulator/emulator that you currently have running.

if you are using vscode I have also included a `launch.json` that can be used to run the application in your debugger by selecting the `run and debug` menu item in the side bar and then clicking the green arrow button in the top left.

## How the app works

When you first load the app it will bring you to a page where a coffee image will be displayed. There are two buttons that you can interact with:
- The `heart/favorite` icon where you can favorite an image.  This will save that image locally using `shared_preferences` (There is probably a better image storage solution out there but I went with this for simplicity and familiarity)
- The `Next Image` button will load the next image and reset the favorite icon if an image was favorited

### Navigation
The app has two pages: 
- Home (Where you can cycle through and favorite images)
- Favorites (Where you can view and delete your favorite images)

You can switch between the two of them using the bottom navigation.  That is tapping on the home or favorites icon at the bottom of the app screen.