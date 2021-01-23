# Find-Interlaced-Videos
Lets you quickly create a list of videos that seem to be interlaced using ffmpeg on macOS

There's a new version of [Topaz Video Enhance AI](https://topazlabs.com/video-enhance-ai/) (VEAI) that can take interlaced footage and create a double-framerate version by interpolating the missing half of each interlaced frame. Cool stuff! I wanted to kick the tires on it, but I know of no easy way to determine which videos I have are interlaced short of opening and inspecting each one individually. Worse, many interlaced videos have incorrect metadata, so finding these files isn't as simple as looking for this flag. 

Thankfully, ffmpeg includes a tool for looking at a range of frames to determine whether or not a video *appears to be* interlaced. This Applescript takes an input folder, passes every file it finds to ffmpeg to run this test, and puts the paths of the results it finds in a text file on the Desktop. (Why? Because I'm better at Applescript than most other languages and I do my processing off a networked drive on my Windows PC.)

## To run
* Open Script Editor on your Mac
* Paste in the contents from [Find Interlaced Videos.scpt](https://github.com/verbiate/Find-Interlaced-Videos/blob/main/Find%20Interlaced%20Videos.scpt)
* Hit CMD+R (or click Run)
* Choose a folder to scan. It will scan this folder and all subfolders.
* Results will appear in a file named Interlaced.txt on your Desktop
* When the script has finished running, you will hear a ding and Script Editor will show a modal telling you the scan is complete.

## Known issues
* The script uses Finder for scanning subfolders, which is inefficient. Because of this, large folders (esp. those with many subfolders) may make the script time out. Until this script is updated, try running the script multiple times, scanning fewer files at once. All results will be added to Interlaced.txt
* The script will scan every file it finds, not only videos. This may lead to false positives.
* ~~ffmpeg is able to determine whether videos are Top Frame First or Bottom Frame First (TFF or BFF). The script currently ignores this.~~
* It's Mac-only. Ideally, this would run on PC. This could even be yoked together with the VEAI CLI to find files and process them in one fell swoop. For a similar project, check out this blog post by [Nicholas Hillegeer](http://www.aktau.be/2013/09/22/detecting-interlaced-video-with-ffmpeg/).
