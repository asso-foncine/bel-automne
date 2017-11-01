require 'date'
require 'RMagick'
require 'lorem_ipsum_amet'

include Magick

class Sample
     
    @@img_dir = "img"
    @@post_dir = "posts"
    @@task_dir = "tasks"
    @@story_dir = "story"
    @@album_dir = "albums"

    def initialize()  

        if !Dir.exist?(@@img_dir)
            Dir::mkdir(@@img_dir, 0777)
        end     
        [@@img_dir, @@post_dir, @@task_dir, @@story_dir, @@album_dir].each do |dir|
            if !Dir.exist?(dir)
                Dir::mkdir(dir, 0777)
            end  
        end 
        [@@post_dir, @@task_dir, @@story_dir, @@album_dir].each do |dir|
            path = @@img_dir + "/" + dir
            if !Dir.exist?(path)
                Dir::mkdir(path, 0777)
            end  
        end     
    end

    def genPosts(nb = 10)

        if  !Dir.exist?(@@post_dir)
            Dir::mkdir(@@post_dir, 0777)
        end        
        idx = 1
        nb.times do 
            date = Date.new(2017,1,1).next_day(idx)
            dateTime = DateTime.new(2017,1,1).next_day(idx)
            postName = date.to_s + "-exemple-article-" + idx.to_s + ".md"
            postFile = @@post_dir + "/" + postName
            puts postFile
            puts dateTime.iso8601
            if !File.exist?(postFile)
                file = File.open(postFile, "w")
                file << "---"  + "\n"
                file << "layout: post" + "\n"
                file << "title: Exemple d'article " + idx.to_s + "\n"
                file << "date: " + dateTime.iso8601 + "\n"
                file << "categories: sample test" + "\n"
                file << "intro: Introduction à l'article exemple " + idx.to_s + "\n"
                file << "---" + "\n"
                file << "\n"
                file << "# " + LoremIpsum.lorem_ipsum(w: 4) + "\n"
                file << "![](/assets/img/posts/sample/sample.jpg)\n\n"
                file << ">" + LoremIpsum.lorem_ipsum(w: 40) + "\n"
                file << "\n"
                file << "\n"
                file << LoremIpsum.lorem_ipsum(w: 250) + "\n"
            end
            idx += 1
        end
    end

    def genTasks(nb = 7)
        if  !Dir.exist?(@@task_dir)
            Dir::mkdir(@@task_dir, 0777)
        end        
        idx = 1
        nb.times do 
            taskIdx = idx * 10
            taskName = taskIdx.to_s + "-activity-" + idx.to_s
            taskFile = @@task_dir + "/" + taskName + ".md"
            taskAsset = @@img_dir + "/" + @@task_dir + "/" + taskName
            if !Dir.exist?(taskAsset)
                Dir::mkdir(taskAsset, 0777)
            end   
            taskThumb = taskAsset + "/thumb.jpg"
            puts "generating sample task: " + taskName
            taskImg1 = taskAsset + "/1.jpg"
            taskImg2 = taskAsset + "/2.jpg"

            file = File.open(taskFile, "w")
            file << "---"  + "\n"
            file << "layout: task" + "\n"
            file << "title: Activité " + idx.to_s + "\n"
            file << "description: | \n"
            file << "   " + LoremIpsum.lorem_ipsum(w: 40) + "\n"
            file << "---" + "\n\n"
            file << "# " + LoremIpsum.lorem_ipsum(w: 4) + "\n"
            
            file << "![](/assets/" + taskImg1 + ")" + "\n\n"
            file << LoremIpsum.lorem_ipsum(w: 100) + "\n\n"
            file << "![](/assets/" + taskImg2 + ")" + "\n\n"
            file << ">" + LoremIpsum.lorem_ipsum(w: 30) + "\n"
            file << "\n"
            genImage(550, 450, taskName, taskThumb)
            genImage(640, 480, 'task-image-1', taskImg1)
            genImage(200, 200, 'task-image-1', taskImg2)
            idx += 1
        end
    end

    def genStory(nb = 5)     
        idx = 1
        nb.times do 
            storyIdx = idx * 10
            storyName = storyIdx.to_s + "-story-" + idx.to_s
            puts "generating sample story: " + storyName
            storyFile = @@story_dir + "/" + storyName + ".md"
            storyAsset = @@img_dir + "/" + @@story_dir + "/" + storyName
            storyImg = @@img_dir + "/" + @@story_dir + "/" + storyName + ".jpg"

            file = File.open(storyFile, "w")
            file << "---"  + "\n"
            file << "title: Section " + idx.to_s + "\n"
            file << "---" + "\n"
            file << "\n"
            file << "# " + LoremIpsum.lorem_ipsum(w: 4) + "\n\n"
            
            file << "![](/assets/" + storyImg + ")" + "\n\n"
            file << LoremIpsum.lorem_ipsum(w: 500) + "\n"
            genImage(640, 480, 'section-image-'+ idx.to_s, storyImg)
            idx += 1
        end
    end

    def gentAlbums(nb = 6, imgs = 25)
        idx = 1
        nb.times do 
            date = Date.new(2017,1,1).next_day(idx)
            dateTime = DateTime.new(2017,1,1).next_day(idx)
            albumName = "album-" + idx.to_s
            puts "generating sample album: " + albumName
            albumFile = @@album_dir + "/" + albumName + ".md"
            albumAsset = @@img_dir + "/" + @@album_dir + "/" + albumName
            if !Dir.exist?(albumAsset)
                Dir::mkdir(albumAsset, 0777)
            end   

            file = File.open(albumFile, "w")
            file << "---"  + "\n"
            file << "layout: album" + "\n"
            file << "date: " + dateTime.iso8601 + "\n"
            file << "title: Album " + idx.to_s + "\n"
            file << "intro: " + LoremIpsum.lorem_ipsum(w: 6) + "\n"
            file << "thumb: 1.jpg" + "\n"
            file << "auto_increment:" + "\n"
            file << "   size: " + imgs.to_s + "\n"
            file << "---" + "\n"
            file << "\n"
            file << "## " + LoremIpsum.lorem_ipsum(w: 4) + "\n\n"
            file << LoremIpsum.lorem_ipsum(w: 20) + "\n"
            imgIdx = 1
            imgs.times do
                imgPath =  albumAsset + "/" + imgIdx.to_s + ".jpg"
                genImage(1280, 800, "album"+ idx.to_s + "-img"+ imgIdx.to_s, imgPath)
                imgIdx += 1
            end
            idx += 1
        end
    end

    def genImage(w = 1280, h = 800, msg = "message", out = "sample.jpg")
        puts "gen image in "+out
        size = w.to_s + "x" + h.to_s
        col1 = "%06x" % (rand * 0xffffff)
        col2 = "%06x" % (rand * 0xffffff)
        imgSpec = "gradient:#" + col1 + "-#" + col2
        #puts imgSpec
        sample = ImageList.new(imgSpec) { self.size =  size}
        #sample = ImageList.new("netscape:") { self.size =  size}

        text = Draw.new
        text.font_family = 'tahoma'

        text.pointsize = w / 17
        text.gravity = CenterGravity
        text.annotate(sample, 0,0,0,-w/8, "/assets/"+out) {
            self.fill = 'white'
        }
        text.pointsize = w / 17
        #text.gravity = NorthGravity
        text.annotate(sample, 0,0,0,w/8, "Taille: "+size) {
            self.fill = 'white'
        }
        text.pointsize = w / 10
        #text.gravity = CenterGravity
        text.annotate(sample, 0,0,0,0, msg) {
            self.fill = 'white'
        }
        
        sample.write(out) {
            self.quality = 75
            self.compression = JPEG2000Compression
        }
    end

    def genHomeImages()
        genImage(1200, 1000, 'Image présentation 1', 'img/home/parallax-1-1200.jpg')
        genImage(1200, 1000, 'Image présentation 2', 'img/home/parallax-2-1200.jpg')
        genImage(800, 640, 'Image présentation 1', 'img/home/parallax-1-800.jpg')
        genImage(800, 640, 'Image présentation 2', 'img/home/parallax-2-800.jpg')
        genImage(600, 540, 'Image présentation 1', 'img/home/parallax-1-600.jpg')
        genImage(600, 540, 'Image présentation 2', 'img/home/parallax-2-600.jpg')
        genImage(400, 360, 'Image présentation 1', 'img/home/parallax-1-400.jpg')
        genImage(400, 360, 'Image présentation 2', 'img/home/parallax-2-400.jpg')

        genImage(250, 300, 'Image carte', 'img/home/card.jpg')
        
        genImage(250, 300, 'Image carte', 'img/home/card.jpg')
    end

end

sample = Sample.new

sample.genHomeImages()
##sample.genPosts(22)
##sample.genTasks
##sample.genStory
#sample.gentAlbums()