
#nz-range-slider



Cordova plugin for native range slider selection and native slider selection.
This allows us to place a native range slider component in our hybrid app, or alternatively, a regular UISlider. 
The native component is based on NMRangeSlider: https://github.com/muZZkat/NMRangeSlider.
Feel free to contribute to this project and help expand this plugin with more features.
You can find detailed information about how I created this plugin here: http://blog.nerdeez.com/?p=142



##Supported platforms

iOS, Android


##Installation


1. In your terminal type
  ```bash
  cordova plugin add https://github.com/ywarezk/nz-range-slider.git 
  ```
  For a Meteor Cordova app, type
  ```meteor add cordova:com.rangeslider.sdk@https://github.com/ywarezk/nz-range-slider/tarball/<SHA of last commit>```
2. In your native installation, inside your plugin group, you will find the native code copied along with the images of the plugin. 
Create groups for those images based on the group that's in the plugin src folder of iOS. 
Meanning you should divide the images to 3 groups: DefaultTheme, DefaultTheme7, MetalTheme.
Would be nice if they were auto created in the plugin installation, but I didn't quite understand how to create them from the plugin.xml.
Help would be appreciated.
3. Also, if you have a problem seeing the range slider, then in the plugin, group copy the folders: DefaultTheme, DefaultTheme7, MetalTheme to the plugins folder in your Xcode project.

API
===

##Show the slider


```
RangeSlider.showRangeSlider(<Options>); // RangeSlider

or

RangeSlider.showSingleSlider(<Options>); // regular UISlider
```
Options is a dictionary.
For now the options are pretty minimalist and if someone would want to expand them they are more then welcome. 
The options are:

1. minimumValue - minimum value of the slider (default: 14)


2. maximumValue - maximum value of the slider (default: 60)


3. lowerValue - the lowest value the slider can have (default: minimumValue)


4. upperValue - the highest value the slider can have (default: maximumValue)


position of slider on screen:

5. left - (default: 5)

6. top - (default: middle of screen)

7. width - (default: screen width - 10)


the following options apply only to the RangeSlider (not avilable for UISlider)

8. stepValue - the amount the slider value increases for each step (default: 1)

8. showCaptions - show the current values on the handles (default: false)


##Hide the slider


Will make the slider disappear 
```
RRangeSlider.hideRangeSlider(); // RangeSlider

or

RangeSlider.hideSingleSlider(); // regular UISlider
```



##Get slider values


```
//get the left handle value of range slider
RangeSlider.getMin(<callback>);

//get the right handle value of range slider
RangeSlider.getMax(<callback>)

//get handle value of the UISlider
RangeSlider.getValue(<callback>)
```

Since these functions returns the value asynchronosly, we need to add a callback function inside them. 
The callback function receives a single parameter that contains the slider value: 
```
function valueCallback(valueFromSlider){
	alert('We got the following value from the slider: ' + valueFromSlider);
}
``` 



##Event value changed


You can also subscribe to a change event by doing the following: 
```
document.addEventListener('rangeChanged', <callback>, false); // for range slider

or

document.addEventListener('singleRangeChanged', <callback>, false); // for single UISlider
```
The callback function will be called whenever the range changes





