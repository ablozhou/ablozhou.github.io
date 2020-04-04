---
layout: post
title:  "react native入门"
author: "周海汉"
date:   2020-04-04 13:48:26 +0800
categories: tech
tags:
    - mac
    - react native
---

# react native 概况
React native 是facebook开源的移动框架。用JavaScript语言为主，基于React框架。 是适合跨平台移动开发的框架，具有比用webview混合开发更好的性能，又具有h5那样编写一次，跨平台运行的较低维护成本。而且可以和原生很好的结合。

重要特性如下：
## 支持 ES2015 ( ES6)

[ES2015 features](https://babeljs.io/learn-es2015/)

如
import, from，class，extends，箭头函数

## JSX
一般将代码嵌在xml里，但JSX反其道而行之。是将xml嵌在js里。

```
 <View><Text>Hello world!</Text></View>
 
 <View>类似 <div> 或 <span> 

```
 
<Text>是显示字符的[核心组件](https://reactnative.dev/docs/intro-react-native-components)
 
## 组件 （Components）
 屏幕上见到的都是组件。App是组件。组件非常基础，只需要一个render函数，返回jsx渲染。
 
 下面对相关细节进行详细介绍。
 
# 属性 Props
所有组件可以被不同参数初始化，这些参数叫props，即Properties的简写。
 
如创建组件Image，可以使用source属性来决定显示的内容。
 
 
```
 
import React, { Component } from 'react';
import { Image } from 'react-native';

export default class Bananas extends Component {
  render() {
    let pic = {
      uri: 'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg'
    };
    return (
      <Image source={pic} style={{width: 193, height: 110}}/>
    );
  }
}
```

pic外面的大括号{pic}，用于在JSX中使用变量pic。style 为什么要用双大括号？因为第一层大括号表示是js的变量，第二层大括号，就是style必须传入对象，所以用大括号括起来。
 
 下面是自定义变量
 
 ```
import React, { Component } from 'react';
import { Text, View } from 'react-native';

class Greeting extends Component {
  render() {
    return (
      <View style={{alignItems: 'center'}}>
        <Text>Hello {this.props.name}!</Text>
      </View>
    );
  }
}

export default class LotsOfGreetings extends Component {
  render() {
    return (
      <View style={{alignItems: 'center', top: 50}}>
        <Greeting name='Rexxar' />
        <Greeting name='Jaina' />
        <Greeting name='Valeera' />
      </View>
    );
  }
}

```
View 像一个容器一样，将其他组件嵌在里面。

# State 状态
组件有两种数据，一种props，一种state。
props是静态的数据，在组件整个生命周期不变。而state则是可变的。
一般初始化组件时初始化state，再用setState来修改。

```
import React, { Component } from 'react';
import { Text, View } from 'react-native';

class Blink extends Component {

  componentDidMount(){
    // Toggle the state every second
    setInterval(() => (
      this.setState(previousState => (
        { isShowingText: !previousState.isShowingText }
      ))
    ), 1000);
  }

  //state object
  state = { isShowingText: true };

  render() {
    if (!this.state.isShowingText) {
      return null;
    }

    return (
      <Text>{this.props.text}</Text>
    );
  }
}

export default class BlinkApp extends Component {
  render() {
    return (
      <View>
        <Blink text='I love to blink' />
        <Blink text='Yes blinking is so great' />
        <Blink text='Why did they ever take this out of HTML' />
        <Blink text='Look at me look at me look at me' />
      </View>
    );
  }
}
```

可以在从服务器获得数据时或者用户输入时设置状态。也可以用状态容器如：

1. [Redux](https://redux.js.org/)
2. [Mobx](https://cn.mobx.js.org/) 

来控制数据流。采用 Redux 或 Mobx修改状态而不是直接 setState.

setState 被调用时，组件会被重新渲染。

# 样式 style
所有组件都有缺省属性style。名称和值意义和css一样。但都用驼峰写法。如backgroundColor ，而非background-color。
style属性通常是普通js对象。也可以传一个style数组，最后一个同样名称的值覆盖前面的。

```
import React, { Component } from 'react';
import { StyleSheet, Text, View } from 'react-native';

const styles = StyleSheet.create({
  bigBlue: {
    color: 'blue',
    fontWeight: 'bold',
    fontSize: 30,
  },
  red: {
    color: 'red',
  },
});

export default class LotsOfStyles extends Component {
  render() {
    return (
      <View>
        <Text style={styles.red}>just red</Text>
        <Text style={styles.bigBlue}>just bigBlue</Text>
        <Text style={[styles.bigBlue, styles.red]}>bigBlue, then red</Text>
        <Text style={[styles.red, styles.bigBlue]}>red, then bigBlue</Text>
      </View>
    );
  }
}
```
[Text component reference ](https://reactnative.dev/docs/text)

## 自适应 Flex Dimensions
flex样式是自动适应的。flex: 1 适应全部空间。

```
import React, { Component } from 'react';
import { View } from 'react-native';

export default class FlexDimensionsBasics extends Component {
  render() {
    return (
      // Try removing the `flex: 1` on the parent View.
      // The parent will not have dimensions, so the children can't expand.
      // What if you add `height: 300` instead of `flex: 1`?
      <View style={{flex: 1}}>
        <View style={{flex: 1, backgroundColor: 'powderblue'}} />
        <View style={{flex: 2, backgroundColor: 'skyblue'}} />
        <View style={{flex: 3, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
}

```

# 布局
1. https://reactnative.dev/docs/flexbox
1. https://yogalayout.com/playground
1. https://reactnative.dev/docs/layout-props
1. [Wix Engineers](https://medium.com/wix-engineering/the-full-react-native-layout-cheat-sheet-a4147802405c)

flexDirection 方向主轴main axis 有如下类型

1. row
1. column (default value) 
1. row-reverse
1. column-reverse

```<View style={{flex: 1, flexDirection: 'row'}}>```
## 布局方向 Layout Direction
影响边缘开始和结束，有自左向右`LTR`和自右向左`RTL`两种模式

- LTR (缺省值) 文本和子节点排列自左向右。Margin(外边距) 和 padding (内边距) 计算元件起点以左边开始。 `start` 指向左  `end` 指向右。
- RTL 文本和子节点排列自右向左。Margin(外边距) 和 padding (内边距) 计算元件起点以右边开始。 `start` 指向右  `end` 指向左。
 
## 内容调整 justifyContent
在`容器`主轴上对子元素进行对齐。如可以将子元素横向居中排列，设置flexDirection为row即可。

有如下的值：

- flex-start(default value) Align children of a container to the start of the container's main axis.
- flex-end Align children of a container to the end of the container's main axis.
- center Align children of a container in the center of the container's main axis.
- space-between Evenly space of children across the container's main axis, distributing remaining space between the children.
- space-around Evenly space of children across the container's main axis, distributing remaining space around the children. Compared to space-between using space-around will result in space being distributed to the beginning of the first child and end of the last child.
- space-evenly Evenly distributed within the alignment container along the main axis. The spacing between each pair of adjacent items, the main-start edge and the first item, and the main-end edge and the last item, are all exactly the same.

示例：
```
import React, { Component } from 'react';
import { View } from 'react-native';

export default class JustifyContentBasics extends Component {
  render() {
    return (
      // Try setting `justifyContent` to `center`.
      // Try setting `flexDirection` to `row`.
      <View style={{
        flex: 1,
        flexDirection: 'row',
        justifyContent: 'flex-end',
      }}>
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />
        <View style={{width: 50, height: 50, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
};
```

## 对齐 alignItems 
是以容器交叉轴来对齐的。

元素对齐和 justifyContent 很像，但以交叉轴来对齐。

有如下的值：
- stretch (default value) Stretch children of a container to match the height of the container's cross axis.
- flex-start Align children of a container to the start of the container's cross axis.
- flex-end Align children of a container to the end of the container's cross axis.
- center Align children of a container in the center of the container's cross axis.
- baseline Align children of a container along a common baseline. Individual children can be set to be the reference baseline for their parents.

示例：
```
import React, { Component } from 'react';
import { View } from 'react-native';

export default class AlignItemsBasics extends Component {
  render() {
    return (
      // Try setting `alignItems` to 'flex-start'
      // Try setting `justifyContent` to `flex-end`.
      // Try setting `flexDirection` to `row`.
      <View style={{
        flex: 1,
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'stretch',
      }}>
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
        <View style={{height: 50, backgroundColor: 'skyblue'}} />
        <View style={{height: 100, backgroundColor: 'steelblue'}} />
      </View>
    );
  }
};


```
## 自身对齐 alignSelf 

和 alignItems 有一样的选项。但不是影响子元素，而是调整自身和父元素的对齐。 alignSelf覆盖父元素用alignItems设置的任何选项。

## 内容对齐 alignContent
定义交叉轴线的分布。 仅对采用flexWrap进行多线封装的元素起作用。

- flex-start (default value) Align wrapped lines to the start of the container's cross axis.
- flex-end Align wrapped lines to the end of the container's cross axis.
- stretch wrapped lines to match the height of the container's cross axis.
- center Align wrapped lines in the center of the container's cross axis.
- space-between Evenly space wrapped lines across the container's main axis, distributing remaining space between the lines.
- space-around Evenly space wrapped lines across the container's main axis, distributing remaining space around the lines. Compared to space between using space around will result in space being distributed to the begining of the first lines and end of the last line.
![image](https://cdn-images-1.medium.com/max/800/1*cC2XFyCF_igp20Ombt4wBw.png)


# 自适应换行 flexWrap 
property is set on containers and controls what happens when children overflow the size of the container along the main axis. By default children are forced into a single line (which can shrink elements). If wrapping is allowed items are wrapped into multiple lines along the main axis if needed.

When wrapping lines alignContent can be used to specify how the lines are placed in the container. learn more here

![image](https://cdn-images-1.medium.com/max/800/1*_7v4uQhSsuCn1cfeOMVfrA.png)

## Flex Basis, Grow, and Shrink
flexGrow describes how any space within a container should be distributed among its children along the main axis. After laying out its children, a container will distribute any remaining space according to the flex grow values specified by its children.

flexGrow accepts any floating point value >= 0, with 0 being the default value. A container will distribute any remaining space among its children weighted by the child’s flex grow value.

flexShrink describes how to shrink children along the main axis in the case that the total size of the children overflow the size of the container on the main axis. Flex shrink is very similar to flex grow and can be thought of in the same way if any overflowing size is considered to be negative remaining space. These two properties also work well together by allowing children to grow and shrink as needed.

Flex shrink accepts any floating point value >= 0, with 1 being the default value. A container will shrink its children weighted by the child’s flex shrink value.

flexBasis is an axis-independent way of providing the default size of an item along the main axis. Setting the flex basis of a child is similar to setting the width of that child if its parent is a container with flexDirection: row or setting the height of a child if its parent is a container with flexDirection: column. The flex basis of an item is the default size of that item, the size of the item before any flex grow and flex shrink calculations are performed.

## 宽高
宽高的值:

- auto Is the default Value, React Native calculates the width/height for the element based on its content, whether that is other children, text, or an image.
- pixels Defines the width/height in absolute pixels. Depending on other styles set on the component, this may or may not be the final dimension of the node.
- percentage Defines the width or height in percentage of its parent's width or height respectively.

## 绝对和相对布局 Absolute & Relative Layout
元素的位置(position)类型，定义该元素在父元素内的位置。

- relative (default value) By default an element is positioned relatively. This means an element is positioned according to the normal flow of the layout, and then offset relative to that position based on the values of top, right, bottom, and left. The offset does not affect the position of any sibling or parent elements.
- absolute When positioned absolutely an element doesn't take part in the normal layout flow. It is instead laid out independent of its siblings. The position is determined based on the top, right, bottom, and left values.
![image](https://cdn-images-1.medium.com/max/800/1*NlPeRQCQK3Vb5nyjL0Mqxw.png)

# 字符输入

将单词转为一个pissa
```
import React, { Component } from 'react';
import { Text, TextInput, View } from 'react-native';

export default class PizzaTranslator extends Component {
  constructor(props) {
    super(props);
    this.state = {text: ''};
  }

  render() {
    return (
      <View style={{padding: 10}}>
        <TextInput
          style={{height: 40}}
          placeholder="Type here to translate!"
          onChangeText={(text) => this.setState({text})}
          value={this.state.text}
        />
        <Text style={{padding: 10, fontSize: 42}}>
          {this.state.text.split(' ').map((word) => word && '🍕').join(' ')}
        </Text>
      </View>
    );
  }
}

```

# 触摸
[ gesture responder system ](https://reactnative.dev/docs/gesture-responder-system)

## 按钮 Button

```
<Button
  onPress={() => {
    alert('You tapped the button!');
  }}
  title="Press Me"
/>
```

```
import React, { Component } from 'react';
import { Button, StyleSheet, View } from 'react-native';

export default class ButtonBasics extends Component {
  _onPressButton() {
    alert('You tapped the button!')
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.buttonContainer}>
          <Button
            onPress={this._onPressButton}
            title="Press Me"
          />
        </View>
        <View style={styles.buttonContainer}>
          <Button
            onPress={this._onPressButton}
            title="Press Me"
            color="#841584"
          />
        </View>
        <View style={styles.alternativeLayoutButtonContainer}>
          <Button
            onPress={this._onPressButton}
            title="This looks great!"
          />
          <Button
            onPress={this._onPressButton}
            title="OK!"
            color="#841584"
          />
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   justifyContent: 'center',
  },
  buttonContainer: {
    margin: 20
  },
  alternativeLayoutButtonContainer: {
    margin: 20,
    flexDirection: 'row',
    justifyContent: 'space-between'
  }
});

```
## 触摸组件 Touchable
自定义触摸效果时使用。
触摸组件 Touchable 可以获取触摸操作的手势，当手势被识别时，可以显示相应的响应。该组件没有提供缺省的样式，所以需要做一点工作以便在app中看起来比较舒畅。

使用哪种触摸组件，取决于需要什么样的反馈。

- TouchableHighlight ：任何地方都可使用，如按钮或链接。点击时背景会变暗。
- TouchableNativeFeedback：在 Android 上点击时显示墨水波纹。
- TouchableOpacity 当被按下时，增加透明度反馈，允许背景被看到。
- TouchableWithoutFeedback：只想处理点击，但不需要任何可见的反馈，可以使用它。

```
import React, { Component } from 'react';
import { Platform, StyleSheet, Text, TouchableHighlight, TouchableOpacity, TouchableNativeFeedback, TouchableWithoutFeedback, View } from 'react-native';

export default class Touchables extends Component {
  _onPressButton() {
    alert('You tapped the button!')
  }

  _onLongPressButton() {
    alert('You long-pressed the button!')
  }


  render() {
    return (
      <View style={styles.container}>
        <TouchableHighlight onPress={this._onPressButton} underlayColor="white">
          <View style={styles.button}>
            <Text style={styles.buttonText}>TouchableHighlight</Text>
          </View>
        </TouchableHighlight>
        <TouchableOpacity onPress={this._onPressButton}>
          <View style={styles.button}>
            <Text style={styles.buttonText}>TouchableOpacity</Text>
          </View>
        </TouchableOpacity>
        <TouchableNativeFeedback
            onPress={this._onPressButton}
            background={Platform.OS === 'android' ? TouchableNativeFeedback.SelectableBackground() : ''}>
          <View style={styles.button}>
            <Text style={styles.buttonText}>TouchableNativeFeedback {Platform.OS !== 'android' ? '(Android only)' : ''}</Text>
          </View>
        </TouchableNativeFeedback>
        <TouchableWithoutFeedback
            onPress={this._onPressButton}
            >
          <View style={styles.button}>
            <Text style={styles.buttonText}>TouchableWithoutFeedback</Text>
          </View>
        </TouchableWithoutFeedback>
        <TouchableHighlight onPress={this._onPressButton} onLongPress={this._onLongPressButton} underlayColor="white">
          <View style={styles.button}>
            <Text style={styles.buttonText}>Touchable with Long Press</Text>
          </View>
        </TouchableHighlight>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    paddingTop: 60,
    alignItems: 'center'
  },
  button: {
    marginBottom: 30,
    width: 260,
    alignItems: 'center',
    backgroundColor: '#2196F3'
  },
  buttonText: {
    textAlign: 'center',
    padding: 20,
    color: 'white'
  }
});

```
# 滚动视界 ScrollView 
提供滚动展示和操作，但一次加载全部数据。

```
import React, { Component } from 'react';
import { ScrollView, Image, Text } from 'react-native';

export default class IScrolledDownAndWhatHappenedNextShockedMe extends Component {
  render() {
      return (
        <ScrollView>
          <Text style={{fontSize:96}}>Scroll me plz</Text>
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Text style={{fontSize:96}}>If you like</Text>
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Text style={{fontSize:96}}>Scrolling down</Text>
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Text style={{fontSize:96}}>What's the best</Text>
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Text style={{fontSize:96}}>Framework around?</Text>
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Image source={{uri: "https://reactnative.dev/img/tiny_logo.png", width: 64, height: 64}} />
          <Text style={{fontSize:80}}>React Native</Text>
        </ScrollView>
    );
  }
}

```

ScrollViews can be configured to allow paging through views using swiping gestures by using the pagingEnabled props. Swiping horizontally between views can also be implemented on Android using the ViewPager component.

On iOS a ScrollView with a single item can be used to allow the user to zoom content. Set up the maximumZoomScale and minimumZoomScale props and your user will be able to use pinch and expand gestures to zoom in and out.

The ScrollView works best to present a small amount of things of a limited size. All the elements and views of a ScrollView are rendered, even if they are not currently shown on the screen. If you have a long list of more items than can fit on the screen, you should use a FlatList instead.

## 平滑列表或分节列表 FlatList 或 SectionList.
The FlatList component displays a scrolling list of changing, but similarly structured, data. FlatList works well for long lists of data, where the number of items might change over time. Unlike the more generic ScrollView, the FlatList only renders elements that are currently showing on the screen, not all the elements at once.
The FlatList component requires two props: data and renderItem. data is the source of information for the list. renderItem takes one item from the source and returns a formatted component to render.

```
import React, { Component } from 'react';
import { FlatList, StyleSheet, Text, View } from 'react-native';

export default class FlatListBasics extends Component {
  render() {
    return (
      <View style={styles.container}>
        <FlatList
          data={[
            {key: 'Devin'},
            {key: 'Dan'},
            {key: 'Dominic'},
            {key: 'Jackson'},
            {key: 'James'},
            {key: 'Joel'},
            {key: 'John'},
            {key: 'Jillian'},
            {key: 'Jimmy'},
            {key: 'Julie'},
          ]}
          renderItem={({item}) => <Text style={styles.item}>{item.key}</Text>}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   paddingTop: 22
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 44,
  },
})

```
If you want to render a set of data broken into logical sections, maybe with section headers, similar to UITableViews on iOS, then a SectionList is the way to go.

```
import React, { Component } from 'react';
import { SectionList, StyleSheet, Text, View } from 'react-native';

export default class SectionListBasics extends Component {
  render() {
    return (
      <View style={styles.container}>
        <SectionList
          sections={[
            {title: 'D', data: ['Devin', 'Dan', 'Dominic']},
            {title: 'J', data: ['Jackson', 'James', 'Jillian', 'Jimmy', 'Joel', 'John', 'Julie']},
          ]}
          renderItem={({item}) => <Text style={styles.item}>{item}</Text>}
          renderSectionHeader={({section}) => <Text style={styles.sectionHeader}>{section.title}</Text>}
          keyExtractor={(item, index) => index}
        />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
   flex: 1,
   paddingTop: 22
  },
  sectionHeader: {
    paddingTop: 2,
    paddingLeft: 10,
    paddingRight: 10,
    paddingBottom: 2,
    fontSize: 14,
    fontWeight: 'bold',
    backgroundColor: 'rgba(247,247,247,1.0)',
  },
  item: {
    padding: 10,
    fontSize: 18,
    height: 44,
  },
})

```
# 网络
- [ Fetch API ](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)
- [Request](https://developer.mozilla.org/en-US/docs/Web/API/Request)

React Native 提供 Fetch API 满足网络需求。Fetch 和 XMLHttpRequest或其他网络API相似，可以参考 [MDN 指南 Using Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) 

## 同步方式
```
fetch('https://mywebsite.com/endpoint/', {
  method: 'POST',
  headers: {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    firstParam: 'yourValue',
    secondParam: 'yourOtherValue',
  }),
});
```

## Promise 方式：
```
function getMoviesFromApiAsync() {
  return fetch('https://reactnative.dev/movies.json')
    .then((response) => response.json())
    .then((responseJson) => {
      return responseJson.movies;
    })
    .catch((error) => {
      console.error(error);
    });
}
```
## ES2017 async/await方式
```
async function getMoviesFromApi() {
  try {
    let response = await fetch('https://reactnative.dev/movies.json');
    let responseJson = await response.json();
    return responseJson.movies;
  } catch (error) {
    console.error(error);
  }
}
```

## 处理错误
```
import React from 'react';
import { FlatList, ActivityIndicator, Text, View  } from 'react-native';

export default class FetchExample extends React.Component {

  constructor(props){
    super(props);
    this.state ={ isLoading: true}
  }

  componentDidMount(){
    return fetch('https://reactnative.dev/movies.json')
      .then((response) => response.json())
      .then((responseJson) => {

        this.setState({
          isLoading: false,
          dataSource: responseJson.movies,
        }, function(){

        });

      })
      .catch((error) =>{
        console.error(error);
      });
  }



  render(){

    if(this.state.isLoading){
      return(
        <View style={{flex: 1, padding: 20}}>
          <ActivityIndicator/>
        </View>
      )
    }

    return(
      <View style={{flex: 1, paddingTop:20}}>
        <FlatList
          data={this.state.dataSource}
          renderItem={({item}) => <Text>{item.title}, {item.releaseYear}</Text>}
          keyExtractor={({id}, index) => id}
        />
      </View>
    );
  }
}

```

## 其他网络库
XMLHttpRequest API 是 React Native内置的。意味着可以使用依赖它的第三方库如frisbee 或 axios , 或者直接使用 XMLHttpRequest API。

```

var request = new XMLHttpRequest();
request.onreadystatechange = (e) => {
  if (request.readyState !== 4) {
    return;
  }

  if (request.status === 200) {
    console.log('success', request.responseText);
  } else {
    console.warn('error');
  }
};

request.open('GET', 'https://mywebsite.com/endpoint/');
request.send();
```
## WebSocket
```
var ws = new WebSocket('ws://host.com/path');

ws.onopen = () => {
  // connection opened
  ws.send('something'); // send a message
};

ws.onmessage = (e) => {
  // a message was received
  console.log(e.data);
};

ws.onerror = (e) => {
  // an error occurred
  console.log(e.message);
};

ws.onclose = (e) => {
  // connection closed
  console.log(e.code, e.reason);
};
```
# 参考
https://reactnative.dev/docs/tutorial

https://facebook.github.io/react/

https://egghead.io/courses/getting-started-with-redux 视频教程

http://www.awesome-react-native.com/ 开源项目
