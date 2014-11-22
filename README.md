<h1>
nz-range-slider
<h1>

<p>
Cordova plugin for native range slider selection.
This alows us to place a native range slider component in our hybrid app. 
The native component is based on NMRangeSlider: https://github.com/muZZkat/NMRangeSlider
Feel free to contribute to this project and help expend this plugin with more features.
You can find detailed information about how I created this plugin in this link: http://blog.nerdeez.com/?p=142
</p>

<h2>
Supported platforms
</h2>
<p>
For now only iOS is supported.
Developers who wants to expend it to android are more then welcome
</p>

<h2>
Installation iOS
</h2>
<p>
<ul>
<li>
In your terminal type
```
cordova plugin add https://github.com/ywarezk/nz-range-slider.git
```
</li>
<li>
In your native installation, inside your plugin group, you will find the native code copied along with the images of the plugin. 
Create groups for those images based on the group that's in the plugin src folder of iOS. 
Meanning you should divide the images to 3 groups: DefaultTheme, DefaultTheme7, MetalTheme
Would be nice if they were auto created in the plugin installation but i didn't manage to understand how to create the from the plugin.xml.
Help would be appreciated
</li>
</ul>
</p>

<h2>
Show the slider
</h2>
<p>
```
RangeSlider.showSlider(<Options>);
```
Options is a disctionary.
For now the options are pretty minimalist and if someone would want to expend them they are more then welcomed. 
The options are:
<ul>
<li>
minimumValue - minimum value of the slider
</li>
<li>
maximumValue - maximum value of the slider
</li>
<li>
stepValue - the minimum amount we can increase seach slider
</li>
</ul>
</p>

<h2>
Hide the slider
</h2>
<p>
Will make the slider disappear 
```
RangeSlider.hideSlider();
```
</p>

<h2>
Get slider values
</h2>
<p>
```
//get the left handle value
RangeSlider.getMin(<callback>);

//get the right handle value
RangeSlider.getMax(<callback>)
```

Since these functions returns the value asynchronosly, we need to add a vallback function inside them. 
The callback function is with the following signature: 
```
function valueCallback(valueFromSlider){
	alert('We got the following value from the slider: ' + valueFromSlider);
}
``` 
</p>

<h2>
Event value changed
</h2>
<p>
You can also subscribe for an event of range slider values changed by doing the following: 
```
document.addEventListener('rangeChanged', <callback>, false);
```
The callback function will be called whenever the range is changed
</p>




