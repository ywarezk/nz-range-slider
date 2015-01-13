
#nz-range-slider



Cordova plugin for native range slider selection and native slider selection.
This alows us to place a native range slider component in our hybrid app, or if we want a regular UISlider. 
The native component is based on NMRangeSlider: https://github.com/muZZkat/NMRangeSlider
Feel free to contribute to this project and help expend this plugin with more features.
You can find detailed information about how I created this plugin in this link: http://blog.nerdeez.com/?p=142



##Supported platforms


For now only iOS is supported.
Developers who wants to expend it to android are more then welcome



##Installation iOS


1. In your terminal type
  ```bash
  cordova plugin add https://github.com/ywarezk/nz-range-slider.git 
  ```
2. In your native installation, inside your plugin group, you will find the native code copied along with the images of the plugin. 
Create groups for those images based on the group that's in the plugin src folder of iOS. 
Meanning you should divide the images to 3 groups: DefaultTheme, DefaultTheme7, MetalTheme
Would be nice if they were auto created in the plugin installation but i didn't manage to understand how to create the from the plugin.xml.
Help would be appreciated
3. Also if you have a problem seeing the range slider, then in the plugin group copy the folders: DefaultTheme, DefaultTheme7, MetalTheme to the plugins folder in your xcode project.



##Show the slider


```
RangeSlider.showSlider(<Options>);
```
Options is a disctionary.
For now the options are pretty minimalist and if someone would want to expend them they are more then welcomed. 
The options are:

1. minimumValue - minimum value of the slider


2. maximumValue - maximum value of the slider


3. stepValue - the minimum amount we can increase seach slider

4. isSingleSlider - boolean value that defaults to false, if true then a regular UISlider will be presented. the value of this slider we get from getMax method



##Hide the slider


Will make the slider disappear 
```
RangeSlider.hideSlider();
```



##Get slider values


```
//get the left handle value
RangeSlider.getMin(<callback>);

//get the right handle value, of regular UISlider this will be used to get the value
RangeSlider.getMax(<callback>)
```

Since these functions returns the value asynchronosly, we need to add a vallback function inside them. 
The callback function is with the following signature: 
```
function valueCallback(valueFromSlider){
	alert('We got the following value from the slider: ' + valueFromSlider);
}
``` 



##Event value changed


You can also subscribe for an event of range slider values changed by doing the following: 
```
document.addEventListener('rangeChanged', <callback>, false);
```
The callback function will be called whenever the range is changed





