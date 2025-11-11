---
title: "Octopress: a new beginning"
date: 2012-02-18T12:00:00Z
draft: false
description: "Starting yet another blog with Octopress framework for Jekyll - deploying to Amazon S3 with s3cmd"
---

Starting a new blog. I've done this countless times and yet I never managed to keep current with any.
*Oops, I did it again...* as a famous Britney sang.

This time I'm using the brilliant [Octopress](http://octopress.org "Octopress website") framework for [Jekyll](http://github.com/mojombo/jekyll "Jekyll website") static blog generator. Yes, this automatically implies I'm a hacker. Throw the stone at me if you think you really know the true meaning of "hacker". I can safely admit I really like hacking at the source of the software I use especially when I can read and understand the code it's written in.

Let me introduce myself. Hi! I'm Andrea a web developer by chance and an [MD](http://en.wikipedia.org/wiki/Doctor_of_Medicine "Wikipedia Doctor of Medicine page") by education (*NDA: is this English?*) and a photographer by leisure and... recently somebody different, with eyes narrowly open.
<!-- more -->

The goal of this first post was simply to illustrate what I did in practice before starting writing these words. I'll have a try at that now.

I use a MacBook Air with OS-X Lion for my development *hobwork* (neologism expressing the middle line between hobby and work) and I easily followed the instructions at [Octopress site](http://octopress.org/docs/setup/ "Octopress setup page") since I already had [Git](http://git-scm.com/ "Git webwite") and [RVM](http://rvm.beginrescueend.com/ "RVM website") installed and working.

These steps were easy:
```
git clone git://github.com/imathis/octopress.git myblog # I cloned into a custom directory
bundle install                                          # install bundler gem before this
rake install                                            # default Octopress theme (awesome!)
```

Testing the installation was even easier:
```
rake preview
```

My still empty blog was easily found at http://localhost:4000.

My next goal was to find a simple and cheap way to deploy. I thought about deploying at [Github](https://github.com/ "Github website") but I don't have a payed plan yet and I plan to upload a bunch of photographs. I have an [Amazon Web Services](https://aws.amazon.com/ "Amazon Web Services website") account which costs me almost nothing and I quickly googled a way to [deploy Octopress to Amazon S3](http://www.google.fr/search?ix=sea&sourceid=chrome&ie=UTF-8&q=leisure#pq=leisure&hl=fr&gs_nf=1&cp=13&gs_id=1f&xhr=t&q=octopress+amazon+s3&pf=p&sclient=psy-ab&source=hp&pbx=1&oq=octopress+ama&aq=0L&aqi=g-L2&aql=&gs_sm=&gs_upl=&bav=on.2,or.r_gc.r_pw.r_cp.,cf.osb&fp=6fc8c6804cede81f&ix=sea&biw=945&bih=779 "Google query for 'octopress amazon s3'"). The third search result made my day.

The solution was to add a Rake task to deploy to an Amazon S3 bucket using a nice command line tool called [s3cmd](http://s3tools.org/s3cmd "s3cmd website"). The s3cmd site made no mention of a OS-X binary so I turned to the loyal [Homebrew](http://mxcl.github.com/homebrew/ "Homebrew website") and installed:
```
$ brew search s3
s3-backer   s3cmd       s3fs        s3sync      unfs3
$ brew install s3cmd
==> Downloading http://downloads.sourceforge.net/project/s3tools/s3cmd/1.0.1/s3cmd-1.0.1.tar.gz
######################################################################## 100,0%
/usr/local/Cellar/s3cmd/1.0.1: 18 files, 236K, built in 2 seconds
```

I then followed the instructions and was deploying the empty blog 2 minutes later.
Well, that's it, the fun starts now and I hope to [stay awhile, stay FOREVER!](http://www.google.fr/url?sa=t&rct=j&q=stay%20awhile%20stay%20forever&source=web&cd=4&ved=0CD8QFjAD&url=http%3A%2F%2Fc64-wiki.com%2Findex.php%2FImpossible_Mission&ei=97g_T62sCsqJ0AWwyKSPDw&usg=AFQjCNF0LIdcda82RB69CvnMtXV3zoIFig&sig2=InIDbucTVRvavRJYd7QfTQ "C64-Wiki website - Impossible Mission page")
