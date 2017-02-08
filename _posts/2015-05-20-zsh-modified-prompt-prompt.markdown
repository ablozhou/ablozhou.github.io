---
author: abloz
comments: true
date: 2015-05-20 03:31:57+00:00
layout: post
link: http://abloz.com/index.php/2015/05/20/zsh-modified-prompt-prompt/
slug: zsh-modified-prompt-prompt
title: zsh修改prompt提示符
wordpress_id: 2289
categories:
- 技术
tags:
- zsh
---

原始zsh提示符过于简单，不方便复制输出内容。所以将其修改一下：

编辑.zshrc

输入如下

```
export PROMPT="%{$fg_bold[green]%}%n@%{$fg[cyan]%}%c                                            %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}%# % %{$reset_color%}"
```

修改后，提示如下：

```
zhh@~ % cd go
zhh@go %
```

如需要恢复成老的，改成如下：

```
export PROMPT="${ret_status}%{$fg_bold[green]%}%n@ %{$fg[cyan]%}%c                             %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}%# "
```

