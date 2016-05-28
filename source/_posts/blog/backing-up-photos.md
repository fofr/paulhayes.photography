layout: blog
title: Backing up photos
date: 2016-05-28

description: "I don’t like to delete things, especially not photos. I also shoot in RAW and JPG; I keep the JPG files for quick sharing to my phone, social network posts, etc. Holding down the shutter can very quickly create gigabytes of photos. How do I backup gigabytes of photos safely?"
---

I don’t like to delete things, especially not photos. I also shoot in RAW and JPG; I keep the JPG files for quick sharing to my phone, social network posts, etc. Holding down the shutter can very quickly create gigabytes of photos.

How do I backup gigabytes of photos safely?

## External hard-drives

I have two 4tb external drives, and I use [Seagate](http://amzn.to/1NV27l0) drives after an unreliable Western Digital one gave up when it was too young. One of these drives is a backup of the other, and the two are kept in sync.

I keep the two drives synchronised using a UNIX tool called [Rsync](https://en.wikipedia.org/wiki/Rsync) – it’s for synchronising files. I run the following script (all on one line) from a [terminal on my Mac](http://www.macworld.co.uk/feature/mac-software/get-more-out-of-os-x-terminal-3608274/):
```
rsync -av /Volumes/[hard drive name]/ /Volumes/[backup hard drive]/
```

The `-a` means [archive mode](http://serverfault.com/questions/141773/what-is-archive-mode-in-rsync), it’s the perfect option for backups. The `-v` simply means `verbose`. It will display on screen what it’s doing.

If something has been deleted or moved on the main hard drive, those changes will also appear on the backup. If you’re not sure what’s going to happen when you run the script (perhaps you deleted something you shouldn’t have), you can do a "dry run", which changes nothing, but tells you what it would have done:

```
rsync -av --dry-run /Volumes/[hard drive name]/ /Volumes/[backup hard drive]/
```

### Offsite backups

I have a couple of spare drives I’m not using, occasionally I’ll run a script like the one above to copy the entire contents of a few folders to one of these drives, and I’ll leave it at a friend’s place. You can’t be too careful.

## Online backups

I used to have a single 2tb Western Digital drive for my photos, and when this broke 6 months after purchase I might have lost everything, had I not kept online backups too.

For online backups I use Dropbox. For [£7.99 a month](https://www.dropbox.com/plans) I get 1tb of online storage. It’s hard to get more than that, unless you pay for the business plan or purchase another account.

I use a similar `rsync` script to move files on and off of Dropbox. Having photos on Dropbox means they’re easy to share, and with the Dropbox app they can be quickly downloaded to your phone (eg to post to Instagram). The whole thing is relatively simple.

With so many pictures it’s also useful to search them. I’ve uploaded low resolution JPGs to [Google Photos](https://photos.google.com/). This becomes a  free tertiary online backup, but it also lets me find things easily, like all pictures of "[Brighton Pavilion](/photos/brighton-pavilion-twilight/)”, without having to tag them all. You can backup RAW files too, but then you need to pay.

In the past I’ve also tried [Arq](https://www.arqbackup.com/), a cloud backup tool for Mac, which I used in combination with an [Amazon Glacier](https://aws.amazon.com/glacier/pricing/) account. That cost $0.007/GB per month, but the files aren’t easily accessible and to restore them would take many hours.

## Apps that manage your photos

I avoid these like the plague. I simply don’t trust them. One corrupt library, or a badly applied filter to "all selected photos", and you’ve had it. Or perhaps the software gets discontinued, *cough* _Aperture_, or sometimes it just works really badly with hard drives you’re regularly adding and removing.

I learnt this lesson a long time ago when I let iTunes manage my music and it all mysteriously disappeared. Never again.

## Backing up while travelling

This is where I’ve struggled. There doesn’t seem to be an easy way to get photos off a memory card and onto a portable drive or the internet without carrying around a laptop. Adding an expensive laptop to a bag with a lot of camera gear is a choice I'd like to sometimes avoid. If anyone has any good tactics, [please get in touch](/contact/).

I've tried a USB powered SD card reader connected to an Android phone, and an SSH/FTP app to sync them to some online storage. The apps would inevitably crash and the process would need to start again. I’ve tried using Dropbox and an iPad or iPhone with an SD card reader – but that workflow is designed for one picture at a time, copying them all is time consuming, and only works with JPGs.

For now I keep lots of separate 32GB memory cards, and I try to keep them safe.
